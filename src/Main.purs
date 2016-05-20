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
    Cons (Map "2Fort")        $
    Cons (Map "5Gorge")       $
    Cons (Map "Asteroid")       $
    Cons (Map "Badlands")     $
    Cons (Map "Badwater")     $
    Cons (Map "Barnblitz")    $
    Cons (Map "Borneo")       $
    Cons (Map "Cactus Canyon")$
    Cons (Map "Coldfront")    $
    Cons (Map "Degroot Keep") $
    Cons (Map "Doomsday")     $
    Cons (Map "Double Cross") $
    Cons (Map "Dustbowl")     $
    Cons (Map "Egypt")        $
    Cons (Map "Fastlane")     $
    Cons (Map "Foundry")      $
    Cons (Map "Freight")      $
    Cons (Map "Frontier")     $
    Cons (Map "Gold Rush")    $
    Cons (Map "Gorge")        $
    Cons (Map "Granary")      $
    Cons (Map "Gravel Pit")   $
    Cons (Map "Gullywash")    $
    Cons (Map "Harvest")      $
    Cons (Map "Highpass")     $
    Cons (Map "Hightower")    $
    Cons (Map "Hoodoo")       $
    Cons (Map "Hydro")        $
    Cons (Map "Junction")     $
    Cons (Map "Kong King")    $
    Cons (Map "Landfall")     $
    Cons (Map "Lakeside")     $
    Cons (Map "Mountain Lab") $
    Cons (Map "Metalworks")   $
    Cons (Map "Nightfall")    $
    Cons (Map "Nucleus")      $
    Cons (Map "Pipeline")     $
    Cons (Map "Powerhouse")   $
    Cons (Map "Probed")       $
    Cons (Map "Process")      $
    Cons (Map "Product")      $
    Cons (Map "Reckoner")     $
    Cons (Map "Sawmill")      $
    Cons (Map "Snakewater")   $
    Cons (Map "Snowplow")     $
    Cons (Map "Snowycoast")   $
    Cons (Map "Standin")      $
    Cons (Map "Steel")        $
    Cons (Map "Suijin")       $
    Cons (Map "Sunshine")     $
    Cons (Map "Thunder Mountain") $
    Cons (Map "Turbine")      $
    Cons (Map "Upward")       $
    Cons (Map "Vanguard")     $
    Cons (Map "Viaduct")      $
    Cons (Map "Watergate")    $
    Cons (Map "Well")         $
    Cons (Map "Yukon")        $
    Nil


-- Starts.
data Strat = Strat Name Desc

stratLefty :: Strat
stratLefty = Strat "Curse of the Lefty" "Use left-handed viewmodels."

stratPub :: Strat
stratPub = Strat "Valve Server" "Whole team can only play Sniper or Spy."

stratTrueFriends :: Strat
stratTrueFriends = Strat "True Friends" "If your medic dies, killbind."

stratTrain :: Strat
stratTrain = Strat "Train" "Unbind strafe keys."

stratDegroot :: Strat
stratDegroot = Strat "Straight Outta Degroot" "Medieval mode loadouts only."
