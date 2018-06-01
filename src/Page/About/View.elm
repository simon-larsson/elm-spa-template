module Page.About.View exposing (view)

import Html exposing (..)
import Page.About.Message exposing (..)
import Page.About.Model exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.pageTitle ]
        , div [] [ text model.pageBody ]
        ]
