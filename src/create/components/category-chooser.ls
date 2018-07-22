{ div, h1, h2, button, input, img, label } = require "../../dom-elements.ls"


camera-button = require "./camera-button.ls"


category = ({ id, title, select-category }) ->
  camera-button {
    id: "category#{id}",
    class-name: "button box",
    onclick: (image) -> select-category { id, image }
  }, title


module.exports = ({ state, actions }) ->
  div { class-name: "categories" },
    h1 {},
      div {}, "wWw"
      div {}, "Quiz"
    div {},
      category { id: 1, title: "Wer", select-category: actions.select-category }
      category { id: 2, title: "Wo", select-category: actions.select-category }
      category { id: 3, title: "Was", select-category: actions.select-category }
