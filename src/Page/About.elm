module Page.About exposing (view, update, Model, Msg, init)

import Html exposing (..)
import Html.Attributes exposing (href)
import View.Page as Page
import Page.Error as Error exposing (PageLoadError, pageLoadError)


---- MODEL ----


type alias Model =
    { pageTitle : String
    , pageBody : String
    }


init : Model
init =
    let
        title =
            "About Page"

        body =
            "This is the page where you can read about the about page!"

        handleLoadError _ =
            -- Used only if page loading can fail, Tasks using HTTP and such
            Error.pageLoadError Page.Home "About is currently unavailable."
    in
        Model title body



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
        [ h1 [] [ text model.pageTitle ]
        , div [] [ text model.pageBody ]
        ]
