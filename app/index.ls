{ app } = require \hyperapp

{ div, h1, h2, button } = require "./dom-elements.ls"
{ actions, state } = require "./actions/create.ls"


view = require "./components/main.ls"


state = {
  create: state
}


actions = {
  create: actions
}



app state, actions, view, document.get-element-by-id "main"
