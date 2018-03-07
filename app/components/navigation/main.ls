{ div, h1, a, button } = require "../../dom-elements.ls"



# require the styles


require "./styles.scss"



# Main Component


module.exports = ({ actions }) ->
  div { class-name: "navigation" },
    h1 {}, "QUIZ OHNE NAME"
    # div {},
    #   button { onclick: on-play-click }, "Play"
    div {},
      button { onclick: actions.create.start }, "asdf"
