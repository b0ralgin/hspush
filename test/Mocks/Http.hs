{-# LANGUAGE FlexibleInstances #-}
module Mocks.Http where
import qualified Data.Map as M
import Network.HTTP.Simple (Request)
import Http (Response(..), HttpClient(..))
import Control.Monad.State
import Data.ByteString (ByteString)
import Data.Aeson (decode, decode', decodeStrict, eitherDecodeStrict)

instance  Eq Request where 
  (==) = (\r1 r2 -> (show r1 == show r2))

newtype MockResponse = MockResponse (Response ByteString)

newtype MockState = MockState [(Request,MockResponse)]

newtype SimpleHttpMock = SimpleHttpMock (Int, ByteString)

instance HttpClient (State (MockState)) where 
  sendJSON = (\req -> do 
      MockState mocks <- get 
      case lookup req mocks of 
        Nothing -> error "no such request"
        Just (MockResponse resp) -> 
          case eitherDecodeStrict (responseBody resp) of 
            Left err -> error err 
            Right res -> return $ Response (responseCode resp) (responseHeaders resp) res
    )
  sendNoBody = (\req -> do 
     MockState mocks <- get 
     case lookup req mocks of 
        Nothing -> error "no such request"
        Just (MockResponse resp) -> return $ Response (responseCode resp) (responseHeaders resp) ()
    )
  
instance HttpClient (StateT SimpleHttpMock IO) where 
  sendJSON = (\_ -> do 
    SimpleHttpMock (code, body) <- get 
    case eitherDecodeStrict body of 
            Left err -> error err 
            Right res -> return $ Response code [] res
    )
  sendNoBody = (\req -> do 
    SimpleHttpMock (code, _) <- get 
    return $ Response code [] ()
    )
  