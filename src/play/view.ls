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
      class-name = if is-used then "input-letter box used" else "input-letter box"
      div { class-name, style, onclick: -> on-letter-click { letter: l, id } }, l


answer-letters = ({ answer, used-letters, remove-letter }) ->
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

    style = {
      background-color: (palette.Muted || palette.darkMuted)?.get-hex(),
      background-image: "url(#{image})"
    }

    div { class-name: "play-area", style },
      div { class-name: "header" },
        div { class-name: "box title", style: letter-style }, "#{modes[category-id]} #{current-question-id + 1} / 3"
        div { class-name: "box exit-button", style: letter-style, onclick: stop-play }, "x"
      div { class-name: "body" },
        answer-letters { answer, used-letters, remove-letter: actions.remove-letter }
      div { class-name: "input" },
        if answer.to-lower-case() == current-answer.to-lower-case()
          button { class-name: "box", style: letter-style, onclick: actions.next }, "bravo, next"
        else
          letter-input { letters, used-letters, style: letter-style, on-letter-click: actions.select-letter }

  else
    div {},
      h1 {}, "thanks"
      button { onclick: -> new-game() }, "weiter spielen"
      button {}, "quiz teilen"
      button {}, "eigenes quiz erstellen"
