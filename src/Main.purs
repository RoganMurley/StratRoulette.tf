module Main where


import Flare
import Control.Monad.Aff (launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Random (randomInt, RANDOM)
import DOM (DOM)
import Data.Array (index)
import Data.Either.Unsafe (fromRight)
import Data.Foreign (F)
import Data.Foreign.Class (readJSON)
import Network.HTTP.Affjax (AJAX, get)
import Prelude (($), (+), bind, show, Unit)
import Signal.Channel (CHANNEL)

import Strat (Strat)


main :: Eff (ajax :: AJAX, channel :: CHANNEL, console :: CONSOLE, dom :: DOM, err :: EXCEPTION, random :: RANDOM) Unit
main = launchAff do
        res <- get "./api/strats"
        n <- liftEff $ randomInt 0 6
        liftEff $ log $ show $ index (stratsFromRes res.response) n
        liftEff $ interface
    where
        stratsFromRes res = fromRight (readJSON res :: F (Array Strat))


interface :: forall e. Eff (channel :: CHANNEL, dom :: DOM | e) Unit
interface = runFlareShow "controls" "output" counter

counter :: forall a. UI a Int
counter = foldp (+) 0 (button "Increment" 0 1)
