module Client (main) where 

import Network.GRPC.Client
import Network.GRPC.Client.StreamType.IO
import Network.GRPC.Common
import Network.GRPC.Common.Protobuf
import Gates.Grpc.Proto.Server 
import Gates.Grpc.Proto.Server_Fields
import Gates.Grpc.Proto.ServerMeta

main :: IO ()
main = do 
   withConnection def server $ \conn -> do
      let req = defMessage & userId .~ "client1" & deviceId .~ "device1" & platform .~ (Proto PLATFORM_ANDROID)
      resp <- nonStreaming conn (rpc @(Protobuf PushService "addDevice")) req
      print resp
  where
    server :: Server
    server = ServerInsecure $ Address "127.0.0.1" defaultInsecurePort Nothing