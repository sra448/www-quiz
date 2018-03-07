{ app } = require \hyperapp
{ div, h1, h2, button } = require "./dom-elements.ls"


main-view = require "./main/view.ls"
play-view = require "./play/view.ls"
create-view = require "./create/view.ls"


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


view = (state, actions) ->
  if state.mode == main.modes.main
    main-view {
      state,
      actions: actions
    }

  else if state.mode == main.modes.creating
    create-view {
      state: state.create,
      actions: actions.create,
      publish: actions.publish-quiz
    }

  else if state.mode == main.modes.playing
    play-view {
      state: state.play,
      actions: actions.play
    }


app state, actions, view, document.get-element-by-id "main"
