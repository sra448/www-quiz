{ div, button } = require "../../dom-elements.ls"


module.exports = ({ state, publish }) ->
  { questions, category-id } = state

  div {},
    button { onclick: -> publish questions, category-id }, "publish"
