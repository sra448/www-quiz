{ div, h1, a, button } = require "../dom-elements.ls"

play-view = require "../play/view.ls"
create-view = require "../create/view.ls"


require "./styles.scss"


module.exports = (state, actions) ->

  if state.mode == 0 # main.modes.main
    div { class-name: "start-screen" },
      h1 {},
        div {}, "wWw"
        div {}, "Quiz"
      div { class-name: "navigation" },
        button {
          id: "play",
          class-name: "box",
          onclick: actions.start-play
        }, "Spielen"
        button {
          id: "create",
          class-name: "box",
          onclick: actions.start-create
        }, "Erstellen"


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
