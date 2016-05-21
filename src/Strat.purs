module Strat where


import Prelude (($), (<>), (#), bind, pure, class Show, show)

import Control.Bind ((>=>))
import Data.Foreign.Class (class IsForeign, readProp)
import Data.Foreign.Index (prop)


data Strat = Strat { name :: String, desc :: String }

instance showStrat :: Show Strat where
    show (Strat o) =
        "(Strat { name: " <> show o.name <> ", desc: " <> show o.desc <> " })"

instance stratIsForeign :: IsForeign Strat where
  read value = do
    name <- readProp "name" value
    desc <- readProp "desc" value
    pure $ Strat { name: name, desc: desc }
