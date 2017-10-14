{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


button = create-factory Button



# React Redux Bindings


map-state-to-props = ({ quiz-in-play }) ->
  quiz-in-play


map-dispatch-to-props = (dispatch) ->
  on-answer-click: (id) ->
    ->
      dispatch { type: \QUIZ_PLAY_ANSWER_CHOOSE, id }



# Main Component


main = ({ questions, current-question-id, on-answer-click }) ->
  { image, answers } = questions[current-question-id]

  div {},
    img { src: image }
    button { on-click: on-answer-click 0 }, answers[0]
    button { on-click: on-answer-click 1 }, answers[1]
    button { on-click: on-answer-click 2 }, answers[2]



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
