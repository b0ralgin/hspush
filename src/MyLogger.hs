{-# LANGUAGE ExistentialQuantification #-}
module MyLogger (Logger(..), LogField(..), mkStdoutLogger) where

import Data.Time ( getCurrentTime )

data LogField = forall a. Show a => LogField String a

data Logger  = Logger {
  logInfo :: String -> [LogField] -> IO (),
  logError :: String -> [LogField] -> IO ()
}

mkStdoutLogger :: Logger 
mkStdoutLogger = Logger {
  logInfo = \msg fieldsMap-> do 
      currentTime <- getCurrentTime 
      let fields =  unwords $ map strLogField fieldsMap
      putStrLn $ show currentTime ++ "[INFO]:" ++ msg ++ ". " ++ fields
      
  , logError = \msg fieldsMap->do 
      currentTime <- getCurrentTime 
      let fields =  unwords $ map strLogField fieldsMap
      putStrLn $ show currentTime ++  "[ERROR]:" ++ msg ++ ". " ++ fields
  }
  where strLogField (LogField k v) = k ++ ":" ++  show v 
