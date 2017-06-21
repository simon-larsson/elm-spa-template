module View.Page exposing (ActivePage(..), layout)

import Html exposing (..)
import Html.Attributes exposing (..)
import Route exposing (Route)


type ActivePage
    = Other
    | Home
    | About


{-| Take a page's Html and frame it with a header and footer.

The caller provides the current user, so we can display in either
"signed in" (rendering username) or "signed out" mode.

isLoading is for determining whether we should show a loading spinner
in the header. (This comes up during slow page transitions.)

-}
layout : Bool -> ActivePage -> Html msg -> Html msg
layout isLoading page content =
    div []
        [ viewHeader page isLoading
        , div [] [ content ]
        , viewFooter
        ]


viewHeader : ActivePage -> Bool -> Html msg
viewHeader page isLoading =
    nav []
        [ div []
            [ text "Template navbar: "
            , a [ Route.href Route.Home ]
                [ text "Home" ]
            , a [ Route.href Route.About ]
                [ text "About" ]
            ]
        ]


viewFooter : Html msg
viewFooter =
    footer []
        [ div [ class "container" ]
            [ span []
                [ text "Template footer"
                ]
            ]
        ]
