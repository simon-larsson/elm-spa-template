module Page.About exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Model.Dummy exposing (Dummy)


---- MODEL ----


type alias Model =
    { pageTitle : String
    , pageBody : String
    , dummy : Dummy
    }


init : Model
init =
    { pageTitle = "About"
    , pageBody = "This is the aboutpage"
    , dummy = Dummy "Dummy of a shared model"
    }



-- UPDATE --


type Msg
    = Todo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Todo ->
            ( model, Cmd.none )



-- VIEW --


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.pageTitle ]
        , div [] [ text model.pageBody ]
        ]
