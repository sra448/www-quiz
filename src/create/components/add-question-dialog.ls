{ div, button, h1, input, img, label } = require "../../dom-elements.ls"
camera-button = require "./camera-button.ls"


module.exports = ({ state, actions }) ->
  { current-question-id, questions } = state
  { image, answer } = questions[current-question-id]

  div { class-name: "add-question", style: { background-image: "url(#{image})"} },
    div {},
      input {
        class-name: "textbox",
        placeholder: "Antwort eingeben",
        value: answer,
        onchange: ({ target }) -> actions.change-current-answer target.value
      }

    div {},
      if current-question-id < 3
        camera-button { id: "next", class-name: "button box", onclick: actions.add-question }, "Next"
      else
        button { class-name: "button box", onclick: actions.review }, "Next"
