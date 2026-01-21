module App(runApp) where 

import Control.Monad.Reader (ReaderT, runReaderT, liftIO)
import Database.SQLite.Simple (Connection, open)
import System.Environment (getEnv)

data AppEnv = AppEnv {
  dbPool :: Connection 
}

type AppM = ReaderT AppEnv IO

runApp :: IO()
runApp = do 
  dbConn <- getEnv "HSPUSH_SQLITE_DB"
  conn <- open dbConn 
  let env = AppEnv conn 
  runReaderT app env 

app :: AppM ()
app = do 
  liftIO $ putStrLn "Yes"