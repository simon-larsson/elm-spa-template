module Page.Home.Function exposing (init)

import Model.Dummy exposing (Dummy)
import Page.Home.Model exposing (Model)


init : Model
init =
    { pageTitle = "Home"
    , pageBody = "This is the homepage"
    , dummy = Dummy "Dummy of a shared model"
    }
