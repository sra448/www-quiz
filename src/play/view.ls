{ div, button, h1, input, img, label } = require "../dom-elements.ls"



# Components


letter-input = ({ letters, used-letters, palette, on-letter-click }) ->
  div { class-name: "letters" },
    letters.map (l, id) ->
      is-used = !!used-letters.find (ul) -> ul?[0] == id
      class-name = if is-used then "input-letter used" else "input-letter"
      style = { background: palette.LightVibrant?.get-hex(), border-color: palette.DarkVibrant?.get-hex() }
      div { class-name, style, onclick: -> on-letter-click { letter: l, id } }, l


letter-answer = ({ answer, used-letters, remove-letter }) ->
  div {},
    [...answer].map (_, i) ->
      div { class-name: "answer-letter", onclick: -> remove-letter i }, used-letters[i]?[1]



# Main Component


module.exports = ({ state, actions, new-game }) ->
  { questions, completed, palette, used-letters, current-question-id } = state
  current-answer = (used-letters.map (l) -> l?[1]).join ""

  if !completed
    { image, answer, letters } = questions[current-question-id]

    div { style: background-color: palette.LightMuted?.get-hex() },
      img { src: image }
      div { class-name: "input" },
        letter-answer { answer, used-letters, remove-letter: actions.remove-letter }
        letter-input { letters, used-letters, palette, on-letter-click: actions.select-letter }
        if answer == current-answer
          button { onclick: actions.next }, "bravo, next"

  else
    div {},
      h1 {}, "thanks"
      button { onclick: -> new-game() }, "weiter spielen"
      button {}, "quiz teilen"
      button {}, "eigenes quiz erstellen"
