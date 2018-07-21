{ div, button, h1, input, img, label } = require "../dom-elements.ls"


require "./styles.scss"


modes = {
  1: "Wer"
  2: "Wo"
  3: "Was"
}



# Components


letter-input = ({ letters, used-letters, style, on-letter-click }) ->
  div { class-name: "letters" },
    letters.map (l, id) ->
      is-used = !!used-letters.find (ul) -> ul?[0] == id
      class-name = if is-used then "input-letter used" else "input-letter"
      div { class-name, style, onclick: -> on-letter-click { letter: l, id } }, l


letter-answer = ({ answer, used-letters, remove-letter }) ->
  div {},
    [...answer].map (_, i) ->
      div { class-name: "answer-letter", onclick: -> remove-letter i }, used-letters[i]?[1] || "\u00A0"



# Main Component


module.exports = ({ state, actions, new-game, stop-play }) ->
  { category-id, questions, completed, palette, used-letters, current-question-id } = state
  current-answer = (used-letters.map (l) -> l?[1]).join ""

  letter-style = {
    background: (palette.LightVibrant || palette.LightMuted)?.get-hex(),
    border-color: palette.DarkVibrant?.get-hex() || "black"
  }

  if !completed
    { image, answer, letters } = questions[current-question-id]

    div { style: background-color: (palette.Muted || palette.darkMuted)?.get-hex() },
      div { class-name: "title input-letter", style: letter-style }, "#{modes[category-id]} #{current-question-id + 1} / 3"
      div { class-name: "exit-button input-letter", style: letter-style, onclick: stop-play }, "x"

      # # Palette Preview
      # div { style: { position: "absolute", top: 0, left: 0, right: 0 }},
      #   div { style: { width: 20, height: 40, background: palette.LightVibrant?.get-hex() } }, "LightVibrant"
      #   div { style: { width: 20, height: 40, background: palette.Vibrant?.get-hex() } }, "Vibrant"
      #   div { style: { width: 20, height: 40, background: palette.DarkVibrant?.get-hex() } }, "DarkVibrant"
      #   div { style: { width: 20, height: 40, background: palette.LightMuted?.get-hex() } }, "LightMuted"
      #   div { style: { width: 20, height: 40, background: palette.Muted?.get-hex() } }, "Muted"
      #   div { style: { width: 20, height: 40, background: palette.DarkMuted?.get-hex() } }, "DarkMuted"

      img { src: image }
      div { class-name: "input" },
        letter-answer { answer, used-letters, remove-letter: actions.remove-letter }
        letter-input { letters, used-letters, style: letter-style, on-letter-click: actions.select-letter }
        if answer.to-lower-case() == current-answer.to-lower-case()
          button { onclick: actions.next }, "bravo, next"

  else
    div {},
      h1 {}, "thanks"
      button { onclick: -> new-game() }, "weiter spielen"
      button {}, "quiz teilen"
      button {}, "eigenes quiz erstellen"
