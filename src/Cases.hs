{-# LANGUAGE FlexibleContexts #-}

module Cases (addDeviceCase, getDeviceCase, sendPushCase, processTaskCase, processfakeTaskCase) where

import Control.Concurrent (threadDelay)
import Control.Monad.Reader (MonadIO, MonadReader (ask), ReaderT (runReaderT), asks, liftIO, withReaderT)
import Data.IORef
import qualified Data.Text as T
import Domain (Device, Push (..), UserID, PushData)
import GHC.IORef (IORef (IORef))
import Gates.FCM.Push (sendPushFCM)
import MyLogger (LogField (LogField), Logger (..))
import Types (AppEnv (db, logger), AppM, DB (addDevice, getDevices, processTask, saveTask), PushMonad (sendPush), runAppM)

addDeviceCase :: Device -> AppM ()
addDeviceCase device = do
  db <- asks db
  log <- asks logger
  liftIO $ addDevice db device
  liftIO $ logInfo log "Device added" [(LogField "device" device)]
  return ()

getDeviceCase :: UserID -> AppM [Device]
getDeviceCase userid = do
  db <- asks db
  log <- asks logger
  liftIO $ logInfo log "get devices by user" [(LogField "user" userid)]
  res <- liftIO $ getDevices db userid
  liftIO $ logInfo log "amount of devices" [(LogField "user" userid), (LogField "amount" $ length res)]
  return res

sendPushCase :: UserID -> Push -> AppM ()
sendPushCase userid (Push _ title' body' data') = do
  db <- asks db
  log <- asks logger
  liftIO $ logInfo log "add push notification" [(LogField "user" userid), (LogField "title" title'), (LogField "body" body')]
  liftIO $ saveTask db userid (Push "" title' body' data')
  return ()

processTaskCase :: AppM Int
processTaskCase = do
  env <- ask
  db <- asks db
  countRef <- liftIO $ newIORef 0
  liftIO $
    processTask
      db
      ( \(Push device' title' body' data') -> do
          runAppM (sendPush (Push device' title' body' data')) env
          liftIO $ modifyIORef countRef (+ 1)
      )
  liftIO $ readIORef $ countRef

processfakeTaskCase :: AppM Int
processfakeTaskCase = do
  db <- asks db
  env <- ask
  log <- asks logger
  countRef <- liftIO $ newIORef 0
  liftIO $
    processTask
      db
      ( \(Push device' title' body' _) -> do
          logInfo log "push sent" [(LogField "device_id" device'), (LogField "title" title'), (LogField "body" body')]
          -- threadDelay (100000) -- simulate network delay
          liftIO $ modifyIORef countRef (+ 1)
      )
  liftIO $ readIORef $ countRef
