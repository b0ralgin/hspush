module FCM.TokenProviderSpec (spec) where 

import Test.Hspec
import Gates.FCM.Oauth (mkCacheTokenProvider, SignedJWT(..))
import Types (TokenProvider(fetchToken), JWT (..))
import Control.Monad.State
import Data.ByteString.UTF8 as BSU   
import Mocks.Http  
import Control.Concurrent (threadDelay)

spec :: Spec
spec = describe "cache token" $ do
  it "initalize cache" $ do 
    let mock = (SimpleHttpMock (200, BSU.fromString "{\"access_token\":\"test.token\", \"expires_in\":3600}"))
    (token, _) <- runStateT ( do
      provider <- liftIO $ mkCacheTokenProvider (SignedJWT "test") 
      Right token <- fetchToken provider 
      return token 
      ) mock
    token `shouldBe` (JWT "test.token")
  it "check caching" $ do 
    let mock = (SimpleHttpMock (200, BSU.fromString "{\"access_token\":\"test.token\", \"expires_in\":3600}"))
    ((token, token'), _) <- runStateT ( do
      provider <- liftIO $ mkCacheTokenProvider (SignedJWT "test") 
      Right token <- fetchToken provider 
      liftIO $ token `shouldBe` (JWT "test.token")
      put (SimpleHttpMock (500,BSU.fromString "{}" ))
      Right token' <- fetchToken provider  -- it should work despite we simulate like API doesn't work 
      return (token, token')
      ) mock
    token `shouldBe` (JWT "test.token")
    token' `shouldBe` (JWT "test.token")
  it "update expired token" $ do 
    let mock = (SimpleHttpMock (200, BSU.fromString "{\"access_token\":\"test.token\", \"expires_in\":2}"))
    ((token, token'), _) <- runStateT ( do
      provider <- liftIO $ mkCacheTokenProvider (SignedJWT "test") 
      Right token <- fetchToken provider 
      liftIO $ token `shouldBe` (JWT "test.token")
      put (SimpleHttpMock (200,BSU.fromString "{\"access_token\":\"test.token2\", \"expires_in\":2}" ))
      liftIO $ threadDelay 2000
      Right token' <- fetchToken provider  -- it should work despite we simulate like API doesn't work 
      return (token, token')
      ) mock
    token `shouldBe` (JWT "test.token")
    token' `shouldBe` (JWT "test.token")