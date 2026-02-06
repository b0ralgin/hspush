{-# LANGUAGE OverloadedStrings #-}

module Storage (addDevice,  RepoT, getDevice, processTask, saveTask) where

import Domain(UserID(..), Device(..), DevicePlatform(..), Task (Task), )
import Control.Monad.Reader (ReaderT, ask)
import Control.Monad.IO.Class (liftIO)
import Database.Sqlite.Easy (Pool, Database, withPool, SQLData (..), runWith, run)
import qualified Data.Text  as  T 
data DBError = NotFound | Duplicate deriving Show

type RepoT = ReaderT (Pool Database) IO   

addDevice :: Device -> RepoT (Either DBError Device)
addDevice device = do 
  pool <- ask
  _ <- liftIO $ withPool pool $ (
    runWith "INSERT INTO devices (user_id, device_id, platform) VALUES (?, ?,?) ON CONFLICT DO NOTHING" $ mapDevice device

    )
  return $ Right device
  where 
    mapDevice (Device (UserID u) d p) = [(SQLText $ T.pack u), (SQLText $ T.pack d), (SQLText $ mapPlatform p)] 
    mapPlatform p = 
      case p of 
        Ios -> "ios"
        Andorid -> "android"
 
getDevice :: UserID -> RepoT [Device]
getDevice userid = do
    let (UserID uid) = userid 
    pool <- ask 
    result <- liftIO $ withPool pool $ 
      runWith "SELECT device_id, platform FROM devices where user_id = ?" [SQLText $ T.pack uid]
    return $ map mapRow result
    where  
      mapPlatform "ios" = Ios
      mapPlatform "android" = Andorid
      mapPlatform p = error $ "wrong platform" ++ p 
      mapRow [SQLText deviceid', SQLText platform] = (Device userid (T.unpack deviceid') (mapPlatform $ T.unpack platform))
      mapRow _ = error "wrong row"

saveTask :: UserID -> T.Text -> T.Text -> RepoT (Either DBError ())
saveTask (UserID uid) titleText bodyText = do 
  pool <- ask
  _ <- liftIO $ withPool pool $ 
    runWith "INSERT INTO tasks (device_id, title, body)" [(SQLText $ T.pack uid), (SQLText titleText), (SQLText bodyText)]
  return $ Right ()



processTask :: (Task -> IO a) -> RepoT ()
processTask handler = do
  pool <- ask 
  liftIO $ withPool pool $ do
    result <- run "SELECT id, device_id, title, body From tasks LIMIT 1"
    case result of 
      [] -> return ()
      [[SQLInteger taskId, SQLText deviceID, SQLText title, SQLText body]] -> do
        _ <- liftIO $ handler (Task (T.unpack deviceID) (T.unpack title) (T.unpack body))
        _ <- runWith "DELETE from tasks where id = ?" [SQLInteger taskId] 
        return ()
      _ -> error "too many rows"
