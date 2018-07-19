{ create-browser-history } = require \history
{ app } = require \hyperapp


{ div, h1, h2, button } = require "./dom-elements.ls"


view = require "./main/view.ls"
main = require "./main/logic.ls"
create = require "./create/logic.ls"
play = require "./play/logic.ls"


require "./styles.scss"


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


api = app state, actions, view, document.get-element-by-id "main"



# direct urls


history = create-browser-history()
path = history.location.pathname.replace("/", "")


if path != ""
  api.start-play path
