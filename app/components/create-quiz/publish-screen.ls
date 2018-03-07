{ div, button } = require "../../dom-elements.ls"


module.exports = ({ state, actions }) ->
  { questions, category-id } = state

  div {},
    button { onclick: -> actions.publish questions, category-id }, "publish"
