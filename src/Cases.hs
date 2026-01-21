module Cases (addDeviceCase) where 
import Domain (UserID, Device)
import Storage (addDevice)
import Types(AppM(..), AppEnv(dbPool, logger))
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
      liftIO $  logInfo log "Device added" []
  return ()

