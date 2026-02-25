module FCM.PushSpec (spec) where

import Test.Hspec
import Domain(Push(..))
import Data.Maybe (isNothing)
spec :: Spec
spec = describe "test send push" $ do
    it "should send request" $ do
      pending
