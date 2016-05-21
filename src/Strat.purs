module Strat where


import Data.Foreign.Class (class IsForeign, readProp)
import Data.Foreign.Index (prop)
import Prelude (($), (<>), (#), bind, pure, class Show, show)


data Strat = Strat { name :: String, desc :: String }

instance showStrat :: Show Strat where
    show (Strat o) =
        "(Strat { name: " <> show o.name <> ", desc: " <> show o.desc <> " })"

instance stratIsForeign :: IsForeign Strat where
  read value = do
    name <- readProp "name" value
    desc <- readProp "desc" value
    pure $ Strat { name: name, desc: desc }

getDesc :: Strat -> String
getDesc (Strat o) = o.desc
