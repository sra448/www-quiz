{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui
Add-icon = require "material-ui-icons/Add"


camera-button = require "./camera-button.ls"
button = create-factory Button
add-icon = create-factory Add-icon



# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  quiz-in-creation


map-dispatch-to-props = (dispatch) ->
  on-answer-change: ({ target }) ->
      dispatch { type: \QUIZ_CREATE_QUESTION_ANSWER_CHANGE, text: target.value }
  on-next-click: ({ image }) ->
    dispatch { type: \QUIZ_CREATE_ADD_QUESTION, image }
  on-final-click: ->
    dispatch { type: \QUIZ_CREATE_SHOW_PREVIEW }



# Main Component


main = ({ current-question-id, questions, on-answer-change, on-next-click, on-final-click }) ->
  { image, answer } = questions[current-question-id]
  button-props = { fab: true }

  div {},
    if current-question-id < 3
      camera-button { button-props, id: "next", on-click: on-next-click }
    else
      button { on-click: on-final-click, fab: true }

    input { value: answer, on-change: on-answer-change }
    img { src: image }



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
