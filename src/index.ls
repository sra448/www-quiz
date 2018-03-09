{ app } = require \hyperapp
{ div, h1, h2, button } = require "./dom-elements.ls"


view = require "./main/view.ls"


# require the styles


require "./styles.scss"


main = require "./main/logic.ls"
create = require "./create/logic.ls"
play = require "./play/logic.ls"


state = {
  ...main.state
  create: create.state,
  play: play.state,
}


actions = {
  ...main.actions,
  create: create.actions,
  play: play.actions
}


app state, actions, view, document.get-element-by-id "main"