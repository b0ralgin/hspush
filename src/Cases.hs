module Cases (addDeviceCase) where 
import Domain (UserID, Device)
import Storage (addDevice, getDevice)
import Types(AppM, AppEnv(dbPool, logger))
import MyLogger (Logger(..), LogField (LogField))
import Control.Monad.Reader (asks, withReaderT, liftIO)

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

