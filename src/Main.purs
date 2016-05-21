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
import Prelude (($), bind, pure, show, Unit)
import Signal.Channel (CHANNEL)
import Strat (Strat)


main :: Eff (ajax :: AJAX, channel :: CHANNEL, console :: CONSOLE, dom :: DOM, err :: EXCEPTION, random :: RANDOM) Unit
main = launchAff do
        res <- get "./api/strats"
        -- n <- liftEff $ randomInt 0 6
        -- liftEff $ log $ show $ index (stratsFromRes res.response) n
        strats <- pure $ stratsFromRes res.response
        liftEff $ interface strats
    where
        stratsFromRes res = fromRight (readJSON res :: F (Array Strat))


interface :: forall e. Array Strat -> Eff (channel :: CHANNEL, dom :: DOM, random :: RANDOM | e) Unit
interface strats = runFlareWith "controls_a" handler (intRange "numPoints" 1 100 10)


handler :: forall e. Int -> Eff (channel :: CHANNEL, dom :: DOM, random :: RANDOM | e) Unit
handler n = do
    n <- randomInt 0 6
    runFlareShow "controls_b" "output" (counter n)


counter :: forall e. Int -> UI e String
counter n = foldp (getValue) s (button "Roll" "" s)
    where s = show n :: String


getValue :: String -> String -> String
getValue new _ = new
