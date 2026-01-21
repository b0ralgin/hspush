{-# LANGUAGE OverloadedStrings #-}

module Storage (addDevice,  RepoT(..), getDevice) where

import Domain(UserID(..), Device(..), Platform(..), )
import Control.Monad.Reader (ReaderT, ask)
import Control.Monad.IO.Class (liftIO)
import Database.SQLite.Simple (withConnection, execute, SQLData (SQLText), query, Only (..), executeNamed, Connection)
import Database.SQLite.Simple.Internal (Field(..))
import Database.SQLite.Simple.FromField ( FromField (..), returnError, ResultError (ConversionFailed))
import Database.SQLite.Simple.FromRow ( field, FromRow(..) )
import Database.SQLite.Simple.ToRow
import Database.SQLite.Simple.Ok (Ok (..))
import Database.SQLite.Simple.ToField (ToField (..))

data DBError = NotFound | Duplicate 

type RepoT = ReaderT Connection IO   

data DeviceModel = DeviceModel {  
   user :: !String,
   device :: !String,
   plat :: !Platform
} deriving (Show)
 
instance FromRow DeviceModel where 
  fromRow = DeviceModel <$> field <*> field <*> field

instance ToRow DeviceModel where 
   toRow (DeviceModel { user = uid, device = dev, plat = plat }) = toRow (uid, dev, plat) 

instance ToField Platform where 
  toField Ios = SQLText "ios"
  toField Andorid = SQLText "android" 
  {-# INLINE toField #-}

instance FromField Platform where
     fromField (Field (SQLText "ios") _) = Ok Ios
     fromField (Field (SQLText "android") _) = Ok Andorid
     fromField f = returnError ConversionFailed f "need a text"


addDevice :: Device -> RepoT (Either DBError Device)
addDevice device = do 
  conn  <- ask 
  let (UserID uid) = userID device
  _ <- liftIO $ execute conn "INSERT INTO devices (user_id, device_id, platform) VALUES (?, ?, ?) ON CONFLICT DO NOTHING" (DeviceModel uid (deviceID device) (platform device))
  return $ Right device 

 
getDevice :: UserID -> RepoT (Either DBError [Device])
getDevice uid = do
  conn <- ask 
  let (UserID u) = uid
  res <- liftIO (query conn "SELECT user_id, device_id, platform FROM devices WHERE user_id = ?" (Only u) :: IO [DeviceModel])
  return $ Right $ map (\(DeviceModel uu did p) -> Device (UserID uu) did p) res

