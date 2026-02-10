{-# LANGUAGE OverloadedLabels #-}

module Gates.Grpc.Server (methods) where

-- Bring in metadata instances for PushService

import Cases (addDeviceCase, getDeviceCase, sendPushCase)
import Control.Lens ((&), (.~), (^.))
import Control.Monad.Reader (MonadReader (ask), runReaderT)
import Data.Map (Map, foldrWithKey)
import qualified Data.Text as T
import qualified Data.Text as Text
import Domain (Device (Device), DevicePlatform (Andorid, Ios), Push (Push), PushData, UserID (..), mkDevice)
import Gates.Grpc.Proto.Server (AddDeviceRequest, AddDeviceResponse, Device, GetDevicesRequest, GetDevicesResponse, Platform (PLATFORM_ANDROID, PLATFORM_IOS, PLATFORM_UNKNOWN), PushService, SendPushRequest, SendPushResponse)
import Gates.Grpc.Proto.ServerMeta ()
import Gates.Grpc.Proto.Server_Fields (body, data', deviceId, devices, error, platform, success, title, userId)
import Network.GRPC.Common.Protobuf
import Network.GRPC.Server.Protobuf
import Network.GRPC.Server.StreamType
import Types (AppEnv, runAppM)
import Prelude hiding (error)

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
  let p = mapToPlatform (req ^. platform)
  case p of
    Nothing -> return $ defMessage & success .~ False & error .~ Text.pack ("wrong platfrom type") -- TODO: add throwM GrpcExecption
    Just platform' -> do
      _ <- runAppM (addDeviceCase $ mkDevice (UserID $ Text.unpack uid) (Text.unpack did) platform') env
      return $ defMessage & success .~ True

handleGetDevices :: AppEnv -> Proto GetDevicesRequest -> IO (Proto GetDevicesResponse)
handleGetDevices env req = do
  let uid = req ^. userId
  res <- runAppM (getDeviceCase (UserID $ Text.unpack uid)) env
  return $ defMessage & devices .~ map mapDevice res

handleSendPush :: AppEnv -> Proto SendPushRequest -> IO (Proto SendPushResponse)
handleSendPush env req = do
  let uid = T.unpack $ req ^. userId
  let bodyMsg = req ^. body
  let titleMsg = req ^. title
  let pushdata = req ^. data'

  _ <- runAppM (sendPushCase (UserID uid) (Push "" titleMsg bodyMsg (mapData pushdata))) env
  return $ defMessage & success .~ True
  where
    mapData :: Map T.Text T.Text -> PushData
    mapData d = foldrWithKey (\key val acc -> ((T.unpack key), val) : acc) [] d

mapDevice :: Domain.Device -> Proto Gates.Grpc.Proto.Server.Device
mapDevice (Device _ did' p') = defMessage & deviceId .~ (Text.pack did') & platform .~ (mapFromPlatform p')

mapToPlatform :: Proto Platform -> Maybe DevicePlatform
mapToPlatform (Proto PLATFORM_ANDROID) = Just Andorid
mapToPlatform (Proto PLATFORM_IOS) = Just Ios
mapToPlatform _ = Nothing

mapFromPlatform :: DevicePlatform -> Proto Platform
mapFromPlatform Andorid = (Proto PLATFORM_ANDROID)
mapFromPlatform Ios = (Proto PLATFORM_IOS)
mapFromPlatform _ = (Proto PLATFORM_UNKNOWN)
