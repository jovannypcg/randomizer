module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random


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
    { tags : List Int }


model : Model
model =
    { tags = [] }


init : ( Model, Cmd Msg )
init =
    ( Model [], Cmd.none )



-- UPDATE


type Msg
    = GenerateTag
    | FindJoke
    | FindGif
    | NewTag Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateTag ->
            ( model, Random.generate NewTag (Random.int 0 100) )

        NewTag tag ->
            { model | tags = tag :: model.tags } ! []

        FindJoke ->
            model ! []

        FindGif ->
            model ! []



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ header
        , tagSection model.tags
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


{-| Provides tags view
-}
tagSection : List Int -> Html Msg
tagSection tags =
    section [ class "row container" ]
        [ div [ class "col s3 center" ] [ h4 [] [ text "Tags" ] ]
        , div [ class "col s9" ]
            (tags
                |> List.map toString
                |> List.map toTag
            )
        ]


{-| Creates a tag using "chip" class by Materialize.
-}
toTag : String -> Html Msg
toTag content =
    div [ class "chip" ] [ text content ]


{-| Provides an Html divider.
-}
divider : Html msg
divider =
    div [ class "row" ]
        [ div [ class "col s8 offset-s2" ]
            [ div [ class "divider" ] [] ]
        ]
