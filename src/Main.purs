module Main where

import Network.HTTP.Affjax
import Control.Monad.Aff (launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Prelude (($), (++), bind, Unit)


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

-- instance showMap :: Show Map where
  -- show (Map name _ _ _) = name

-- Strats.
data Strat = Strat Name Desc
