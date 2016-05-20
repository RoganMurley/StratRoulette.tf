module Main where

import Control.Bind ((>=>))
import Control.Monad.Aff (launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Foreign (F)
import Data.Foreign.Class (class IsForeign, readJSON, readProp)
import Data.Foreign.Index (prop)
import Network.HTTP.Affjax
import Prelude (($), (++), (<>), (#), bind, pure, class Show, show, Unit)


main :: Eff (ajax :: AJAX, console :: CONSOLE, err :: EXCEPTION) Unit
main = launchAff $ do
    res1 <- get "./api/maps"
    liftEff $ log $ "GET /api response: " ++ res1.response
    liftEff $ log $ show $ readJSON
        """
            {
                "name": "Badlands",
                "map_name": "cp_badlands",
                "available": {
                    "sixes": true,
                    "hl": false,
                    "mm": true
                }
            }
        """ :: F Map


-- Maps.
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


-- Strats.
data Strat = Strat { name :: String, desc :: String }

instance showStrat :: Show Strat where
    show (Strat o) =
        "(Strat { name: " <> show o.name <> ", desc: " <> show o.desc <> " })"

instance stratIsForeign :: IsForeign Strat where
  read value = do
    name <- readProp "name" value
    desc <- readProp "desc" value
    pure $ Strat { name: name, desc: desc }
