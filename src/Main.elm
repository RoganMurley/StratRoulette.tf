import Html exposing (button, div, h1, text, Html)
import Html.App exposing (program)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Random exposing (generate)

import List.Nonempty as Nonempty

import Strats exposing (strats, Strat)


main =
  program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }



-- MODEL
type Model = Start | Active Strat


init : (Model, Cmd Msg)
init = (Start, Cmd.none)



-- UPDATE
type Msg = Roll | Set Strat


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    Roll ->
      (model, generate Set (Nonempty.sample strats))

    Set strat ->
      (Active strat, Cmd.none)



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
