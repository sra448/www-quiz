{ div, button, h1, input, img, label } = require "../dom-elements.ls"



modes = {
  1: "Wer"
  2: "Wo"
  3: "Was"
}



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
      div { class-name: "answer-letter", onclick: -> remove-letter i }, used-letters[i]?[1] || "\u00A0"



# Main Component


module.exports = ({ state, actions, new-game, stop-play }) ->
  { category-id, questions, completed, palette, used-letters, current-question-id } = state
  current-answer = (used-letters.map (l) -> l?[1]).join ""

  if !completed
    { image, answer, letters } = questions[current-question-id]
    style = { background: palette.LightVibrant?.get-hex(), border-color: palette.DarkVibrant?.get-hex() }

    div { style: background-color: palette.LightMuted?.get-hex() },
      div { class-name: "title input-letter", style }, "#{modes[category-id]} #{current-question-id + 1} / 3"
      div { class-name: "exit-button input-letter", style, onclick: stop-play }, "x"

      img { src: image }
      div { class-name: "input" },
        letter-answer { answer, used-letters, remove-letter: actions.remove-letter }
        letter-input { letters, used-letters, palette, on-letter-click: actions.select-letter }
        if answer.to-lower-case() == current-answer.to-lower-case()
          button { onclick: actions.next }, "bravo, next"

  else
    div {},
      h1 {}, "thanks"
      button { onclick: -> new-game() }, "weiter spielen"
      button {}, "quiz teilen"
      button {}, "eigenes quiz erstellen"
