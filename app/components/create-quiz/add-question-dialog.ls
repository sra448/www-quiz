{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


camera-button = require "./camera-button.ls"
button = create-factory Button



# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  quiz-in-creation


map-dispatch-to-props = (dispatch) ->
  on-answer-change: (id) ->
    ({ target }) ->
      dispatch { type: \QUIZ_CREATE_QUESTION_ANSWER_CHANGE, id, text: target.value }
  on-next-click: ({ image }) ->
    dispatch { type: \QUIZ_CREATE_ADD_QUESTION, image }
  on-final-click: ->
    dispatch { type: \QUIZ_CREATE_SHOW_PREVIEW }



# Main Component


main = ({ current-question-id, questions, on-answer-change, on-next-click, on-final-click }) ->
  { image, answers } = questions[current-question-id]
  div {},
    input { value: answers[0], on-change: on-answer-change 0 }
    input { value: answers[1], on-change: on-answer-change 1 }
    input { value: answers[2], on-change: on-answer-change 2 }
    if current-question-id < 3
      camera-button { id: "next", on-click: on-next-click }, "Weiter"
    else
      button { on-click: on-final-click }, "Weiter"
    img { src: image }



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
