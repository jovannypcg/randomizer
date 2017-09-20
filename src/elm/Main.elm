module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


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
    = GenerateTag
    | FindJoke
    | FindGif


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateTag ->
            model ! []

        FindJoke ->
            Model ! []

        FindGif ->
            model ! []



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ homePage
        ]


homePage : Html Msg
homePage =
    div []
        [ header
        ]


header : Html Msg
header =
    div [ class "navbar-fixed scrollspy" ]
        [ nav [ class "orange darken-4" ]
            [ div [ class "nav-wrapper container" ]
                [ a [ href "#", class "brand-logo" ] [ text "Randomizer" ]
                , ul [ id "nav-mobile", class "right hide-on-med-and-down" ]
                    [ li [] [ a [ onClick GenerateTag ] [ text "Tag" ] ]
                    , li [] [ a [ onClick FindJoke ] [ text "Joke" ] ]
                    , li [] [ a [ onClick FindGif ] [ text "GIF" ] ]
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
