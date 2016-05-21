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
import Data.Int (odd)
import Data.Maybe.Unsafe (fromJust)
import Network.HTTP.Affjax (AJAX, get)
import Flare
import Flare.Smolder (runFlareHTML)
import Prelude (($), (-), (+), (<), bind, otherwise, pure, Unit)
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
    (foldp (+) 0 $ button "Roll" 1 1)


handler :: forall e. Array Strat -> Int -> Eff (dom :: DOM, channel :: CHANNEL, random :: RANDOM | e) Unit
handler strats n = do
    i <- randomInt 0 ((length strats) - 1)
    runFlareHTML "null" "output" $ pure $ roll strats i n


roll :: Array Strat -> Int -> Int -> Markup
roll strats i n
    | n < 3 = do
        h1 $ text $ "Strat Roulette"
        text $ "Version 0.1.0"
    | odd n = do
        h1 $ text $ getName strat
        text $ getDesc strat
    where
        strat = fromJust (index strats i)
    | otherwise = do
        h1 $ text $ "Rolling..."
        text $ "please wait"
