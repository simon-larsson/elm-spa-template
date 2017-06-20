module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Navigation exposing (Location)
import Json.Decode as Decode exposing (Value)
import Page.Home as Home
import Page.About as About
import Page.Error as Error exposing (PageLoadError)
import View.Page as Page exposing (ActivePage)
import Route exposing (..)
import Task
import Util exposing ((=>))


---- MODEL ----


type alias Model =
    { pageState : PageState
    }


type Page
    = Blank
    | NotFound
    | Error PageLoadError
    | Home Home.Model
    | About About.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page



---- UPDATE ----


type Msg
    = SetRoute (Maybe Route)
    | HomeLoaded (Result PageLoadError Home.Model)
    | HomeMsg Home.Msg
    | AboutLoaded (Result PageLoadError About.Model)
    | AboutMsg About.Msg


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    let
        transition toMsg task =
            { model | pageState = TransitioningFrom (getPage model.pageState) }
                => Task.attempt toMsg task

        error =
            pageError model
    in
        case maybeRoute of
            Nothing ->
                { model | pageState = Loaded NotFound } => Cmd.none

            Just Route.Home ->
                transition HomeLoaded (Home.init)

            Just Route.About ->
                transition AboutLoaded (About.init)


getPage : PageState -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page


pageError : Model -> ActivePage -> String -> ( Model, Cmd msg )
pageError model activePage errorMessage =
    let
        error =
            Error.pageLoadError activePage errorMessage
    in
        { model | pageState = Loaded (Error error) } => Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [] [ text "hello girl" ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- PROGRAM ----


initialPage : Page
initialPage =
    Blank


init : Value -> Location -> ( Model, Cmd Msg )
init val location =
    setRoute (Route.fromLocation location)
        { pageState = Loaded initialPage
        }


main : Program Value Model Msg
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
