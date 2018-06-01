module Page.About.Model exposing (Model)

import Model.Dummy exposing (Dummy)


type alias Model =
    { pageTitle : String
    , pageBody : String
    , dummy : Dummy
    }
