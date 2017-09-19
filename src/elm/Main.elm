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
        [ header
        ]


header : Html msg
header =
    div [ class "navbar-fixed scrollspy" ]
        [ nav [ class "orange darken-4" ]
            [ div [ class "nav-wrapper container" ]
                [ a [ href "#", class "brand-logo" ] [ text "Randomizer" ]
                , ul [ id "nav-mobile", class "right hide-on-med-and-down" ]
                    [ li [] [ a [] [ text "Tag" ] ]
                    , li [] [ a [] [ text "Joke" ] ]
                    , li [] [ a [] [ text "GIF" ] ]
                    ]
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
