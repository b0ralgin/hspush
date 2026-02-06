module Domain
    ( Device(..), DevicePlatform(..), UserID(..), mkDevice, Task(..)
    ) where
import qualified Data.Text as T

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
    title :: !T.Text,
    body :: !T.Text
}


