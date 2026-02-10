{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Types (AppEnv(..), AppM, DB(..), PushMonad(..), PushError(..), runAppM) where 
import MyLogger (Logger)
import Control.Monad.Reader (ReaderT (runReaderT), MonadIO, MonadReader)
import Data.ByteString.Lazy (ByteString)
import Domain (Device, UserID, Push)
import qualified Data.Text as T
import Control.Monad.Catch (MonadThrow, MonadCatch)

data PushError = PushError String String | InvalidTokenErr deriving Show 
class Monad m => PushMonad m where 
  sendPush :: Push -> m (Maybe PushError)

data AppEnv = AppEnv {
  db :: DB,
  logger :: Logger ,
  googleSecrets :: ByteString,
  googleID :: String
}

newtype AppM a = AppM (ReaderT AppEnv IO a)
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader AppEnv, MonadThrow  , MonadCatch )

runAppM :: AppM a -> AppEnv -> IO a 
runAppM (AppM m) = runReaderT m

data DB = DB {
  addDevice :: Device -> IO (),
  getDevices :: UserID -> IO [Device],
  saveTask :: UserID -> Push -> IO (),
  processTask :: (Push -> IO ()) -> IO ()
}
