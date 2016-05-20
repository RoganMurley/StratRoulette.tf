module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.List (List(Cons, Nil))

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
    log "Hello"


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

allMaps :: List Map
allMaps =
    Cons (Map "2Fort"             false false false) $
    Cons (Map "5Gorge"            false false false) $
    Cons (Map "Ashville"          false true  false) $
    Cons (Map "Asteroid"          false false false) $
    Cons (Map "Badlands"          true  false true ) $
    Cons (Map "Badwater"          false true  false) $
    Cons (Map "Barnblitz"         false true  false) $
    Cons (Map "Borneo"            false true  false) $
    Cons (Map "Cactus Canyon"     false false false) $
    Cons (Map "Coldfront"         false false false) $
    Cons (Map "Degroot Keep"      false false false) $
    Cons (Map "Doomsday"          false false false) $
    Cons (Map "Double Cross"      false false false) $
    Cons (Map "Dustbowl"          false false false) $
    Cons (Map "Egypt"             false false false) $
    Cons (Map "Fastlane"          false false false) $
    Cons (Map "Foundry"           false false true ) $
    Cons (Map "Freight"           false false false) $
    Cons (Map "Frontier"          false false false) $
    Cons (Map "Gold Rush"         false false false) $
    Cons (Map "Gorge"             false false true ) $
    Cons (Map "Granary"           true  false true ) $
    Cons (Map "Gravel Pit"        false false false) $
    Cons (Map "Gullywash"         true  true  true ) $
    Cons (Map "Harvest"           false false false) $
    Cons (Map "Highpass"          false false false) $
    Cons (Map "Hightower"         false false false) $
    Cons (Map "Hoodoo"            false false false) $
    Cons (Map "Hydro"             false false false) $
    Cons (Map "Junction"          false false false) $
    Cons (Map "Kong King"         false false false) $
    Cons (Map "Landfall"          false false false) $
    Cons (Map "Lakeside"          false true true  ) $
    Cons (Map "Mountain Lab"      false false false) $
    Cons (Map "Metalworks"        true  false false) $
    Cons (Map "Nightfall"         false false false) $
    Cons (Map "Nucleus"           false false false) $
    Cons (Map "Pipeline"          false false false) $
    Cons (Map "Powerhouse"        false false false) $
    Cons (Map "Probed"            false false false) $
    Cons (Map "Process"           true  false true ) $
    Cons (Map "Ramjam"            false true  false) $
    Cons (Map "Reckoner"          true  false false) $
    Cons (Map "Sawmill"           false false false) $
    Cons (Map "Snakewater"        true  false true ) $
    Cons (Map "Snowplow"          false false false) $
    Cons (Map "Snowycoast"        false false false) $
    Cons (Map "Standin"           false false false) $
    Cons (Map "Steel"             false true  false) $
    Cons (Map "Suijin"            false false false) $
    Cons (Map "Sunshine"          true  false false) $
    Cons (Map "Swiftwater"        false true  false) $
    Cons (Map "Thunder Mountain"  false false false) $
    Cons (Map "Turbine"           false false false) $
    Cons (Map "Upward"            false true  false) $
    Cons (Map "Vanguard"          false true  true ) $
    Cons (Map "Viaduct"           true  true  true ) $
    Cons (Map "Watergate"         false false false) $
    Cons (Map "Well"              false false false) $
    Cons (Map "Yukon"             false false false) $
    Nil


-- Starts.
data Strat = Strat Name Desc

stratLefty :: Strat
stratLefty = Strat "Curse of the Lefty" "Use left-handed viewmodels."

stratPub :: Strat
stratPub = Strat "Valve Server" "Whole team can only play Sniper or Spy."

strattrueFriends :: Strat
strattrueFriends = Strat "true Friends" "If your medic dies, killbind."

stratTrain :: Strat
stratTrain = Strat "Train" "Unbind strafe keys."

stratDegroot :: Strat
stratDegroot = Strat "Straight Outta Degroot" "Medieval mode loadouts only."
