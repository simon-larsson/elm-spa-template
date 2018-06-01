module Page.Home.View exposing (view)

import Html exposing (..)
import Page.Home.Message exposing (..)
import Page.Home.Model exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.pageTitle ]
        , div [] [ text model.pageBody ]
        ]
