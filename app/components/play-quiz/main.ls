{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


button = create-factory Button



# React Redux Bindings


map-state-to-props = ({ play }) ->
  play


map-dispatch-to-props = (dispatch) ->
  on-next: ->
    dispatch { type: \QUIZ_PLAY_NEXT_QUESTION }
  on-letter-click: (letter, id) ->
    ->
      dispatch { type: \QUIZ_PLAY_ANSWER_CHOOSE_LETTER, letter, id }
  on-new-game: ->
    dispatch { type: \QUIZ_PLAY }



# Main Component


main = ({ questions, current-answer, completed, color, used-letters, current-question-id, on-new-game, on-letter-click, on-next }) ->
  if !completed
    { image, answer, letters } = questions[current-question-id - 1]

    div { style: background-color: color },
      img { src: image }
      div {},
        letters.map (l, id) ->
          class-name = if id in used-letters then "letter used" else "letter"
          div { class-name, on-click: on-letter-click l, id }, l
      div {},
        [...answer].map (l, id) ->
          div { class-name: "answer letter" }, current-answer[id] || ""
      if answer == current-answer
        button { on-click: on-next }, "bravo, next"
  else
    div {},
      h1 {}, "thanks"
      button { on-click: on-new-game }, "weiter spielen"
      button {}, "quiz teilen"
      button {}, "eigenes quiz erstellen"


# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
