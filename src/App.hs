
module App(runApp, AppM, AppEnv(..)) where 

import Control.Monad.Reader (ReaderT, runReaderT, liftIO)
import Database.SQLite.Simple (Connection, open)
import System.Environment (getEnv)
import Cases(addDeviceCase)
import Types
import MyLogger (mkStdoutLogger)
import Domain (UserID(UserID), Platform (Andorid), mkDevice)

runApp :: IO()
runApp = do 
  dbConn <- getEnv "HSPUSH_SQLITE_DB"
  conn <- open dbConn 
  let env = AppEnv conn mkStdoutLogger
  runReaderT app env 

app :: AppM ()
app = do 
  addDeviceCase $ mkDevice (UserID "1") "ab" Andorid

