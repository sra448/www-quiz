{ div, button, h1, input, img, label } = require "../../dom-elements.ls"
camera-button = require "./camera-button.ls"


module.exports = ({ state, actions }) ->
  { current-question-id, questions } = state
  { image, answer } = questions[current-question-id]

  div {},
    if current-question-id < 3
      camera-button { id: "next", onclick: actions.add-question }, "Next"
    else
      button { onclick: actions.review }, "Next"

    input { value: answer, onchange: ({ target }) -> actions.change-current-answer target.value }
    img { src: image }
