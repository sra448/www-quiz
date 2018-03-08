{ div, h1, input, img, label } = require "../../dom-elements.ls"


camera-button = require "./camera-button.ls"


module.exports = ({ state, actions }) ->
  div { class-name: "categories" },
    h1 {}, "Quiz erstellen"
    camera-button { id: "category1", onclick: (image) -> actions.select-category { id: 1, image } }, "Wer"
    camera-button { id: "category2", onclick: (image) -> actions.select-category { id: 2, image } }, "Wo"
    camera-button { id: "category3", onclick: (image) -> actions.select-category { id: 3, image } }, "Was"
