# Elm SPA Template

Simple SPA template.  Structured to handle each page as a separate module in a similar fashion to a MVC app. Made to be the bare minimum of a SPA but with a structure that can scale well.

This is basically a trimmed down version of the Elm [Real World](https://github.com/rtfeldman/elm-spa-example "Real World") example from Richard Feldman. So all credit to him.

## Get It Running

**1.** Install `elm` and `elm-live`:

> npm install -g elm elm-live

**2.** Build and run:

> elm-live --output=elm.js src/Main.elm --pushstate --open