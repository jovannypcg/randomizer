module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Random


-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init "rock"
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
    { tags : List Int
    , jokes : List String
    , gifUrl : String
    , gifTopic : String
    }


model : Model
model =
    { tags = []
    , jokes = []
    , gifUrl = ""
    , gifTopic = ""
    }


init : String -> ( Model, Cmd Msg )
init gifTopic =
    ( Model [] [] "" gifTopic, Cmd.none )



-- UPDATE


type Msg
    = GenerateTag
    | FindJoke
    | FindGif
    | NewTag Int
    | NewJoke (Result Http.Error String)
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateTag ->
            ( model, Random.generate NewTag (Random.int 0 100) )

        NewTag tag ->
            { model | tags = tag :: model.tags } ! []

        FindJoke ->
            ( model, getRandomJoke )

        NewJoke (Ok joke) ->
            ( { model | jokes = joke :: model.jokes }, Cmd.none )

        NewJoke (Err error) ->
            -- TODO: Show error in view
            model ! []

        FindGif ->
            model ! [ getRandomGif model.gifTopic ]

        NewGif (Ok url) ->
            { model | gifUrl = url } ! []

        NewGif (Err error) ->
            model ! []



-- REQUESTS


getRandomJoke : Cmd Msg
getRandomJoke =
    let
        url =
            "https://api.icndb.com/jokes/random"

        request =
            Http.get url decodeJoke
    in
    Http.send NewJoke request


decodeJoke : Decode.Decoder String
decodeJoke =
    Decode.at [ "value", "joke" ] Decode.string


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGif
    in
    Http.send NewGif request


decodeGif : Decode.Decoder String
decodeGif =
    Decode.at [ "data", "image_url" ] Decode.string



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ header
        , tagSection model.tags
        , divider
        , gifSection model.gifUrl
        , divider
        , jokeSection model.jokes
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


{-| Provides tags view.
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


{-| Provides jokes view.
-}
jokeSection : List String -> Html Msg
jokeSection jokes =
    section []
        [ h4 [ class "center" ] [ text "Jokes" ]
        , div [] (List.map toCard <| jokes)
        ]


{-| Displays text in form of a card by Materialize.
-}
toCard : String -> Html Msg
toCard content =
    div [ class "row container" ]
        [ div [ class "col s8 offset-s2" ]
            [ div [ class "card blue-grey darken-1" ]
                [ div [ class "card-content white-text center" ]
                    [ p [] [ text content ] ]
                ]
            ]
        ]


gifSection : String -> Html Msg
gifSection gif =
    section [ class "row container" ]
        [ div [ class "col s3 center" ] [ h4 [] [ text "GIF" ] ]
        , div [ class "col s9 center" ] [ img [ src gif ] [] ]
        ]


{-| Provides an Html divider.
-}
divider : Html msg
divider =
    div [ class "row" ]
        [ div [ class "col s8 offset-s2" ]
            [ div [ class "divider" ] [] ]
        ]
