module Domain
    ( Device(..), Platform(..), UserID(..), mkDevice, Task(..)
    ) where

data  Platform = Ios | Andorid deriving Show 
newtype UserID = UserID String deriving Show 
data  Device = Device 
    {   userID :: !UserID,
        deviceID :: !String ,
        platform :: !Platform
} deriving (Show) 

mkDevice :: UserID -> String -> Platform -> Device
mkDevice = Device

data Task = Task {
    taskId :: !Int,
    device :: !String,
    title :: !String,
    body :: !String
}


