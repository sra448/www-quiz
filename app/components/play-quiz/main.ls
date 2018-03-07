{ div, button, h1, input, img, label } = require "../../dom-elements.ls"





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



# Components


letter-input = ({ letters, used-letters, palette, on-letter-click }) ->
  div { class-name: "letters" },
    letters.map (l, id) ->
      class-name = if id in used-letters then "input-letter used" else "input-letter"
      style = { background: palette.LightVibrant?.get-hex(), border-color: palette.DarkVibrant?.get-hex() }
      div { class-name, style, onclick: (on-letter-click l, id) }, l


letter-answer = ({ answer, current-answer }) ->
  div {},
    [...answer].map (_, id) ->
      div { class-name: "answer-letter" }, current-answer[id]



# Main Component


main = ({ questions, current-answer, completed, palette, used-letters, current-question-id, on-new-game, on-letter-click, on-next }) ->
  if !completed
    { image, answer, letters } = questions[current-question-id - 1]

    div { style: background-color: palette.LightMuted?.get-hex() },
      img { src: image }
      div { class-name: "input" },
        letter-answer { answer, current-answer }
        letter-input { letters, used-letters, palette, on-letter-click }
        if answer == current-answer
          button { onclick: on-next }, "bravo, next"
  else
    div {},
      h1 {}, "thanks"
      button { onclick: on-new-game }, "weiter spielen"
      button {}, "quiz teilen"
      button {}, "eigenes quiz erstellen"


# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
