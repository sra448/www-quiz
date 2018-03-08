{ div, button, h1, input, img, label } = require "../dom-elements.ls"


# Components


letter-input = ({ letters, used-letters, palette, on-letter-click }) ->
  div { class-name: "letters" },
    letters.map (l, id) ->
      class-name = if id in used-letters then "input-letter used" else "input-letter"
      style = { background: palette.LightVibrant?.get-hex(), border-color: palette.DarkVibrant?.get-hex() }
      div { class-name, style, onclick: -> on-letter-click { letter: l, id } }, l


letter-answer = ({ answer, current-answer }) ->
  div {},
    [...answer].map (_, id) ->
      div { class-name: "answer-letter" }, current-answer[id]



# Main Component


module.exports = ({ state, actions }) ->
  { questions, current-answer, completed, palette, used-letters, current-question-id } = state

  if !completed
    { image, answer, letters } = questions[current-question-id - 1]

    div { style: background-color: palette.LightMuted?.get-hex() },
      img { src: image }
      div { class-name: "input" },
        letter-answer { answer, current-answer }
        letter-input { letters, used-letters, palette, on-letter-click: actions.select-letter }
        if answer == current-answer
          button { onclick: actions.next }, "bravo, next"
  else
    div {},
      h1 {}, "thanks"
      button { onclick: actions.new-game }, "weiter spielen"
      button {}, "quiz teilen"
      button {}, "eigenes quiz erstellen"
