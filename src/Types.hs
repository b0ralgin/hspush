module Types (AppEnv(..), AppM) where 
import Database.Sqlite.Easy (Pool, Database)
import MyLogger (Logger)
import Control.Monad.Reader (ReaderT)
import Data.ByteString.Lazy (ByteString)

data AppEnv = AppEnv {
  dbPool :: Pool Database, 
  logger :: Logger ,
  googleSecrets :: ByteString,
  googleID :: String
}

type AppM = ReaderT AppEnv IO


