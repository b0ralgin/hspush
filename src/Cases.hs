{-# LANGUAGE FlexibleContexts #-}
module Cases (addDeviceCase, getDeviceCase, sendPushCase, processTaskCase, processfakeTaskCase) where 
import Domain (UserID, Device, Task (..))
import Types(AppM, AppEnv(db, logger), DB(addDevice, getDevices, saveTask, processTask), PushMonad (sendPush), runAppM)
import MyLogger (Logger(..), LogField (LogField))
import Control.Monad.Reader (asks, withReaderT, liftIO, MonadReader (ask), ReaderT (runReaderT), MonadIO)
import qualified Data.Text as T
import GHC.IORef (IORef(IORef))
import Data.IORef
import Control.Concurrent (threadDelay)
import Gates.FCM.Push (sendPushFCM)

addDeviceCase :: Device -> AppM () 
addDeviceCase device = do 
  db <- asks db
  log <- asks logger 
  liftIO $ addDevice db device 
  liftIO $  logInfo log "Device added" [(LogField "device" device)]
  return ()

getDeviceCase :: UserID -> AppM [Device]
getDeviceCase userid = do
  db <- asks db
  log <- asks logger
  liftIO $ logInfo log "get devices by user" [(LogField "user" userid)]
  res <-   liftIO $ getDevices db userid
  liftIO $ logInfo log "amount of devices" [(LogField "user" userid), (LogField "amount" $ length res)]
  return res


sendPushCase :: UserID -> T.Text -> T.Text -> AppM ()
sendPushCase userid title' body' = do 
  db <- asks db
  log <- asks logger 
  liftIO $ logInfo log "add push notification" [(LogField "user" userid), (LogField "title" title') , (LogField "body" body')]
  liftIO $ saveTask db userid (Task "" title' body')
  return ()

processTaskCase :: AppM Int
processTaskCase = do 
  env <- ask
  db <- asks db
  countRef <- liftIO $ newIORef 0
  liftIO $ processTask db (\(Task device' title' body') -> do
                                                    runAppM (sendPush device' title' body') env  
                                                    liftIO $ modifyIORef countRef (+1)
                                                )
  liftIO $ readIORef $ countRef  


processfakeTaskCase :: AppM Int
processfakeTaskCase = do 
  db <- asks db
  env <- ask
  log <- asks logger
  countRef <- liftIO $ newIORef 0
  liftIO $ processTask db (\(Task  device' title' body') -> do
                                                    logInfo log "push sent" [(LogField "device_id" device'), (LogField "title" title'), (LogField "body" body')]
                                                    -- threadDelay (100000) -- simulate network delay
                                                    liftIO $ modifyIORef countRef (+1)
                                                )
  liftIO $ readIORef $ countRef  

