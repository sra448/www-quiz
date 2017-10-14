{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react


camera-button = require "./camera-button.ls"



# React Redux Bindings


map-dispatch-to-props = (dispatch) ->
  on-category-click: (id) ->
    ({ image }) ->
      dispatch { type: \QUIZ_CREATE_CATEGORY_CHOOSE, id, image }



# Main Component


main = ({ on-category-click }) ->
  div {},
    h1 {}, "Quiz erstellen"
    camera-button { id: "category1", on-click: on-category-click 1 }, "Wer"
    camera-button { id: "category2", on-click: on-category-click 2 }, "Wo"
    camera-button { id: "category3", on-click: on-category-click 3 }, "Was"



# Connected Main Component


module.exports = create-factory <| connect undefined, map-dispatch-to-props <| main
