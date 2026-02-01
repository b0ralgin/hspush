{-# LANGUAGE OverloadedStrings #-}
module Gates.FCM.Oauth (getJWTToken, OauthError(..), JWT(..)) where 

import Codec.Crypto.RSA.Pure
import Control.Monad (unless)
import Control.Monad.Reader (MonadIO (liftIO), asks, liftIO)
import Data.Aeson (FromJSON(..), decode, (.:), fromJSON, Result(..))
import Data.Aeson.Types (withObject)
import qualified Data.ByteString as B
import Data.ByteString.Base64.URL (encode)
import Data.ByteString.Char8 (unpack)
import Data.ByteString.Lazy (fromStrict, toStrict)
import Data.Maybe (fromJust, fromMaybe)
import Data.Text.Encoding (encodeUtf8)
import Data.UnixTime (getUnixTime, utSeconds)
import Foreign.C.Types
import Network.HTTP.Simple (parseRequest, setRequestBodyURLEncoded, setRequestMethod, httpJSONEither, getResponseStatusCode, getResponseBody)
import OpenSSL.EVP.PKey (toKeyPair)
import OpenSSL.PEM (PemPasswordSupply (PwNone), readPrivateKey)
import OpenSSL.RSA
import Types (AppEnv (googleSecrets), AppM)
import qualified Data.Text as T

data GoogleSecret = GoogleSecret
  { privateKey :: T.Text,
    fileType :: T.Text,
    clientEmal :: T.Text
  }

newtype SignedJWT
  = SignedJWT B.ByteString
  deriving (Eq)

instance Show SignedJWT where
  show (SignedJWT t) = unpack t

type Email = T.Text

type Scope = T.Text

fromPEMString :: String -> IO PrivateKey
fromPEMString s =
  readPrivateKey s PwNone
    >>= ( \k ->
            return
              PrivateKey
                { private_pub =
                    PublicKey
                      { public_size = rsaSize k,
                        public_n = rsaN k,
                        public_e = rsaE k
                      },
                  private_d = rsaD k,
                  private_p = rsaP k,
                  private_q = rsaQ k,
                  private_dP = 0,
                  private_dQ = 0,
                  private_qinv = 0
                }
        )
      . fromJust
      . toKeyPair

getSignedJWT ::
  -- | The email address of the service account.
  Email ->
  -- | The email address of the user for which the
  -- application is requesting delegated access.
  Maybe Email ->
  -- | The list of the permissions that the application requests.
  [Scope] ->
  -- | Expiration time (maximun and default value is an hour, 3600 seconds).
  Maybe Int ->
  -- | The private key gotten from the PEM string obtained from the
  -- Google API Console.
  PrivateKey ->
  -- | Either an error message or a signed JWT.
  IO (Either String SignedJWT)
getSignedJWT iss msub scs mxt pk =
  let toT = T.pack . show
      toB64 = encode . encodeUtf8
      header = toB64 "{\"alg\":\"RS256\",\"typ\":\"JWT\"}"
   in do
        let xt = fromIntegral (fromMaybe 3600 mxt)
        unless (xt >= 1 && xt <= 3600) (fail "Bad expiration time")
        t <- getUnixTime
        let i =
              header
                <> "."
                <> toB64
                  ( "{\"iss\":\""
                      <> iss
                      <> "\","
                      <> maybe T.empty (\e -> "\"sub\":\"" <> e <> "\",") msub
                      <> "\"scope\":\""
                      <> T.intercalate " " scs
                      <> "\",\"aud\
                         \\":\"https://oauth2.googleapis.com/token\",\"exp\":"
                      <> toT (utSeconds t + CTime xt)
                      <> ",\"iat\":"
                      <> toT (utSeconds t)
                      <> "}"
                  )
        putStrLn $ show i
        return $
          either
            (pure $ Left "RSAError")
            (\s -> pure $ SignedJWT $ i <> "." <> encode (toStrict s))
            (rsassa_pkcs1_v1_5_sign hashSHA256 pk $ fromStrict i)

tokenURL :: String
tokenURL = "https://oauth2.googleapis.com/token"

data OauthResponse = OauthResponse {
  accessToken :: T.Text
}

newtype JWT = JWT String deriving Show 

instance FromJSON OauthResponse where 
  parseJSON = withObject "oauth_response" $ \t -> 
    OauthResponse <$> (t .: "access_token")

data OauthError = ParseError String | NetworkError Int | InvalidToken deriving (Show)

exchangeToken :: SignedJWT -> IO (Either OauthError JWT)
exchangeToken (SignedJWT tokenBS) = do
  initReq <- parseRequest tokenURL
  let request =
        setRequestMethod "POST" $
          setRequestBodyURLEncoded [("grant_type", "urn:ietf:params:oauth:grant-type:jwt-bearer"), ("assertion", tokenBS)] $ initReq
  result <- httpJSONEither request
  case getResponseStatusCode result of
    200 ->
       case getResponseBody result of
        Left err -> return $ Left $ ParseError $ show err
        Right r -> do
            _ <- putStrLn $ show r
            case fromJSON r of
              Error err -> return $ Left $ ParseError $ show err
              Success (OauthResponse accessToken) -> return $ Right (JWT $ T.unpack accessToken)
    401 -> return $ Left $ InvalidToken
    400 -> do 
       _ <- putStrLn $ show result
       return $ Left $ NetworkError 400  
    code -> return $ Left $ NetworkError code  

getJWTToken :: AppM (Either OauthError JWT)
getJWTToken = do
  conf <- asks googleSecrets
  case decode conf of
    Nothing -> return $ Left $ ParseError "wrong file"
    Just gs -> do
      token <- liftIO $ getJWT (clientEmal gs) (T.unpack $ privateKey gs)
      liftIO $ putStrLn $ show token 
      result <- liftIO $  exchangeToken token 
      return $  result

getJWT :: T.Text -> String -> IO SignedJWT
getJWT serviceAccountEmail pkey = do
  pkey' <- fromPEMString $ pkey
  res <- getSignedJWT serviceAccountEmail Nothing [T.pack "https://www.googleapis.com/auth/firebase.messaging"] Nothing pkey'
  case res of
    Left e -> error $ "failed to make Signed JWT" ++ e
    Right r -> return r

instance FromJSON GoogleSecret where
  parseJSON = withObject "google_secret" $ \t ->
    GoogleSecret <$> (t .: "private_key") <*> (t .: "type") <*> (t .: "client_email")