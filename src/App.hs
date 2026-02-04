module App (runApp, AppM, AppEnv (..)) where

import Control.Monad.Reader (ReaderT, ask, liftIO, runReaderT)
import qualified Data.ByteString.Lazy as BL
import Database.SQLite.Simple (Connection, open)
import Gates.Grpc.Server (methods)
import MyLogger (mkStdoutLogger)
import Network.GRPC.Common
import Network.GRPC.Server.Run hiding (runServer)
import Network.GRPC.Server.StreamType
import System.Environment (getEnv)
import Types
import Control.Concurrent (threadDelay)
import Control.Concurrent.Async (async, wait, race_)
import Cases (processTaskCase)
import Control.Monad (forever)

runApp :: IO ()
runApp = do
  dbConn <- getEnv "HSPUSH_SQLITE_DB"
  conn <- open dbConn
  gsFile <- getEnv "HSPUSH_GOOGLE_SECRETS_FILE"
  putStrLn gsFile
  fileContent <- BL.readFile gsFile
  googleID <- getEnv "HSPUSH_GOOGLE_ID"
  
  let env = AppEnv conn mkStdoutLogger fileContent googleID
  race_ (runReaderT runServer env) (runReaderT runWorker env)
  

runServer :: AppM ()
runServer = do
  env <- ask
  liftIO $ runServerWithHandlers def config $ fromMethods (methods env)
  where
    config :: ServerConfig
    config =
      ServerConfig
        { serverInsecure = Just (InsecureConfig (Just "0.0.0.0") defaultInsecurePort),
          serverSecure = Nothing
        }

runWorker :: AppM ()
runWorker = forever $ do  
  processTaskCase 
  liftIO $ threadDelay (1000000)
