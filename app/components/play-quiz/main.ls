{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


button = create-factory Button



# React Redux Bindings


map-state-to-props = ({ quiz-in-play }) ->
  quiz-in-play


map-dispatch-to-props = (dispatch) ->
  on-next: ->
    dispatch { type: \QUIZ_PLAY_NEXT_QUESTION }
  on-letter-click: (letter) ->
    ->
      dispatch { type: \QUIZ_PLAY_ANSWER_CHOOSE_LETTER, letter }



# Main Component


main = ({ questions, current-answer, current-question-id, on-letter-click, on-next }) ->
  { image, answer, letters } = questions[current-question-id - 1]

  div {},
    img { src: image }
    div {},
      letters.map (l) ->
        div { class-name: "letter", on-click: on-letter-click l }, l
    div {},
      [...answer].map (l, id) ->
        div { class-name: "answer letter" }, current-answer[id] || ""
    if answer == current-answer
      button { on-click: on-next }, "bravo, next"



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
