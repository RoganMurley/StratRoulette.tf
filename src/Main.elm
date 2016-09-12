module Main exposing (..)

import Html exposing (button, div, h1, text, Html)
import Html.App exposing (programWithFlags)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Random exposing (generate)

import List.Nonempty as Nonempty

import Ports exposing (location, analyticsEvent)
import Strats exposing (getStrat, removeStrat, slug, strats, Strat)


main =
  programWithFlags {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }



-- MODEL
type Model =
  Start |
  Active {
    strat: Strat,
    remaining: Nonempty.Nonempty Strat
  }


init : String -> (Model, Cmd Msg)
init stratSlug =
  case getStrat stratSlug strats of
    Just strat ->
      (Active { strat = strat, remaining = removeStrat stratSlug strats }, Cmd.none)
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
      let
        mySlug = slug strat
        batch = Cmd.batch([
          location mySlug,
          analyticsEvent ("roulette", "roll", mySlug)
        ])
      in
        case model of
          Start ->
            (Active { strat = strat, remaining = removeStrat mySlug strats }, batch)
          Active { remaining } ->
            (Active { strat = strat, remaining = removeStrat mySlug remaining }, batch)



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

    Active { strat } ->
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
