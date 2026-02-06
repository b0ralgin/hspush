module Types (AppEnv(..), AppM, DB(..)) where 
import Database.Sqlite.Easy (Pool, Database)
import MyLogger (Logger)
import Control.Monad.Reader (ReaderT)
import Data.ByteString.Lazy (ByteString)
import Domain (Device, UserID, Task)

data AppEnv = AppEnv {
  db :: DB,
  logger :: Logger ,
  googleSecrets :: ByteString,
  googleID :: String
}

type AppM = ReaderT AppEnv IO


data DB = DB {
  addDevice :: Device -> IO (),
  getDevices :: UserID -> IO [Device],
  saveTask :: UserID -> Task -> IO (),
  processTask :: (Task -> IO ()) -> IO ()
}

