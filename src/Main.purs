module Main where

import Control.Monad.Aff (launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.JSON ((.:), fail, class FromJSON, JValue(JObject))
import Network.HTTP.Affjax
import Prelude (($), (<$>), (<*>), (++), bind, class Show, Unit)


main :: Eff (ajax :: AJAX, console :: CONSOLE, err :: EXCEPTION) Unit
main = launchAff $ do
    res1 <- get "./api/maps"
    liftEff $ log $ "GET /api response: " ++ res1.response


-- Type synonyms.
type Name  = String
type Desc  = String
type Sixes = Prim.Boolean
type HL    = Prim.Boolean
type MM    = Prim.Boolean


-- Maps.
data Map = Map Name Sixes HL MM

instance showMap :: Show Map where
    show (Map name _ _ _) = name

instance mapFromJSON :: FromJSON Map where
    parseJSON (JObject o) =
        Map <$> (o .: "name")
            <*> (o .: "available.sixes")
            <*> (o .: "available.hl")
            <*> (o .: "available.mm")
    parseJSON _           = fail "Map parse failed."


-- Strats.
data Strat = Strat Name Desc

instance showStrat :: Show Strat where
    show (Strat name desc) = name ++ ": " ++ desc

instance stratFromJSON :: FromJSON Strat where
    parseJSON (JObject o) = Strat <$> (o .: "name") <*> (o .: "desc")
    parseJSON _           = fail "Strat parse failed."
