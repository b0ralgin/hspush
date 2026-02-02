{-# LANGUAGE TypeFamilies #-}

module Gates.Grpc.Proto.ServerMeta (
  -- Re-export the generated service and messages
  module Gates.Grpc.Proto.Server
) where

import Data.ProtoLens.Labels ()

import Network.GRPC.Common
import Network.GRPC.Common.Protobuf

import Gates.Grpc.Proto.Server (PushService(..))

-- Metadata instances for all methods of PushService
type instance RequestMetadata          (Protobuf PushService meth) = NoMetadata
type instance ResponseInitialMetadata  (Protobuf PushService meth) = NoMetadata
type instance ResponseTrailingMetadata (Protobuf PushService meth) = NoMetadata
