{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-element } = require \react


camera-button = require "./camera-button.ls"


create-factory = (component) ->
  (...args) ->
    create-element component, ...args


# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  quiz-in-creation


map-dispatch-to-props = (dispatch) ->
  on-category-click: (id) ->
    ({ image }) ->
      dispatch { type: \QUIZ_CREATE_CATEGORY_CHOOSE, id, image }
  on-answer-change: (id) ->
    ({ target }) ->
      dispatch { type: \QUIZ_CREATE_QUESTION_ANSWER_CHANGE, id, text: target.value }
  on-next-click: ({ image }) ->
    dispatch { type: \QUIZ_CREATE_ADD_QUESTION, image }


# components


categories = ({ on-category-click }) ->
  div {},
    h1 {}, "Quiz erstellen"
    camera-button { id: 1, on-click: on-category-click 1 }, "Wer"
    camera-button { id: 2, on-click: on-category-click 2 }, "Wo"
    camera-button { id: 3, on-click: on-category-click 3 }, "Was"



# Main Component


main = ({ current-question-id, questions, category-id, on-category-click, on-answer-change, on-next-click }) ->
  if current-question-id == 0
    categories { on-category-click }
  else
    { image, answers } = questions[current-question-id]
    div {},
      input { value: answers[0], on-change: on-answer-change 0 }
      input { value: answers[1], on-change: on-answer-change 1 }
      input { value: answers[2], on-change: on-answer-change 2 }
      camera-button { id: "next", on-click: on-next-click }, "Weiter"
      img { src: image }



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
