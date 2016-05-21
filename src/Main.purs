module Main where


import Flare
import Flare.Smolder (runFlareHTML)
import Text.Smolder.Markup as H

import Control.Monad.Aff (launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Random (randomInt, RANDOM)
import DOM (DOM)
import Data.Array (index, length)
import Data.Either.Unsafe (fromRight)
import Data.Foreign (F)
import Data.Foreign.Class (readJSON)
import Data.Maybe.Unsafe (fromJust)
import Network.HTTP.Affjax (AJAX, get)
import Prelude (($), (-), bind, pure, Unit)
import Signal.Channel (CHANNEL)
import Strat (getDesc, Strat)


main :: Eff (ajax :: AJAX, channel :: CHANNEL, console :: CONSOLE, dom :: DOM, err :: EXCEPTION, random :: RANDOM) Unit
main = launchAff do
        res <- get "./api/strats"
        strats <- pure $ stratsFromRes res.response
        liftEff $ interface strats
    where
        stratsFromRes res = fromRight (readJSON res :: F (Array Strat))


interface :: forall e. Array Strat -> Eff (channel :: CHANNEL, dom :: DOM, random :: RANDOM | e) Unit
interface strats = runFlareWith
    "controls"
    (handler strats)
    (button "Roll" true false)


handler :: forall e. Array Strat -> Boolean -> Eff (dom :: DOM, channel :: CHANNEL, random :: RANDOM | e) Unit
handler strats b = do
    n <- randomInt 0 ((length strats) - 1)
    runFlareHTML "null" "output" $ pure $ roll strats n b
    where
        getValue now past = now


roll :: Array Strat -> Int -> Boolean -> H.Markup
roll _      _ false = H.text ""
roll strats i true  = H.text $ getDesc $ fromJust (index strats i)
