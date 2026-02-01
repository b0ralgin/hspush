module App(runApp, AppM, AppEnv(..)) where 

import Control.Monad.Reader (ReaderT, runReaderT, liftIO)
import Database.SQLite.Simple (Connection, open)
import System.Environment (getEnv)
import Cases(addDeviceCase)
import Types
import MyLogger (mkStdoutLogger)
import Domain (UserID(UserID), Platform (Andorid), mkDevice)
import qualified Data.ByteString.Lazy as BL
import Gates.FCM.Push
import qualified Data.Text as T

runApp :: IO()
runApp = do 
  dbConn <- getEnv "HSPUSH_SQLITE_DB"
  conn <- open dbConn
  gsFile <- getEnv  "HSPUSH_GOOGLE_SECRETS_FILE"
  putStrLn gsFile
  fileContent <-  BL.readFile gsFile
  googleID <- getEnv "HSPUSH_GOOGLE_ID"
  let env = AppEnv conn mkStdoutLogger fileContent googleID
  runReaderT app env 

app :: AppM ()
app = do 
  result <- sendPush "cVOk2V9KSyuybE_XfqVIy8:APA91bHw3i8LVe5-AC38NmtGXqb6F8pQWaqBrcKPTYXsDgvakYM0bVYideHMapXWpYOzXHefSC47HUsoAw6r5MoUa00ilevkEMJ395KiegITiWINi85GEX4" "test" $ T.pack "test notification"
  liftIO $ putStrLn $ show result
  return ()
