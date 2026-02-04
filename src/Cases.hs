module Cases (addDeviceCase, getDeviceCase, sendPushCase, processTaskCase) where 
import Domain (UserID, Device, Task (..))
import Storage (addDevice, getDevice, processTask, saveTask)
import Types(AppM, AppEnv(dbPool, logger))
import MyLogger (Logger(..), LogField (LogField))
import Control.Monad.Reader (asks, withReaderT, liftIO, MonadReader (ask), ReaderT (runReaderT))
import Gates.FCM.Push (sendPush)
import qualified Data.Text as T
import GHC.IORef (IORef(IORef))
import Data.IORef

addDeviceCase :: Device -> AppM () 
addDeviceCase device = do 
  pool <- asks dbPool
  log <- asks logger 
  res <- withReaderT (const pool) $ addDevice device 
  case res of 
    Left e ->  
      liftIO $ logError log "Failed to add device. Error:" [(LogField "error" e), (LogField "device" device)] 
    Right _ -> 
      liftIO $  logInfo log "Device added" [(LogField "device" device)]
  return ()

getDeviceCase :: UserID -> AppM [Device]
getDeviceCase userid = do
  pool <- asks dbPool 
  log <- asks logger
  liftIO $ logInfo log "get devices by user" [(LogField "user" userid)]
  res <-   withReaderT (const pool) $ getDevice userid
  liftIO $ logInfo log "amount of devices" [(LogField "user" userid), (LogField "amount" $ length res)]
  return res


sendPushCase :: UserID -> String -> String -> AppM ()
sendPushCase userid title' body' = do 
  pool <- asks dbPool
  log <- asks logger 
  liftIO $ logInfo log "add push notification" [(LogField "user" userid), (LogField "title" title') , (LogField "body" body')]
  res <- withReaderT (const pool) $ saveTask userid title' body'
  case res of 
    Left err -> liftIO $ logError log "get devices by user" [(LogField "user" userid), (LogField "error" err)]
    Right _ -> return ()

processTaskCase :: AppM Int
processTaskCase = do 
  pool <- asks dbPool
  env <- ask
  countRef <- liftIO $ newIORef 0
  withReaderT (const pool) $ processTask (\(Task _ device' title' body') -> do
                                                    runReaderT (sendPush device' title' $ T.pack body') env  
                                                    liftIO $ modifyIORef countRef (+1)
                                                )
  liftIO $ readIORef $ countRef  

