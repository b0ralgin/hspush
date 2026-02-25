{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs #-}
module Types (
  AppEnv(..),
  WorkerEnv(..),
   AppM, 
   DB(..), 
   PushError(..), 
   TokenProvider(..), 
   TokenProviderError(..), 
   Pusher(..),
   JWT(..),
   isValid,
   runAppM, 
   HasDB(getDB),
   HasLogger(getLogger), 
   HasPusher(getPusher),
) where 
import MyLogger (Logger)
import Control.Monad.Reader (ReaderT (runReaderT), MonadIO, MonadReader)
import Domain (Device, UserID, Push)
import Control.Monad.Catch (MonadThrow, MonadCatch)
import Http (HttpClient (..), Response (Response))
import Network.HTTP.Simple (httpJSON, getResponseStatusCode, getResponseHeaders, getResponseBody, httpNoBody, httpLBS)

newtype JWT = JWT String deriving (Show, Eq)

isValid :: JWT -> Bool 
isValid (JWT token) = 
  length token > 0 

data PushError = PushError String | AuthorizaionError  deriving (Show, Eq) 
data TokenProviderError = ParseError String | NetworkError Int | InvalidToken deriving (Show, Eq)

data AppEnv = AppEnv {
  db :: DB,
  logger :: Logger
}

data WorkerEnv = WorkerEnv {
  pusher :: Pusher,
  appEnv :: AppEnv
}

class HasDB env where 
  getDB :: env -> DB 

class HasLogger env where 
  getLogger :: env -> Logger 

class HasPusher env where 
  getPusher :: env -> Pusher 

instance HasDB AppEnv where getDB = db 

instance HasLogger AppEnv where getLogger = logger 
instance HasDB WorkerEnv where getDB = getDB. appEnv 
instance HasLogger WorkerEnv where getLogger = getLogger . appEnv
instance HasPusher WorkerEnv where getPusher = pusher

newtype AppM env a = AppM (ReaderT env IO a)
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader env, MonadThrow  , MonadCatch )

runAppM :: AppM env a -> env  -> IO a 
runAppM (AppM m) = runReaderT  m

data DB = DB {
  addDevice :: Device -> IO (),
  getDevices :: UserID -> IO [Device],
  saveTask :: UserID -> Push -> IO (),
  processTask :: (Push -> IO ()) -> IO ()
}

data Pusher = Pusher {
  send :: Push -> IO (Maybe PushError)
}

data TokenProvider m = TokenProvider {
  fetchToken :: m (Either TokenProviderError JWT)
}


instance HttpClient IO  where 
  sendJSON = (\req -> do 
    res <- httpJSON req 
    return (Response (getResponseStatusCode res) (getResponseHeaders res) (getResponseBody res)) 
    )
  sendNoBody = (\req -> do
      res <- httpNoBody req 
      return (Response (getResponseStatusCode res) (getResponseHeaders res) ()) 
    )
  sendLBS = (\req -> do
    res <- httpLBS req 
    return (Response (getResponseStatusCode res) (getResponseHeaders res) (getResponseBody res))
    )