module Cases.CasesSpec (spec) where 

import Test.Hspec
import Cases (addDeviceCase)
import Types
import Control.Monad.Reader
import Gates.Storage.Sqlite (mkDB)
import MyLogger (mkNoopLogger)
import qualified Data.ByteString.Lazy as BS
import Domain (Device(Device), UserID (UserID), DevicePlatform (Ios))

spec :: Spec 
spec = describe "use cases" $ do 
  it "add device" $ do 
    conn <- liftIO $  mkDB ":memory:"
    let env = AppEnv conn mkNoopLogger BS.empty "test"
    runAppM (addDeviceCase (Device (UserID "1") "a" Ios) ) env