{-# LANGUAGE OverloadedLabels #-}

module Gates.Grpc.Server() where 
import Domain (UserID(..))
import Gates.Grpc.Proto.Server (AddDeviceRequest, AddDeviceResponse, Platform (PLATFORM_ANDROID, PLATFORM_IOS, PLATFORM_UNKNOWN), GetDevicesRequest, GetDevicesResponse, Device)
import Gates.Grpc.Proto.Server_Fields(userId, deviceId, platform, success, error, devices)
import Cases (addDeviceCase, getDeviceCase)
import Types (AppM)
import Control.Lens ((^.), (.~), (&))
import Control.Monad.Reader (MonadReader(ask))
import Domain (mkDevice, Platform (Andorid, Ios), Device (Device))
import qualified Data.Text as Text
import Data.ProtoLens.Message (Message(defMessage))
import Prelude hiding (error)

handleAddDevice ::AddDeviceRequest -> AppM (AddDeviceResponse)
handleAddDevice req = do
  let uid = req ^. userId
  let did = req ^. deviceId
  let p =   mapToPlatform (req ^. platform)
  env <- ask
  case p of 
    Nothing -> return $ defMessage & success .~ False & error .~ Text.pack ("wrong platfrom type") -- TODO: add throwM GrpcExecption 
    Just platform' -> do
      res <- addDeviceCase $ mkDevice (UserID $ Text.unpack uid) (Text.unpack did) platform'  
      return $  defMessage & success .~ True

handleGetDevices :: GetDevicesRequest -> AppM (GetDevicesResponse)
handleGetDevices req = do
  let uid = req ^. userId
  env <- ask 
  res <- getDeviceCase (UserID $ Text.unpack uid)
  return $ defMessage & devices .~ map mapDevice res


mapDevice :: Domain.Device -> Gates.Grpc.Proto.Server.Device 
mapDevice (Device _ did' p') = defMessage & deviceId .~ (Text.pack did') & platform .~ (mapFromPlatform p')


mapToPlatform :: Gates.Grpc.Proto.Server.Platform -> Maybe Domain.Platform
mapToPlatform PLATFORM_ANDROID = Just Andorid
mapToPlatform PLATFORM_IOS = Just Ios
mapToPlatform _ = Nothing

mapFromPlatform :: Domain.Platform -> Gates.Grpc.Proto.Server.Platform
mapFromPlatform Andorid = PLATFORM_ANDROID
mapFromPlatform Ios = PLATFORM_IOS
mapFromPlatform _ = PLATFORM_UNKNOWN

