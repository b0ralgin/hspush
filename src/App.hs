{-# LANGUAGE RankNTypes #-}
module App (runApp, AppM, AppEnv (..)) where

import Control.Monad.Reader (ReaderT, ask, asks, liftIO, runReaderT)
import qualified Data.ByteString.Lazy as BL
import Gates.Grpc.Server (methods)
import MyLogger (mkStdoutLogger, Logger (logInfo, logError), LogField (LogField), mkNoopLogger)
import Network.GRPC.Common
import Network.GRPC.Server.Run hiding (runServer)
import Network.GRPC.Server.StreamType
import System.Environment (getEnv)
import Types
import Control.Concurrent (threadDelay)
import Control.Concurrent.Async (async, wait, race_)
import Cases (processTaskCase, processfakeTaskCase)
import Control.Monad (forever)
import Network.GRPC.Server (ServerParams(ServerParams, serverTopLevel), RequestHandler)
import Control.Exception (SomeException, catch)
import Database.Sqlite.Easy (createSqlitePool, ConnectionString(..))
import qualified Data.Text as T

runApp :: IO ()
runApp = do
  dbFile <- getEnv "HSPUSH_SQLITE_DB"
  conn <- createSqlitePool (ConnectionString $ T.pack dbFile)
  gsFile <- getEnv "HSPUSH_GOOGLE_SECRETS_FILE"
  putStrLn gsFile
  fileContent <- BL.readFile gsFile
  googleID <- getEnv "HSPUSH_GOOGLE_ID"
  
  let env = AppEnv conn mkNoopLogger fileContent googleID
  let wenv = AppEnv conn mkStdoutLogger fileContent googleID
  race_ (runReaderT runServer env) (runReaderT runWorker wenv)
  

runServer :: AppM ()
runServer = do
  env <- ask
  log <- asks logger
  liftIO $ logInfo log "Grpc server is starting" [(LogField "port" defaultInsecurePort)]
  let d = def{
    serverTopLevel= logExceptions log
  }
  liftIO $ runServerWithHandlers d config $ fromMethods (methods env)
  where
    config ::   ServerConfig
    config =
      ServerConfig
        { serverInsecure = Just (InsecureConfig (Just "0.0.0.0") defaultInsecurePort),
          serverSecure = Nothing
        }

logExceptions :: Logger -> RequestHandler () -> RequestHandler ()
logExceptions log h unmask req resp = h unmask req resp `catch` handler
  where
    handler :: SomeException -> IO ()
    handler e = do 
      logError log "caught exception" [(LogField "exception" e )]
      return ()

runWorker :: AppM ()
runWorker = do 
  log <- asks logger
  liftIO $ logInfo log "worker is starting" []
  forever $ do  
    liftIO $ logInfo log "worker processing" []
    count <- processfakeTaskCase 
    liftIO $ logInfo log "worker is done" [(LogField "amount of processed events" count)]
    liftIO $ threadDelay (1000000)
