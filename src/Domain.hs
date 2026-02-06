module Domain
    ( Device(..), DevicePlatform(..), UserID(..), mkDevice, Task(..)
    ) where

data  DevicePlatform = Ios | Andorid deriving Show 
newtype UserID = UserID String deriving Show 
data  Device = Device 
    {   userID :: !UserID,
        deviceID :: !String ,
        platform :: !DevicePlatform
} deriving (Show) 

mkDevice :: UserID -> String -> DevicePlatform -> Device
mkDevice = Device

data Task = Task {
    device :: !String,
    title :: !String,
    body :: !String
}


