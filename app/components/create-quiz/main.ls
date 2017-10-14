{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react


add-question-dialog = require "./add-question-dialog.ls"
camera-button = require "./camera-button.ls"


# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  quiz-in-creation


map-dispatch-to-props = (dispatch) ->
  on-category-click: (id) ->
    ({ image }) ->
      dispatch { type: \QUIZ_CREATE_CATEGORY_CHOOSE, id, image }


# components


categories = ({ on-category-click }) ->
  div {},
    h1 {}, "Quiz erstellen"
    camera-button { id: 1, on-click: on-category-click 1 }, "Wer"
    camera-button { id: 2, on-click: on-category-click 2 }, "Wo"
    camera-button { id: 3, on-click: on-category-click 3 }, "Was"



# Main Component


main = ({ current-question-id, on-category-click }) ->
  if current-question-id == 0
    categories { on-category-click }
  else
    add-question-dialog {}



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
