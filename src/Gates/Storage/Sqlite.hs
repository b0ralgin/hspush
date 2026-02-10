{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module Gates.Storage.Sqlite (mkDB) where

import Domain(UserID(..), Device(..), DevicePlatform(..), Push(..), PushData )
import Control.Monad.IO.Class (liftIO)
import Database.Sqlite.Easy (withPool, SQLData (..), runWith, run, ConnectionString, createSqlitePool, SQLite)
import qualified Data.Text  as  T 
import Types (DB(..))
import Gates.Storage.Migrations (runMigrations)
import Data.Aeson (withObject, withArray, ToJSON(toJSON), encode, decode, decodeStrict)
import Data.ByteString.Lazy (toStrict)
data DBError = NotFound | Duplicate deriving Show

mkDB :: ConnectionString -> IO DB 
mkDB connectionString = do
  pool <- createSqlitePool connectionString
  withPool pool runMigrations 
  return $ DB {
    addDevice = withPool pool . addDeviceDB,
    getDevices = withPool pool . getDeviceDB,
    saveTask = \uid task -> withPool pool $ saveTaskDB uid task,
    processTask = withPool pool . processTaskDB
  }

addDeviceDB :: Device -> SQLite ()
addDeviceDB device = do 
  runWith "INSERT INTO devices (user_id, device_id, platform) VALUES (?, ?,?) ON CONFLICT DO NOTHING" $ mapDevice device
  return ()
  where 
    mapDevice (Device (UserID u) d p) = [(SQLText $ T.pack u), (SQLText $ T.pack d), (SQLText $ mapPlatform p)] 
    mapPlatform p = 
      case p of 
        Ios -> "ios"
        Andorid -> "android"
 
getDeviceDB :: UserID -> SQLite [Device]
getDeviceDB userid = do
    let (UserID uid) = userid 
    result <- runWith "SELECT device_id, platform FROM devices where user_id = ?" [SQLText $ T.pack uid]
    return $ map mapRow result
    where  
      mapPlatform "ios" = Ios
      mapPlatform "android" = Andorid
      mapPlatform p = error $ "wrong platform" ++ p 
      mapRow [SQLText deviceid', SQLText platform] = (Device userid (T.unpack deviceid') (mapPlatform $ T.unpack platform))
      mapRow _ = error "wrong row"

saveTaskDB :: UserID -> Push ->  SQLite ()
saveTaskDB (UserID uid) (Push _  titleText bodyText data') = do 
  let jdata = encodeData data'
  runWith "INSERT INTO tasks (device_id, title, body, data) VALUES (?, ?, ?, ?)" [(SQLText $ T.pack uid), (SQLText titleText), (SQLText bodyText), (SQLBlob jdata)]
  return ()
 where encodeData = toStrict . encode


processTaskDB :: (Push -> IO ()) -> SQLite ()
processTaskDB handler = do
    result <- run "SELECT id, device_id, title, body, data From tasks LIMIT 1"
    case result of 
      [] -> return ()
      [[SQLInteger taskId, SQLText deviceID, SQLText title, SQLText body, SQLBlob data']] -> do
        let d = decodeStrict data'
        case d of 
          Nothing -> error "failed to parse data"
          Just data' -> do 
              _ <- liftIO $ handler (Push (T.unpack deviceID) (title) (body) data')
              _ <- runWith "DELETE from tasks where id = ?" [SQLInteger taskId] 
              return ()
      _ -> error "too many rows"
