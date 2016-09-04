module Util exposing (fromJust)



fromJust : Maybe a -> a
fromJust m =
  case m of

    Just x -> x

    Nothing -> Debug.crash "Used fromJust on Nothing."
