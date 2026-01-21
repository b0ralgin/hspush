module Domain
    ( Device(..), Platform(..), UserID(..),
    ) where
import Control.Monad.Reader

data  Platform = Ios | Andorid deriving Show 
newtype UserID = UserID String deriving Show 
data  Device = Device 
    {   userID :: !UserID,
        deviceID :: !String ,
        platform :: !Platform
}

mkDevice :: UserID -> String -> Platform -> Device
mkDevice = Device 