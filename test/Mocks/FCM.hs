module Mocks.FCM (
  mkMockPush
) where 

import Types(PushError, AppM, Pusher(..))
import Domain(Push(..), PushData)
import qualified Data.Text as T 



mkMockPush :: Push ->  Pusher
mkMockPush expected = Pusher {
  send = \actual  -> 
    if expected /= actual then 
      error $ "wrong push request. Expected:" ++ show expected ++ ". Actual:" ++ show actual
    else 
      return Nothing
}

