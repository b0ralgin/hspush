module App(runApp, AppM, AppEnv(..)) where 

import Control.Monad.Reader (ReaderT, runReaderT, liftIO, ask)
import Database.SQLite.Simple (Connection, open)
import System.Environment (getEnv)
import Cases(addDeviceCase)
import Types
import MyLogger (mkStdoutLogger)
import Domain (UserID(UserID), DevicePlatform (Andorid), mkDevice)
import qualified Data.ByteString.Lazy as BL
import Gates.FCM.Push
import qualified Data.Text as T
import Gates.Grpc.Server (methods)
import Network.GRPC.Common
import Network.GRPC.Common.Protobuf
import Network.GRPC.Server.Protobuf
import Network.GRPC.Server.Run
import Network.GRPC.Server.StreamType
import Gates.Grpc.Proto.Server (PushService)

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
  env <- ask
  liftIO $ runServerWithHandlers def config $ fromMethods (methods env)
  where
    config :: ServerConfig
    config = ServerConfig {
          serverInsecure = Just (InsecureConfig (Just "0.0.0.0") defaultInsecurePort)
        , serverSecure   = Nothing
        }
