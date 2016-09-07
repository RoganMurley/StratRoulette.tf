port module Ports exposing (..)



port analyticsEvent : (String, String, String) -> Cmd msg

port location : String -> Cmd msg
