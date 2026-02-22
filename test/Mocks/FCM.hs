module Mocks.FCM (
  mkMockPush
) where 

import Types(PushError, AppM, Pusher(..))
import Domain(Push(..), PushData)
import qualified Data.Text as T 

mkMockPush :: Pusher
mkMockPush = Pusher {
  send = \_  -> return Nothing
}