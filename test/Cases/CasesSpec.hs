module Cases.CasesSpec (spec) where 

import Test.Hspec
import Cases (addDeviceCase, getDeviceCase, sendPushCase, processTaskCase)
import Types
import Control.Monad.Reader
import Gates.Storage.Sqlite (mkDB)
import MyLogger (mkNoopLogger)
import qualified Data.ByteString.Lazy as BS
import Domain (Device(Device), UserID (UserID), DevicePlatform (Ios))
import qualified Data.Text as T



spec :: Spec 
spec = describe "use cases" $ do 
  it "add device" $ do 
    conn <- liftIO $  mkDB ":memory:"
    let env = AppEnv conn mkNoopLogger BS.empty "test"
    runAppM (addDeviceCase (Device (UserID "1") "a" Ios) ) env
  it "should add device and get it back" $ do 
    conn <- liftIO $  mkDB ":memory:"
    let env = AppEnv conn mkNoopLogger BS.empty "test"
    res <- runAppM ( do
      addDeviceCase (Device (UserID "1") "b" Ios)
      getDeviceCase (UserID "1") 
      ) env
    (length res) `shouldBe` 1
  it "should add  2 devices and get them back" $ do 
    conn <- liftIO $  mkDB ":memory:"
    let env = AppEnv conn mkNoopLogger BS.empty "test"
    res <- runAppM ( do
      addDeviceCase (Device (UserID "1") "a" Ios)
      addDeviceCase (Device (UserID "1") "b" Ios)
      getDeviceCase (UserID "1") 
      ) env
    (length res) `shouldBe` 2
  it "add tasks" $ do 
    conn <- liftIO $  mkDB ":memory:"
    let env = AppEnv conn mkNoopLogger BS.empty "test"
    runAppM ( do
      addDeviceCase (Device (UserID "1") "a" Ios)
      sendPushCase (UserID "1") (T.pack "test") (T.pack "value")
      ) env
  it "process task" $ do 
    conn <- liftIO $  mkDB ":memory:"
    let env = AppEnv conn mkNoopLogger BS.empty "test"
    res <- runAppM ( do
      addDeviceCase (Device (UserID "1") "a" Ios)
      sendPushCase (UserID "1") (T.pack "test") (T.pack "value")
      processTaskCase
      ) env
    res `shouldBe` 1