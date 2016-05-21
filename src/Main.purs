module Main where

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
import Flare
import Flare.Smolder (runFlareHTML)
import Prelude (($), (-), bind, pure, Unit)
import Signal.Channel (CHANNEL)
import Text.Smolder.HTML (h1)
import Text.Smolder.Markup (Markup, text)

import Strat (getDesc, getName, Strat)


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


roll :: Array Strat -> Int -> Boolean -> Markup
roll _      _ false = text ""
roll strats i true  = do
    h1 $ text $ getName strat
    text $ getDesc strat
    where
        strat = fromJust (index strats i)
