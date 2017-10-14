{ connect } = require \react-redux
{ div, h1, input, label } = require \react-dom-factories
{ create-element } = require \react


camera-button = require "./camera-button.ls"


create-factory = (component) ->
  (...args) ->
    create-element component, ...args



# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  { quiz-in-creation }


map-dispatch-to-props = (dispatch) ->
  on-category-click: (category-id) ->
    (image) ->
      dispatch { type: \QUIZ_CREATE_CATEGORY_CHOOSE, id: category-id, image }



# Main Component


main = ({ on-category-click }) ->
  div {},
    h1 {}, "Quiz erstellen"
    camera-button { id: 1, on-click: on-category-click 1 }, "Wer"
    camera-button { id: 2, on-click: on-category-click 2 }, "Wo"
    camera-button { id: 3, on-click: on-category-click 3 }, "Was"



# Connected Main Component


module.exports = create-factory <| connect undefined, map-dispatch-to-props <| main
