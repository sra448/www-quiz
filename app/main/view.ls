{ div, h1, a, button } = require "../dom-elements.ls"


module.exports = ({ state, actions }) ->
  div { class-name: "navigation" },
    h1 {}, "QUIZ OHNE NAME"
    if state.quizes.length > 0
      button { onclick: actions.start-play }, "Play"
    button { onclick: actions.start-create }, "asdf"
