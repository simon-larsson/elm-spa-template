module Page.Home.Update exposing (update)

import Page.Home.Message exposing (..)
import Page.Home.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Todo ->
            ( model, Cmd.none )
