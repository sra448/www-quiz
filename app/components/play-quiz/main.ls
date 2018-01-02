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
  { image, answers, letters } = questions[current-question-id - 1]

  div {},
    img { src: image }
    letters.map (l) ->
      div { class-name: "letter" }, l



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
