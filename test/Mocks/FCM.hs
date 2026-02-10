module Mocks.FCM (
  mockSendPush
) where 

import Types(PushMonad(sendPush), PushError, AppM)
import Domain(Push(..), PushData)
import qualified Data.Text as T 

instance PushMonad AppM where 
    sendPush = mockSendPush

mockSendPush ::  Push -> AppM (Maybe PushError)
mockSendPush _ = return Nothing

