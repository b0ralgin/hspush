module Mocks.FCM (
  mockSendPush
) where 

import Types(PushMonad(sendPush), PushError, AppM)
import qualified Data.Text as T 

instance PushMonad AppM where 
    sendPush = mockSendPush

mockSendPush :: String  -> T.Text -> T.Text -> AppM (Maybe PushError)
mockSendPush deviceID title text = return Nothing

