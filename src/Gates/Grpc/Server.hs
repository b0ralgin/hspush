{-# LANGUAGE OverloadedLabels #-}

module Gates.Grpc.Server(methods) where 
import Domain (UserID(..))
import Gates.Grpc.Proto.Server (AddDeviceRequest, AddDeviceResponse, Platform (PLATFORM_ANDROID, PLATFORM_IOS, PLATFORM_UNKNOWN), GetDevicesRequest, GetDevicesResponse, Device, SendPushRequest, SendPushResponse, PushService)
-- Bring in metadata instances for PushService
import Gates.Grpc.Proto.ServerMeta ()
import Gates.Grpc.Proto.Server_Fields(userId, deviceId, platform, success, error, devices, title, body)
import Cases (addDeviceCase, getDeviceCase, sendPushCase)
import Types (AppM, AppEnv)
import Control.Monad.Reader (runReaderT)
import Control.Lens ((^.), (.~), (&))
import Control.Monad.Reader (MonadReader(ask))
import Domain (mkDevice, DevicePlatform (Andorid, Ios), Device (Device))
import qualified Data.Text as Text
import Data.ProtoLens.Message (Message(defMessage))
import Prelude hiding (error)
import qualified Data.Text as T
import Network.GRPC.Common
import Network.GRPC.Common.Protobuf
import Network.GRPC.Server.Protobuf
import Network.GRPC.Server.Run
import Network.GRPC.Server.StreamType

methods :: AppEnv -> Methods IO (ProtobufMethodsOf PushService)
methods env =
  Method (mkNonStreaming (handleAddDevice env)) $ 
  Method (mkNonStreaming (handleGetDevices env)) $ 
  Method (mkNonStreaming (handleSendPush env)) $ 
  NoMoreMethods

handleAddDevice :: AppEnv -> Proto AddDeviceRequest -> IO (Proto AddDeviceResponse)
handleAddDevice env req = do
  let uid = req ^. userId
  let did = req ^. deviceId
  let p =   mapToPlatform (req ^. platform)
  case p of 
    Nothing -> return $ defMessage & success .~ False & error .~ Text.pack ("wrong platfrom type") -- TODO: add throwM GrpcExecption 
    Just platform' -> do
      _ <- runReaderT (addDeviceCase $ mkDevice (UserID $ Text.unpack uid) (Text.unpack did) platform') env
      return $ defMessage & success .~ True

handleGetDevices :: AppEnv -> Proto GetDevicesRequest -> IO (Proto GetDevicesResponse)
handleGetDevices env req = do
  let uid = req ^. userId
  res <- runReaderT (getDeviceCase (UserID $ Text.unpack uid)) env
  return $ defMessage & devices .~ map mapDevice res

handleSendPush :: AppEnv -> Proto SendPushRequest -> IO (Proto SendPushResponse)
handleSendPush env req = do
  let uid = T.unpack $ req ^. userId
  let bodyMsg = T.unpack $ req ^. body
  let titleMsg = T.unpack $ req ^. title 
  _ <- runReaderT (sendPushCase (UserID uid) titleMsg bodyMsg) env
  return $ defMessage & success .~ True 


mapDevice :: Domain.Device ->Proto  Gates.Grpc.Proto.Server.Device 
mapDevice (Device _ did' p') = defMessage & deviceId .~ (Text.pack did') & platform .~ (mapFromPlatform p')


mapToPlatform :: Proto Platform -> Maybe DevicePlatform
mapToPlatform (Proto PLATFORM_ANDROID) = Just Andorid
mapToPlatform (Proto PLATFORM_IOS) = Just Ios
mapToPlatform _ = Nothing

mapFromPlatform :: DevicePlatform -> Proto Platform
mapFromPlatform Andorid = (Proto PLATFORM_ANDROID)
mapFromPlatform Ios = (Proto PLATFORM_IOS)
mapFromPlatform _ = (Proto PLATFORM_UNKNOWN)

