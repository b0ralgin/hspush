{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE InstanceSigs #-}
module Gates.FCM.Push (sendPushFCM)  where

import Gates.FCM.Oauth (getJWTToken, OauthError(ParseError, NetworkError, InvalidToken), JWT(..))
import qualified Data.Text as T
import Types (AppM, AppEnv (googleID), PushMonad(..), PushError(..))
import Network.HTTP.Client.Conduit (parseRequest)
import Text.Printf (printf)
import Control.Monad.Reader (asks, liftIO)
import Data.Aeson (object, ToJSON (toJSON), (.=), decode, encode)
import Network.HTTP.Simple (setRequestMethod, setRequestBodyJSON, httpJSONEither, getResponseStatusCode, httpNoBody, setRequestBearerAuth)
import Data.ByteString.Char8 as BS hiding (putStrLn)
import Domain (Push(..), PushData)
import Data.Map


instance PushMonad AppM where 
    sendPush = sendPushFCM

pushURL :: String  -> String 
pushURL projectID = printf "https://fcm.googleapis.com/v1/projects/%s/messages:send" projectID


data PushRequest = PushRequest {
  token :: String ,
  title :: T.Text ,
  body :: T.Text,
  data' :: Maybe (Map String T.Text)
}


instance ToJSON PushRequest where 
  toJSON (PushRequest token title body data') = 
    object ["message" .= object ["token" .= token, "notification" .= notification]]
    where notification = 
              object $ ["title" .= title, "body" .= body] <> maybe [] (\d -> ["data" .= d]) data'
sendPushFCM :: Push-> AppM (Maybe PushError)
sendPushFCM  (Push deviceID title body data') = do
  token <- getJWTToken 
  projectID <- asks googleID
  case token of 
    Left err -> do
        case err of 
          ParseError perr -> return $ Just (PushError "token" perr)  
          NetworkError code -> return $ Just $ getNetworkErr "token" code 
          InvalidToken -> return $ Just $ InvalidTokenErr
    Right (JWT t) -> do
      initReq <- parseRequest $ pushURL projectID
      let request = 
            setRequestMethod "POST" $
            setRequestBearerAuth (BS.pack t) $ 
              setRequestBodyJSON (PushRequest deviceID title body (mapData data') ) 
                initReq
      liftIO $ putStrLn $ show $ encode (PushRequest deviceID title body (mapData data') )  
      liftIO $ putStrLn $ show $ request
      result <- httpNoBody request
      liftIO $ putStrLn $ show result
      case getResponseStatusCode result of 
        200 -> return $ Nothing
        201 -> return $ Nothing
        code -> return $ Just $ getNetworkErr "push" code 
      return Nothing
  where 
    getNetworkErr from  500 = PushError from "internal error"
    getNetworkErr from 400 = PushError from "bad request"
    getNetworkErr from code = PushError from $ "http code" ++ show code 
    mapData d = 
      if (Prelude.length d) >0 then 
        Just ((fromList data'))
      else 
        Nothing

