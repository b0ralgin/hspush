module Types (AppEnv(..), AppM) where 
import Database.SQLite.Simple (Connection)
import MyLogger (Logger)
import Control.Monad.Reader (ReaderT)
import Data.ByteString.Lazy (ByteString)

data AppEnv = AppEnv {
  dbPool :: Connection, 
  logger :: Logger ,
  googleSecrets :: ByteString,
  googleID :: String
}

type AppM = ReaderT AppEnv IO


