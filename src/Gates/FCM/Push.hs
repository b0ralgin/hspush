{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Gates.FCM.Push (
  mkPusher,
) where 

import qualified Data.Text as T
import Types (AppM,PushError(..), TokenProviderError (..), TokenProvider (fetchToken), Pusher (..), JWT (..))
import Text.Printf (printf)
import Data.Aeson (object, ToJSON (toJSON), (.=))
import Network.HTTP.Simple (setRequestMethod, setRequestBodyJSON, httpJSONEither, getResponseStatusCode, httpNoBody, setRequestBearerAuth, Request, Response)
import Data.ByteString.Char8 (pack)
import Domain (Push(..))
import Data.Map
import Prelude hiding (null)
import Network.HTTP.Simple (parseRequest_, httpJSON)

mkPusher :: TokenProvider IO -> String  ->  Pusher 
mkPusher  tokenProvider projectID= Pusher {
    send = (\push -> do 
      token <- fetchToken tokenProvider
      case token of 
        Left err -> do
            case err of 
              ParseError perr -> return $ Just (PushError  perr)  
              NetworkError code -> return $ Just $ PushError  "network err" 
              InvalidToken -> return $ Just $ PushError "invalid token"
        Right t -> 
          sendPushFCM t projectID push 
          -- TODO: add force updating token and trying one more time 
    )   
  }

pushURL :: String  -> String 
pushURL = printf "https://fcm.googleapis.com/v1/projects/%s/messages:send"


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

sendPushFCM :: JWT -> String ->  Push-> IO (Maybe PushError)
sendPushFCM  token projectID (Push deviceID title body data') = do
      _ <- putStrLn $ show token
      let req =   mkRequest 
            (pushURL projectID) 
            token 
            (PushRequest deviceID title body (mapData data')) 
      result <- httpNoBody req
      _ <- putStrLn $ show result
      case getResponseStatusCode result of 
        200 -> return $ Nothing
        201 -> return $ Nothing
        401 -> return $ Just $ AuthorizaionError 
        code -> return $ Just $ getNetworkErr code 
  where 
    getNetworkErr   500 = PushError "internal error"
    getNetworkErr  400 = PushError "bad request"
    getNetworkErr  code = PushError $ "http code" ++ show code 
    mapData m = 
      if length  m >0 then 
        Just (fromList m)
      else 
        Nothing
    mkRequest url (JWT token) pr =
        let initReq = parseRequest_ $ url 
        in
        setRequestMethod "POST" $
          setRequestBearerAuth (pack token) $ 
            setRequestBodyJSON pr 
              initReq
