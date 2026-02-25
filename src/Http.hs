module Http where

import Data.Aeson (FromJSON)
import Network.HTTP.Simple (Request, Header)
import Data.ByteString.Lazy (LazyByteString)


data Response a = Response {
  responseCode :: !Int,
  responseHeaders :: [Header],
  responseBody :: a 
} deriving (Show)


class Monad m => HttpClient m where 
  sendJSON :: (FromJSON a) => Request -> m (Response a)
  sendNoBody :: Request -> m (Response ())
  sendLBS :: Request -> m (Response LazyByteString)

