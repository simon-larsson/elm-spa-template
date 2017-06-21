module Page.About exposing (view, update, Model, Msg, init)

import Html exposing (..)
import View.Page as Page
import Page.Error as Error exposing (PageLoadError, pageLoadError)
import Task exposing (Task)


---- MODEL ----


type alias Model =
    { pageTitle : String
    , pageBody : String
    }


init : Task PageLoadError Model
init =
    let
        -- Load page - Perform tasks to load the resources of a page
        title =
            Task.succeed "About Page"

        body =
            Task.succeed "About page is the page where you can read all about the about page!"

        handleLoadError _ =
            -- If a resource task fail load error page
            Error.pageLoadError Page.Home "The about page is currently unavailable."
    in
        Task.map2 Model title body
            |> Task.mapError handleLoadError



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
