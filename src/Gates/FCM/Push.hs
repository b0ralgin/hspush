{-# LANGUAGE OverloadedStrings #-}
module Gates.FCM.Push  where

import Gates.FCM.Oauth (getJWTToken, OauthError(ParseError, NetworkError, InvalidToken), JWT(..))
import qualified Data.Text as T
import Types (AppM, AppEnv (googleID))
import Network.HTTP.Client.Conduit (parseRequest)
import Text.Printf (printf)
import Control.Monad.Reader (asks, liftIO)
import Data.Aeson (object, ToJSON (toJSON), (.=), decode, encode)
import Network.HTTP.Simple (setRequestMethod, setRequestBodyJSON, httpJSONEither, getResponseStatusCode, httpNoBody, setRequestBearerAuth)
import Data.ByteString.Char8 as BS hiding (putStrLn)


data PushError = PushError String String | InvalidTokenErr deriving Show 

pushURL :: String  -> String 
pushURL projectID = printf "https://fcm.googleapis.com/v1/projects/%s/messages:send" projectID


data PushRequest = PushRequest {
  token :: String ,
  title :: String ,
  body :: T.Text 
}

instance ToJSON PushRequest where 
  toJSON (PushRequest token title body) = object ["message" .= object ["token" .= token, "notification" .= object ["title" .= title, "body" .= body]]]

sendPush :: String  -> String -> T.Text -> AppM (Maybe PushError)
sendPush deviceID title txt = do
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
              setRequestBodyJSON (PushRequest deviceID title txt) 
                initReq
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

