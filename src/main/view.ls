{ div, h1, a, button } = require "../dom-elements.ls"

play-view = require "../play/view.ls"
create-view = require "../create/view.ls"



module.exports = (state, actions) ->

  if state.mode == 0 # main.modes.main
    div { class-name: "navigation" },
      h1 {}, "QUIZ OHNE NAME"
      if state.quizes.length > 0
        button { onclick: actions.start-play }, "Play"
      button { onclick: actions.start-create }, "Create"


  else if state.mode == 1 # main.modes.creating
    create-view {
      state: state.create,
      actions: actions.create,
      publish: actions.publish-quiz
    }

  else if state.mode == 2 # main.modes.playing
    play-view {
      state: state.play,
      actions: actions.play,
      new-game: actions.start-play
      stop-play: actions.stop-play
    }
