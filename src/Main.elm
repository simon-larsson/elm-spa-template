module Main exposing (..)

import Html exposing (..)
import Navigation exposing (Location)
import Json.Decode as Decode exposing (Value)
import Page.Error as Error exposing (PageLoadError)
import Page.NotFound as NotFound
import Page.Home as Home
import Page.About as About
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
    | AboutMsg Home.Msg


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
    case model.pageState of
        Loaded page ->
            viewPage False page

        TransitioningFrom page ->
            viewPage True page


viewPage : Bool -> Page -> Html Msg
viewPage isLoading page =
    let
        layout =
            Page.layout isLoading
    in
        case page of
            NotFound ->
                NotFound.view
                    |> layout Page.Other

            Blank ->
                -- This is for the very intial page load, while we are loading
                -- data via HTTP. We could also render a spinner here.
                Html.text ""
                    |> layout Page.Other

            Error subModel ->
                Error.view subModel
                    |> layout Page.Other

            Home subModel ->
                Home.view subModel
                    |> layout Page.Home
                    |> Html.map HomeMsg

            About subModel ->
                Home.view subModel
                    |> layout Page.About
                    |> Html.map AboutMsg



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
