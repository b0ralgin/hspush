{- This file was auto-generated from proto/server.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Gates.Grpc.Proto.Server (
        PushService(..), AddDeviceRequest(), AddDeviceResponse(), Device(),
        GetDevicesRequest(), GetDevicesResponse(), Platform(..),
        Platform(), Platform'UnrecognizedValue, SendPushRequest(),
        SendPushResponse()
    ) where
import qualified Data.ProtoLens.Runtime.Control.DeepSeq as Control.DeepSeq
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Prism as Data.ProtoLens.Prism
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
{- | Fields :
     
         * 'Proto.Proto.Server_Fields.userId' @:: Lens' AddDeviceRequest Data.Text.Text@
         * 'Proto.Proto.Server_Fields.deviceId' @:: Lens' AddDeviceRequest Data.Text.Text@
         * 'Proto.Proto.Server_Fields.platform' @:: Lens' AddDeviceRequest Platform@ -}
data AddDeviceRequest
  = AddDeviceRequest'_constructor {_AddDeviceRequest'userId :: !Data.Text.Text,
                                   _AddDeviceRequest'deviceId :: !Data.Text.Text,
                                   _AddDeviceRequest'platform :: !Platform,
                                   _AddDeviceRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show AddDeviceRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField AddDeviceRequest "userId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddDeviceRequest'userId
           (\ x__ y__ -> x__ {_AddDeviceRequest'userId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField AddDeviceRequest "deviceId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddDeviceRequest'deviceId
           (\ x__ y__ -> x__ {_AddDeviceRequest'deviceId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField AddDeviceRequest "platform" Platform where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddDeviceRequest'platform
           (\ x__ y__ -> x__ {_AddDeviceRequest'platform = y__}))
        Prelude.id
instance Data.ProtoLens.Message AddDeviceRequest where
  messageName _ = Data.Text.pack "push.AddDeviceRequest"
  packedMessageDescriptor _
    = "\n\
      \\DLEAddDeviceRequest\DC2\ETB\n\
      \\auser_id\CAN\SOH \SOH(\tR\ACKuserId\DC2\ESC\n\
      \\tdevice_id\CAN\STX \SOH(\tR\bdeviceId\DC2*\n\
      \\bplatform\CAN\ETX \SOH(\SO2\SO.push.PlatformR\bplatform"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        userId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "user_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"userId")) ::
              Data.ProtoLens.FieldDescriptor AddDeviceRequest
        deviceId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "device_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"deviceId")) ::
              Data.ProtoLens.FieldDescriptor AddDeviceRequest
        platform__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "platform"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Platform)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"platform")) ::
              Data.ProtoLens.FieldDescriptor AddDeviceRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, userId__field_descriptor),
           (Data.ProtoLens.Tag 2, deviceId__field_descriptor),
           (Data.ProtoLens.Tag 3, platform__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddDeviceRequest'_unknownFields
        (\ x__ y__ -> x__ {_AddDeviceRequest'_unknownFields = y__})
  defMessage
    = AddDeviceRequest'_constructor
        {_AddDeviceRequest'userId = Data.ProtoLens.fieldDefault,
         _AddDeviceRequest'deviceId = Data.ProtoLens.fieldDefault,
         _AddDeviceRequest'platform = Data.ProtoLens.fieldDefault,
         _AddDeviceRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          AddDeviceRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser AddDeviceRequest
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "user_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"userId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "device_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"deviceId") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "platform"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"platform") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "AddDeviceRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"userId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"deviceId") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"platform") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                               Prelude.fromEnum _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData AddDeviceRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_AddDeviceRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_AddDeviceRequest'userId x__)
                (Control.DeepSeq.deepseq
                   (_AddDeviceRequest'deviceId x__)
                   (Control.DeepSeq.deepseq (_AddDeviceRequest'platform x__) ())))
{- | Fields :
     
         * 'Proto.Proto.Server_Fields.success' @:: Lens' AddDeviceResponse Prelude.Bool@
         * 'Proto.Proto.Server_Fields.error' @:: Lens' AddDeviceResponse Data.Text.Text@ -}
data AddDeviceResponse
  = AddDeviceResponse'_constructor {_AddDeviceResponse'success :: !Prelude.Bool,
                                    _AddDeviceResponse'error :: !Data.Text.Text,
                                    _AddDeviceResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show AddDeviceResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField AddDeviceResponse "success" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddDeviceResponse'success
           (\ x__ y__ -> x__ {_AddDeviceResponse'success = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField AddDeviceResponse "error" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _AddDeviceResponse'error
           (\ x__ y__ -> x__ {_AddDeviceResponse'error = y__}))
        Prelude.id
instance Data.ProtoLens.Message AddDeviceResponse where
  messageName _ = Data.Text.pack "push.AddDeviceResponse"
  packedMessageDescriptor _
    = "\n\
      \\DC1AddDeviceResponse\DC2\CAN\n\
      \\asuccess\CAN\SOH \SOH(\bR\asuccess\DC2\DC4\n\
      \\ENQerror\CAN\STX \SOH(\tR\ENQerror"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        success__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "success"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"success")) ::
              Data.ProtoLens.FieldDescriptor AddDeviceResponse
        error__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "error"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"error")) ::
              Data.ProtoLens.FieldDescriptor AddDeviceResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, success__field_descriptor),
           (Data.ProtoLens.Tag 2, error__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _AddDeviceResponse'_unknownFields
        (\ x__ y__ -> x__ {_AddDeviceResponse'_unknownFields = y__})
  defMessage
    = AddDeviceResponse'_constructor
        {_AddDeviceResponse'success = Data.ProtoLens.fieldDefault,
         _AddDeviceResponse'error = Data.ProtoLens.fieldDefault,
         _AddDeviceResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          AddDeviceResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser AddDeviceResponse
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "success"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"success") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "error"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"error") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "AddDeviceResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"success") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                         _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"error") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData AddDeviceResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_AddDeviceResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_AddDeviceResponse'success x__)
                (Control.DeepSeq.deepseq (_AddDeviceResponse'error x__) ()))
{- | Fields :
     
         * 'Proto.Proto.Server_Fields.deviceId' @:: Lens' Device Data.Text.Text@
         * 'Proto.Proto.Server_Fields.platform' @:: Lens' Device Platform@ -}
data Device
  = Device'_constructor {_Device'deviceId :: !Data.Text.Text,
                         _Device'platform :: !Platform,
                         _Device'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Device where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Device "deviceId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Device'deviceId (\ x__ y__ -> x__ {_Device'deviceId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Device "platform" Platform where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Device'platform (\ x__ y__ -> x__ {_Device'platform = y__}))
        Prelude.id
instance Data.ProtoLens.Message Device where
  messageName _ = Data.Text.pack "push.Device"
  packedMessageDescriptor _
    = "\n\
      \\ACKDevice\DC2\ESC\n\
      \\tdevice_id\CAN\SOH \SOH(\tR\bdeviceId\DC2*\n\
      \\bplatform\CAN\STX \SOH(\SO2\SO.push.PlatformR\bplatform"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        deviceId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "device_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"deviceId")) ::
              Data.ProtoLens.FieldDescriptor Device
        platform__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "platform"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Platform)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"platform")) ::
              Data.ProtoLens.FieldDescriptor Device
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, deviceId__field_descriptor),
           (Data.ProtoLens.Tag 2, platform__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Device'_unknownFields
        (\ x__ y__ -> x__ {_Device'_unknownFields = y__})
  defMessage
    = Device'_constructor
        {_Device'deviceId = Data.ProtoLens.fieldDefault,
         _Device'platform = Data.ProtoLens.fieldDefault,
         _Device'_unknownFields = []}
  parseMessage
    = let
        loop :: Device -> Data.ProtoLens.Encoding.Bytes.Parser Device
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "device_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"deviceId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "platform"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"platform") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Device"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"deviceId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"platform") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                            Prelude.fromEnum _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Device where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Device'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Device'deviceId x__)
                (Control.DeepSeq.deepseq (_Device'platform x__) ()))
{- | Fields :
     
         * 'Proto.Proto.Server_Fields.userId' @:: Lens' GetDevicesRequest Data.Text.Text@ -}
data GetDevicesRequest
  = GetDevicesRequest'_constructor {_GetDevicesRequest'userId :: !Data.Text.Text,
                                    _GetDevicesRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show GetDevicesRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField GetDevicesRequest "userId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetDevicesRequest'userId
           (\ x__ y__ -> x__ {_GetDevicesRequest'userId = y__}))
        Prelude.id
instance Data.ProtoLens.Message GetDevicesRequest where
  messageName _ = Data.Text.pack "push.GetDevicesRequest"
  packedMessageDescriptor _
    = "\n\
      \\DC1GetDevicesRequest\DC2\ETB\n\
      \\auser_id\CAN\SOH \SOH(\tR\ACKuserId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        userId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "user_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"userId")) ::
              Data.ProtoLens.FieldDescriptor GetDevicesRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, userId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _GetDevicesRequest'_unknownFields
        (\ x__ y__ -> x__ {_GetDevicesRequest'_unknownFields = y__})
  defMessage
    = GetDevicesRequest'_constructor
        {_GetDevicesRequest'userId = Data.ProtoLens.fieldDefault,
         _GetDevicesRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          GetDevicesRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser GetDevicesRequest
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "user_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"userId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "GetDevicesRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"userId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData GetDevicesRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_GetDevicesRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq (_GetDevicesRequest'userId x__) ())
{- | Fields :
     
         * 'Proto.Proto.Server_Fields.devices' @:: Lens' GetDevicesResponse [Device]@
         * 'Proto.Proto.Server_Fields.vec'devices' @:: Lens' GetDevicesResponse (Data.Vector.Vector Device)@ -}
data GetDevicesResponse
  = GetDevicesResponse'_constructor {_GetDevicesResponse'devices :: !(Data.Vector.Vector Device),
                                     _GetDevicesResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show GetDevicesResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField GetDevicesResponse "devices" [Device] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetDevicesResponse'devices
           (\ x__ y__ -> x__ {_GetDevicesResponse'devices = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField GetDevicesResponse "vec'devices" (Data.Vector.Vector Device) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetDevicesResponse'devices
           (\ x__ y__ -> x__ {_GetDevicesResponse'devices = y__}))
        Prelude.id
instance Data.ProtoLens.Message GetDevicesResponse where
  messageName _ = Data.Text.pack "push.GetDevicesResponse"
  packedMessageDescriptor _
    = "\n\
      \\DC2GetDevicesResponse\DC2&\n\
      \\adevices\CAN\SOH \ETX(\v2\f.push.DeviceR\adevices"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        devices__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "devices"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Device)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"devices")) ::
              Data.ProtoLens.FieldDescriptor GetDevicesResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, devices__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _GetDevicesResponse'_unknownFields
        (\ x__ y__ -> x__ {_GetDevicesResponse'_unknownFields = y__})
  defMessage
    = GetDevicesResponse'_constructor
        {_GetDevicesResponse'devices = Data.Vector.Generic.empty,
         _GetDevicesResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          GetDevicesResponse
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Device
             -> Data.ProtoLens.Encoding.Bytes.Parser GetDevicesResponse
        loop x mutable'devices
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'devices <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'devices)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'devices") frozen'devices x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "devices"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'devices y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'devices
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'devices <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'devices)
          "GetDevicesResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                (\ _v
                   -> (Data.Monoid.<>)
                        (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                        ((Prelude..)
                           (\ bs
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                      (Prelude.fromIntegral (Data.ByteString.length bs)))
                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                           Data.ProtoLens.encodeMessage _v))
                (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'devices") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData GetDevicesResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_GetDevicesResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq (_GetDevicesResponse'devices x__) ())
newtype Platform'UnrecognizedValue
  = Platform'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data Platform
  = PLATFORM_UNKNOWN |
    PLATFORM_ANDROID |
    PLATFORM_IOS |
    PLATFORM_WEB |
    Platform'Unrecognized !Platform'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum Platform where
  maybeToEnum 0 = Prelude.Just PLATFORM_UNKNOWN
  maybeToEnum 1 = Prelude.Just PLATFORM_ANDROID
  maybeToEnum 2 = Prelude.Just PLATFORM_IOS
  maybeToEnum 3 = Prelude.Just PLATFORM_WEB
  maybeToEnum k
    = Prelude.Just
        (Platform'Unrecognized
           (Platform'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum PLATFORM_UNKNOWN = "PLATFORM_UNKNOWN"
  showEnum PLATFORM_ANDROID = "PLATFORM_ANDROID"
  showEnum PLATFORM_IOS = "PLATFORM_IOS"
  showEnum PLATFORM_WEB = "PLATFORM_WEB"
  showEnum (Platform'Unrecognized (Platform'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "PLATFORM_UNKNOWN" = Prelude.Just PLATFORM_UNKNOWN
    | (Prelude.==) k "PLATFORM_ANDROID" = Prelude.Just PLATFORM_ANDROID
    | (Prelude.==) k "PLATFORM_IOS" = Prelude.Just PLATFORM_IOS
    | (Prelude.==) k "PLATFORM_WEB" = Prelude.Just PLATFORM_WEB
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded Platform where
  minBound = PLATFORM_UNKNOWN
  maxBound = PLATFORM_WEB
instance Prelude.Enum Platform where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum Platform: " (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum PLATFORM_UNKNOWN = 0
  fromEnum PLATFORM_ANDROID = 1
  fromEnum PLATFORM_IOS = 2
  fromEnum PLATFORM_WEB = 3
  fromEnum (Platform'Unrecognized (Platform'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ PLATFORM_WEB
    = Prelude.error
        "Platform.succ: bad argument PLATFORM_WEB. This value would be out of bounds."
  succ PLATFORM_UNKNOWN = PLATFORM_ANDROID
  succ PLATFORM_ANDROID = PLATFORM_IOS
  succ PLATFORM_IOS = PLATFORM_WEB
  succ (Platform'Unrecognized _)
    = Prelude.error "Platform.succ: bad argument: unrecognized value"
  pred PLATFORM_UNKNOWN
    = Prelude.error
        "Platform.pred: bad argument PLATFORM_UNKNOWN. This value would be out of bounds."
  pred PLATFORM_ANDROID = PLATFORM_UNKNOWN
  pred PLATFORM_IOS = PLATFORM_ANDROID
  pred PLATFORM_WEB = PLATFORM_IOS
  pred (Platform'Unrecognized _)
    = Prelude.error "Platform.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault Platform where
  fieldDefault = PLATFORM_UNKNOWN
instance Control.DeepSeq.NFData Platform where
  rnf x__ = Prelude.seq x__ ()
{- | Fields :
     
         * 'Proto.Proto.Server_Fields.userId' @:: Lens' SendPushRequest Data.Text.Text@
         * 'Proto.Proto.Server_Fields.title' @:: Lens' SendPushRequest Data.Text.Text@
         * 'Proto.Proto.Server_Fields.body' @:: Lens' SendPushRequest Data.Text.Text@ -}
data SendPushRequest
  = SendPushRequest'_constructor {_SendPushRequest'userId :: !Data.Text.Text,
                                  _SendPushRequest'title :: !Data.Text.Text,
                                  _SendPushRequest'body :: !Data.Text.Text,
                                  _SendPushRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SendPushRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SendPushRequest "userId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SendPushRequest'userId
           (\ x__ y__ -> x__ {_SendPushRequest'userId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SendPushRequest "title" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SendPushRequest'title
           (\ x__ y__ -> x__ {_SendPushRequest'title = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SendPushRequest "body" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SendPushRequest'body
           (\ x__ y__ -> x__ {_SendPushRequest'body = y__}))
        Prelude.id
instance Data.ProtoLens.Message SendPushRequest where
  messageName _ = Data.Text.pack "push.SendPushRequest"
  packedMessageDescriptor _
    = "\n\
      \\SISendPushRequest\DC2\ETB\n\
      \\auser_id\CAN\SOH \SOH(\tR\ACKuserId\DC2\DC4\n\
      \\ENQtitle\CAN\STX \SOH(\tR\ENQtitle\DC2\DC2\n\
      \\EOTbody\CAN\ETX \SOH(\tR\EOTbody"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        userId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "user_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"userId")) ::
              Data.ProtoLens.FieldDescriptor SendPushRequest
        title__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "title"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"title")) ::
              Data.ProtoLens.FieldDescriptor SendPushRequest
        body__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "body"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"body")) ::
              Data.ProtoLens.FieldDescriptor SendPushRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, userId__field_descriptor),
           (Data.ProtoLens.Tag 2, title__field_descriptor),
           (Data.ProtoLens.Tag 3, body__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SendPushRequest'_unknownFields
        (\ x__ y__ -> x__ {_SendPushRequest'_unknownFields = y__})
  defMessage
    = SendPushRequest'_constructor
        {_SendPushRequest'userId = Data.ProtoLens.fieldDefault,
         _SendPushRequest'title = Data.ProtoLens.fieldDefault,
         _SendPushRequest'body = Data.ProtoLens.fieldDefault,
         _SendPushRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SendPushRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser SendPushRequest
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "user_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"userId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "title"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"title") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "body"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"body") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SendPushRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"userId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"title") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"body") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData SendPushRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SendPushRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SendPushRequest'userId x__)
                (Control.DeepSeq.deepseq
                   (_SendPushRequest'title x__)
                   (Control.DeepSeq.deepseq (_SendPushRequest'body x__) ())))
{- | Fields :
     
         * 'Proto.Proto.Server_Fields.success' @:: Lens' SendPushResponse Prelude.Bool@
         * 'Proto.Proto.Server_Fields.error' @:: Lens' SendPushResponse Data.Text.Text@ -}
data SendPushResponse
  = SendPushResponse'_constructor {_SendPushResponse'success :: !Prelude.Bool,
                                   _SendPushResponse'error :: !Data.Text.Text,
                                   _SendPushResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SendPushResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SendPushResponse "success" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SendPushResponse'success
           (\ x__ y__ -> x__ {_SendPushResponse'success = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SendPushResponse "error" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SendPushResponse'error
           (\ x__ y__ -> x__ {_SendPushResponse'error = y__}))
        Prelude.id
instance Data.ProtoLens.Message SendPushResponse where
  messageName _ = Data.Text.pack "push.SendPushResponse"
  packedMessageDescriptor _
    = "\n\
      \\DLESendPushResponse\DC2\CAN\n\
      \\asuccess\CAN\SOH \SOH(\bR\asuccess\DC2\DC4\n\
      \\ENQerror\CAN\STX \SOH(\tR\ENQerror"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        success__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "success"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"success")) ::
              Data.ProtoLens.FieldDescriptor SendPushResponse
        error__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "error"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"error")) ::
              Data.ProtoLens.FieldDescriptor SendPushResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, success__field_descriptor),
           (Data.ProtoLens.Tag 2, error__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SendPushResponse'_unknownFields
        (\ x__ y__ -> x__ {_SendPushResponse'_unknownFields = y__})
  defMessage
    = SendPushResponse'_constructor
        {_SendPushResponse'success = Data.ProtoLens.fieldDefault,
         _SendPushResponse'error = Data.ProtoLens.fieldDefault,
         _SendPushResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SendPushResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser SendPushResponse
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "success"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"success") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "error"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"error") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SendPushResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"success") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                         _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"error") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData SendPushResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SendPushResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SendPushResponse'success x__)
                (Control.DeepSeq.deepseq (_SendPushResponse'error x__) ()))
data PushService = PushService {}
instance Data.ProtoLens.Service.Types.Service PushService where
  type ServiceName PushService = "PushService"
  type ServicePackage PushService = "push"
  type ServiceMethods PushService = '["addDevice",
                                      "getDevices",
                                      "sendPush"]
  packedServiceDescriptor _
    = "\n\
      \\vPushService\DC2<\n\
      \\tAddDevice\DC2\SYN.push.AddDeviceRequest\SUB\ETB.push.AddDeviceResponse\DC2?\n\
      \\n\
      \GetDevices\DC2\ETB.push.GetDevicesRequest\SUB\CAN.push.GetDevicesResponse\DC29\n\
      \\bSendPush\DC2\NAK.push.SendPushRequest\SUB\SYN.push.SendPushResponse"
instance Data.ProtoLens.Service.Types.HasMethodImpl PushService "addDevice" where
  type MethodName PushService "addDevice" = "AddDevice"
  type MethodInput PushService "addDevice" = AddDeviceRequest
  type MethodOutput PushService "addDevice" = AddDeviceResponse
  type MethodStreamingType PushService "addDevice" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl PushService "getDevices" where
  type MethodName PushService "getDevices" = "GetDevices"
  type MethodInput PushService "getDevices" = GetDevicesRequest
  type MethodOutput PushService "getDevices" = GetDevicesResponse
  type MethodStreamingType PushService "getDevices" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl PushService "sendPush" where
  type MethodName PushService "sendPush" = "SendPush"
  type MethodInput PushService "sendPush" = SendPushRequest
  type MethodOutput PushService "sendPush" = SendPushResponse
  type MethodStreamingType PushService "sendPush" = 'Data.ProtoLens.Service.Types.NonStreaming
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \\DC2proto/server.proto\DC2\EOTpush\"t\n\
    \\DLEAddDeviceRequest\DC2\ETB\n\
    \\auser_id\CAN\SOH \SOH(\tR\ACKuserId\DC2\ESC\n\
    \\tdevice_id\CAN\STX \SOH(\tR\bdeviceId\DC2*\n\
    \\bplatform\CAN\ETX \SOH(\SO2\SO.push.PlatformR\bplatform\"C\n\
    \\DC1AddDeviceResponse\DC2\CAN\n\
    \\asuccess\CAN\SOH \SOH(\bR\asuccess\DC2\DC4\n\
    \\ENQerror\CAN\STX \SOH(\tR\ENQerror\",\n\
    \\DC1GetDevicesRequest\DC2\ETB\n\
    \\auser_id\CAN\SOH \SOH(\tR\ACKuserId\"Q\n\
    \\ACKDevice\DC2\ESC\n\
    \\tdevice_id\CAN\SOH \SOH(\tR\bdeviceId\DC2*\n\
    \\bplatform\CAN\STX \SOH(\SO2\SO.push.PlatformR\bplatform\"<\n\
    \\DC2GetDevicesResponse\DC2&\n\
    \\adevices\CAN\SOH \ETX(\v2\f.push.DeviceR\adevices\"T\n\
    \\SISendPushRequest\DC2\ETB\n\
    \\auser_id\CAN\SOH \SOH(\tR\ACKuserId\DC2\DC4\n\
    \\ENQtitle\CAN\STX \SOH(\tR\ENQtitle\DC2\DC2\n\
    \\EOTbody\CAN\ETX \SOH(\tR\EOTbody\"B\n\
    \\DLESendPushResponse\DC2\CAN\n\
    \\asuccess\CAN\SOH \SOH(\bR\asuccess\DC2\DC4\n\
    \\ENQerror\CAN\STX \SOH(\tR\ENQerror*Z\n\
    \\bPlatform\DC2\DC4\n\
    \\DLEPLATFORM_UNKNOWN\DLE\NUL\DC2\DC4\n\
    \\DLEPLATFORM_ANDROID\DLE\SOH\DC2\DLE\n\
    \\fPLATFORM_IOS\DLE\STX\DC2\DLE\n\
    \\fPLATFORM_WEB\DLE\ETX2\199\SOH\n\
    \\vPushService\DC2<\n\
    \\tAddDevice\DC2\SYN.push.AddDeviceRequest\SUB\ETB.push.AddDeviceResponse\DC2?\n\
    \\n\
    \GetDevices\DC2\ETB.push.GetDevicesRequest\SUB\CAN.push.GetDevicesResponse\DC29\n\
    \\bSendPush\DC2\NAK.push.SendPushRequest\SUB\SYN.push.SendPushResponseB\tZ\apush/v1J\226\n\
    \\n\
    \\ACK\DC2\EOT\NUL\NUL6\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\SOH\NUL\SO\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ETX\NUL\RS\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\ETX\NUL\RS\n\
    \\n\
    \\n\
    \\STX\ENQ\NUL\DC2\EOT\a\NUL\f\SOH\n\
    \\n\
    \\n\
    \\ETX\ENQ\NUL\SOH\DC2\ETX\a\ENQ\r\n\
    \\v\n\
    \\EOT\ENQ\NUL\STX\NUL\DC2\ETX\b\STX\ETB\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\SOH\DC2\ETX\b\STX\DC2\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\STX\DC2\ETX\b\NAK\SYN\n\
    \\v\n\
    \\EOT\ENQ\NUL\STX\SOH\DC2\ETX\t\STX\ETB\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\SOH\DC2\ETX\t\STX\DC2\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\STX\DC2\ETX\t\NAK\SYN\n\
    \\v\n\
    \\EOT\ENQ\NUL\STX\STX\DC2\ETX\n\
    \\STX\DC3\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\STX\SOH\DC2\ETX\n\
    \\STX\SO\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\STX\STX\DC2\ETX\n\
    \\DC1\DC2\n\
    \\v\n\
    \\EOT\ENQ\NUL\STX\ETX\DC2\ETX\v\STX\DC3\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\ETX\SOH\DC2\ETX\v\STX\SO\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\ETX\STX\DC2\ETX\v\DC1\DC2\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT\SO\NUL\DC2\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\SO\b\CAN\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\SI\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\SI\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\SI\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\SI\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\DLE\STX\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX\DLE\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\DLE\t\DC2\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\DLE\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX\DC1\STX\CAN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX\DC1\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX\DC1\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX\DC1\SYN\ETB\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT\DC4\NUL\ETB\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\DC4\b\EM\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\NAK\STX\DC3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\NAK\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\NAK\a\SO\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\NAK\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\SYN\STX\DC3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX\SYN\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\SYN\t\SO\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\SYN\DC1\DC2\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT\EM\NUL\ESC\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX\EM\b\EM\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX\SUB\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX\SUB\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX\SUB\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX\SUB\DC3\DC4\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT\GS\NUL \SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX\GS\b\SO\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX\RS\STX\ETB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETX\RS\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX\RS\t\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX\RS\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETX\US\STX\CAN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ACK\DC2\ETX\US\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETX\US\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETX\US\SYN\ETB\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOT\"\NUL$\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX\"\b\SUB\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX#\STX\RS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\EOT\DC2\ETX#\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETX#\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX#\DC2\EM\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX#\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOT&\NUL*\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX&\b\ETB\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX'\STX\NAK\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\ETX'\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX'\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX'\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETX(\STX\DC3\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ENQ\DC2\ETX(\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETX(\t\SO\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETX(\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\ETX)\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ENQ\DC2\ETX)\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\ETX)\t\r\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\ETX)\DLE\DC1\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOT-\NUL0\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETX-\b\CAN\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETX.\STX\DC3\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETX.\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETX.\a\SO\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETX.\DC1\DC2\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETX/\STX\DC3\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETX/\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETX/\t\SO\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETX/\DC1\DC2\n\
    \\n\
    \\n\
    \\STX\ACK\NUL\DC2\EOT2\NUL6\SOH\n\
    \\n\
    \\n\
    \\ETX\ACK\NUL\SOH\DC2\ETX2\b\DC3\n\
    \\v\n\
    \\EOT\ACK\NUL\STX\NUL\DC2\ETX3\STX>\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\SOH\DC2\ETX3\ACK\SI\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\STX\DC2\ETX3\DLE \n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\ETX\DC2\ETX3+<\n\
    \\v\n\
    \\EOT\ACK\NUL\STX\SOH\DC2\ETX4\STXA\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\SOH\SOH\DC2\ETX4\ACK\DLE\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\SOH\STX\DC2\ETX4\DC1\"\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\SOH\ETX\DC2\ETX4-?\n\
    \\v\n\
    \\EOT\ACK\NUL\STX\STX\DC2\ETX5\STX;\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\STX\SOH\DC2\ETX5\ACK\SO\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\STX\STX\DC2\ETX5\SI\RS\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\STX\ETX\DC2\ETX5)9b\ACKproto3"