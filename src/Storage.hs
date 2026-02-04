{-# LANGUAGE OverloadedStrings #-}

module Storage (addDevice,  RepoT, getDevice, processTask, saveTask) where

import Domain(UserID(..), Device(..), DevicePlatform(..), Task (Task, taskId), )
import Control.Monad.Reader (ReaderT, ask)
import Control.Monad.IO.Class (liftIO)
import Database.SQLite.Simple (execute, SQLData (SQLText), query, Only (..), Connection, withTransaction, query_, changes, withImmediateTransaction)
import Database.SQLite.Simple.Internal (Field(..))
import Database.SQLite.Simple.FromField ( FromField (..), returnError, ResultError (ConversionFailed))
import Database.SQLite.Simple.FromRow ( field, FromRow(..) )
import Database.SQLite.Simple.ToRow
import Database.SQLite.Simple.Ok (Ok (..))
import Database.SQLite.Simple.ToField (ToField (..))

data DBError = NotFound | Duplicate deriving Show

type RepoT = ReaderT Connection IO   

data DeviceModel = DeviceModel {  
   user :: !String,
   device :: !String,
   plat :: !DevicePlatform
} deriving (Show)

data TaskModel = TaskModel {
  _id :: !Int,
  _device :: !String,
  _title :: !String,
  _body :: !String
}

instance FromRow TaskModel where 
  fromRow = TaskModel <$> field <*> field <*> field <*> field 

instance ToRow TaskModel where 
  toRow (TaskModel id did title body) = toRow(id, did, title, body)
 
instance FromRow DeviceModel where 
  fromRow = DeviceModel <$> field <*> field <*> field
instance ToRow DeviceModel where 
   toRow (DeviceModel { user = uid, device = dev, plat = plat }) = toRow (uid, dev, plat) 
   
instance ToField DevicePlatform where 
  toField Ios = SQLText "ios"
  toField Andorid = SQLText "android" 
  {-# INLINE toField #-}

instance FromField DevicePlatform where
     fromField (Field (SQLText "ios") _) = Ok Ios
     fromField (Field (SQLText "android") _) = Ok Andorid
     fromField f = returnError ConversionFailed f "need a text"


addDevice :: Device -> RepoT (Either DBError Device)
addDevice device = do 
  conn  <- ask 
  let (UserID uid) = userID device
  liftIO $ execute conn "INSERT INTO devices (user_id, device_id, platform) VALUES (?, ?, ?) ON CONFLICT DO NOTHING" (DeviceModel  uid (deviceID device) (platform device))
  -- TODO: add checking, if device already added (to monitor cases)
  return $ Right device 

 
getDevice :: UserID -> RepoT [Device]
getDevice uid = do
  conn <- ask 
  let (UserID u) = uid
  res <- liftIO (getDevices conn u)
  return $ map (\(DeviceModel uu did p) -> Device (UserID uu) did p) res

saveTask :: UserID -> String -> String -> RepoT (Either DBError ())
saveTask uid titleText bodyText = do
  conn <- ask
  let (UserID u) = uid
  liftIO $ withTransaction conn $ do
    deviceList <- getDevices conn u
    case deviceList of
      [] -> return (Left NotFound)
      _  -> do
        mapM_ (\d -> insertPush conn (device d) titleText bodyText) deviceList
        return (Right ())

getDevices :: Connection -> String -> IO [DeviceModel] 
getDevices conn uid = do
   query conn "SELECT user_id, device_id, platform FROM devices WHERE user_id = ?" (Only uid)

insertPush ::  Connection -> String -> String -> String -> IO ()
insertPush conn d t b = 
  execute conn "INSERT INTO tasks(device_id, title, body) VALUES (?, ? , ?)" (d, t, b)


getTask :: Connection -> IO (Maybe [Task])
getTask conn = do
  res <- liftIO $ query_ conn "SELECT id, device_id, title, body from tasks LIMIT 1000" 
  case res of 
    [] -> return Nothing
    res -> return $ Just $  map mapTask res
  where mapTask (TaskModel i d t b) = (Task i d t b)



deleteTask :: Connection -> Int -> IO ()
deleteTask conn id = do
  execute conn "DELETE FROM tasks  where id = ?" (Only id)
  return ()

processTask :: (Task -> IO a) -> RepoT ()
processTask handler = do
  conn <- ask 
  _ <- liftIO $ withImmediateTransaction conn $ do
        task <- getTask conn 
        case task of 
          Nothing -> return ()
          Just tasksList -> do 
              mapM_ (\t -> do
                _ <- liftIO $ handler t 
                deleteTask conn (taskId t)
                ) tasksList
  return ()

