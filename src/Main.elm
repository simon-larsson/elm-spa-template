module Main exposing (..)

import Html exposing (..)
import Json.Decode as Decode exposing (Value)
import Layout.Page as Page exposing (ActivePage)
import Navigation exposing (Location)
import Page.About.Function as AboutFunction
import Page.About.Message as AboutMessage
import Page.About.Model as AboutModel
import Page.About.Update as AboutUpdate
import Page.About.View as AboutView
import Page.Home.Function as HomeFunction
import Page.Home.Message as HomeMessage
import Page.Home.Model as HomeModel
import Page.Home.Update as HomeUpdate
import Page.Home.View as HomeView
import Page.NotFound as NotFound
import Route exposing (..)
import Util exposing ((=>))


---- MODEL ----


type alias Model =
    { page : Page
    }


type Page
    = Home HomeModel.Model
    | About AboutModel.Model
    | NotFound



---- UPDATE ----


type Msg
    = SetRoute (Maybe Route)
    | HomeMsg HomeMessage.Msg
    | AboutMsg AboutMessage.Msg


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    case route of
        Nothing ->
            -- TODO Load 404 page not found
            ( model, Cmd.none )

        Just Route.Home ->
            ( { model | page = Home HomeFunction.init }, Cmd.none )

        Just Route.About ->
            ( { model | page = About AboutFunction.init }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updatePage model.page msg model


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    let
        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
            ( { model | page = toModel newModel }, Cmd.map toMsg newCmd )
    in
    case ( msg, page ) of
        -- Update for page transitions
        ( SetRoute route, _ ) ->
            setRoute route model

        -- Update for page specfic msgs
        ( HomeMsg subMsg, Home subModel ) ->
            toPage Home HomeMsg HomeUpdate.update subMsg subModel

        ( AboutMsg subMsg, About subModel ) ->
            toPage About AboutMsg AboutUpdate.update subMsg subModel

        ( _, NotFound ) ->
            -- Disregard incoming messages when we're on the
            -- NotFound page.
            model => Cmd.none

        ( _, _ ) ->
            -- Disregard incoming messages that arrived for the wrong page
            model => Cmd.none



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        layout =
            Page.layout
    in
    case model.page of
        NotFound ->
            layout Page.Other NotFound.view

        Home subModel ->
            HomeView.view subModel
                |> layout Page.Home
                |> Html.map HomeMsg

        About subModel ->
            AboutView.view subModel
                |> layout Page.About
                |> Html.map AboutMsg



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- PROGRAM ----


initialPage : Page
initialPage =
    Home HomeFunction.init


init : Value -> Location -> ( Model, Cmd Msg )
init val location =
    setRoute (Route.fromLocation location)
        { page = initialPage
        }


main : Program Value Model Msg
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
