module Types (AppEnv(..), AppM(..)) where 
import Database.SQLite.Simple (Connection)
import MyLogger (Logger)
import Control.Monad.Reader (ReaderT)

data AppEnv = AppEnv {
  dbPool :: Connection, 
  logger :: Logger 
}

type AppM = ReaderT AppEnv IO


