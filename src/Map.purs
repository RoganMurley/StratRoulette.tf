module Map where


import Prelude (($), (<>), (#), bind, pure, class Show, show)

import Control.Bind ((>=>))
import Data.Foreign.Class (class IsForeign, readProp)
import Data.Foreign.Index (prop)


data Map =
    Map { name :: String, sixes :: Boolean, hl :: Boolean, mm :: Boolean }


instance showMap :: Show Map where
    show (Map o) =
        "(Map { name: "  <> show o.name  <> ", "  <>
               "sixes: " <> show o.sixes <> ", "  <>
               "hl: "    <> show o.hl    <> ", "  <>
               "mm: "    <> show o.mm    <> " })"


instance mapIsForeign :: IsForeign Map where
  read value = do
    name  <- readProp "name" value
    sixes <- value # (prop "available" >=> readProp "sixes")
    hl    <- value # (prop "available" >=> readProp "hl")
    mm    <- value # (prop "available" >=> readProp "mm")
    pure $ Map { name: name, sixes: sixes, hl: hl, mm: mm }
