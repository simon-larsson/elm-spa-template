module Page.Home exposing (view, update, Model, Msg, init)

import Html exposing (..)
import Html.Attributes exposing (href)
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
            Task.succeed "Home Page"

        body =
            Task.succeed "Welcome to the homepage!"

        handleLoadError _ =
            -- If a resource task fail load error page
            Error.pageLoadError Page.Home "The homepage is currently unavailable."
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
