{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react


camera-button = require "./camera-button.ls"


# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  quiz-in-creation


map-dispatch-to-props = (dispatch) ->
  on-answer-change: (id) ->
    ({ target }) ->
      dispatch { type: \QUIZ_CREATE_QUESTION_ANSWER_CHANGE, id, text: target.value }
  on-next-click: ({ image }) ->
    dispatch { type: \QUIZ_CREATE_ADD_QUESTION, image }



# Main Component


main = ({ current-question-id, questions, on-answer-change, on-next-click }) ->
  { image, answers } = questions[current-question-id]
  div {},
    input { value: answers[0], on-change: on-answer-change 0 }
    input { value: answers[1], on-change: on-answer-change 1 }
    input { value: answers[2], on-change: on-answer-change 2 }
    camera-button { id: "next", on-click: on-next-click }, "Weiter"
    img { src: image }



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
