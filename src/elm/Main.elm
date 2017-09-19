module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MODEL


type alias Model =
    {}


model : Model
model =
    {}


init : ( Model, Cmd Msg )
init =
    ( Model, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ homePage
        ]


homePage : Html msg
homePage =
    div []
        [ banner
        , divider
        , div [ class "container center" ]
            [ img [ src "static/img/material.png" ] [] ]
        ]


banner : Html msg
banner =
    div []
        [ section []
            [ div [ class "row" ]
                [ div [ class "col s12" ]
                    [ h2 [ class "grey-text text-darken-4 center" ] [ text "Hello World!" ] ]
                ]
            ]
        ]


{-| Provides an Html divider
-}
divider : Html msg
divider =
    div [ class "row" ]
        [ div [ class "col s8 offset-s2" ]
            [ div [ class "divider" ] [] ]
        ]
