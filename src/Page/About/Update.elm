module Page.About.Update exposing (update)

import Page.About.Message exposing (..)
import Page.About.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Todo ->
            ( model, Cmd.none )
