module Main exposing (..)

import Html exposing (button, div, h1, text, Html)
import Html.App exposing (programWithFlags)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Random exposing (generate)

import List.Nonempty as Nonempty

import Location exposing (..)
import Strats exposing (getStrat, slug, strats, Strat)


main =
  programWithFlags {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }



-- MODEL
type Model = Start | Active Strat


init : String -> (Model, Cmd Msg)
init stratSlug =
  case getStrat stratSlug of
    Just strat ->
      (Active strat, Cmd.none)
    Nothing ->
      (Start, Cmd.none)



-- UPDATE
type Msg = Roll | Set Strat


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    Roll ->
      (model, generate Set (Nonempty.sample strats))

    Set strat ->
      (Active strat, location (slug strat))



-- VIEW
view : Model -> Html Msg
view model =
  case model of

    Start ->
      div []
        [
          div []
            [
              h1 [] [ text "Strat Roulette" ],
              div [] [ text "TF2 Strategy Generator" ]
          ],
          div [] [ button [ onClick Roll, class "roll-button" ] [ text "Roll" ] ]
        ]

    Active strat ->
      div []
        [
          div []
            [
              h1 [] [ text strat.name ],
              div [] [ text strat.desc ]
          ],
          div [] [ button [ onClick Roll, class "roll-button" ] [ text "Reroll" ] ]
        ]



-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
