{-# LANGUAGE FlexibleContexts #-}

module Cases (addDeviceCase, getDeviceCase, sendPushCase, processTaskCase) where

import Control.Concurrent (threadDelay)
import Control.Monad.Reader (MonadIO, MonadReader (ask), ReaderT (runReaderT), asks, liftIO, withReaderT)
import Data.IORef
import qualified Data.Text as T
import Domain (Device, Push (..), UserID, PushData)
import GHC.IORef (IORef (IORef))
import MyLogger (LogField (LogField), Logger (..))
import Types (AppEnv (db, logger),WorkerEnv(pusher), AppM, DB (addDevice, getDevices, processTask, saveTask), runAppM, Pusher (send), HasDB (getDB), HasLogger (getLogger), HasPusher (getPusher))

addDeviceCase :: (HasDB env , HasLogger env, MonadReader env m, MonadIO m) => Device -> m ()
addDeviceCase device = do
  db <- asks getDB 
  log <- asks getLogger
  liftIO $ addDevice db device
  liftIO $ logInfo log "Device added" [(LogField "device" device)]
  return ()

getDeviceCase ::(HasDB env , HasLogger env, MonadReader env m, MonadIO m) =>  UserID -> m [Device]
getDeviceCase userid = do
  db <- asks getDB
  log <- asks getLogger
  liftIO $ logInfo log "get devices by user" [(LogField "user" userid)]
  res <- liftIO $ getDevices db userid
  liftIO $ logInfo log "amount of devices" [(LogField "user" userid), (LogField "amount" $ length res)]
  return res

sendPushCase :: (HasDB env , HasLogger env, MonadReader env m, MonadIO m) => UserID -> Push -> m ()
sendPushCase userid (Push _ title' body' data') = do
  db <- asks getDB
  log <- asks getLogger
  liftIO $ logInfo log "add push notification" [(LogField "user" userid), (LogField "title" title'), (LogField "body" body')]
  liftIO $ saveTask db userid (Push "" title' body' data')
  return ()

processTaskCase :: (HasDB env ,HasPusher env, MonadReader env m, MonadIO m) => m Int
processTaskCase = do
  db <- asks getDB
  sendPush <- asks getPusher
  countRef <- liftIO $ newIORef 0
  liftIO $
    processTask
      db
      ( \(Push device' title' body' data') -> do
          liftIO $ send sendPush (Push device' title' body' data')
          liftIO $ modifyIORef countRef (+ 1)
      )
  liftIO $ readIORef $ countRef