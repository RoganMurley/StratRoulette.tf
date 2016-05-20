module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.List (List(Cons, Nil))

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
    log "Hello"


-- Type synonyms.
type Name = String
type Desc = String


-- Maps.
data Map = Map Name

instance showMap :: Show Map where
  show (Map name) = name

allMaps :: List Map
allMaps =
    Cons (Map "Badlands")   $
    Cons (Map "Granary")    $
    Cons (Map "Gravel Pit") $
    Cons (Map "Gullywash")  $
    Cons (Map "Metalworks") $
    Cons (Map "Process")    $
    Cons (Map "Product")    $
    Cons (Map "Reckoner")   $
    Cons (Map "Snakewater") $
    Cons (Map "Sunshine")   $
    Nil


-- Starts.
data Strat = Strat Name Desc

stratLefty :: Strat
stratLefty = Strat "Curse of the Lefty" "Use left-handed viewmodels."

stratPub :: Strat
stratPub = Strat "Normal Pub" "Whole team can only play Sniper or Spy."

stratTrueFriends :: Strat
stratTrueFriends = Strat "True Friends" "If your medic dies, killbind."
