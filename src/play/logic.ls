{ Observable } = require \rxjs
Vibrant = require \node-vibrant


select-letter = (state, letter, id) ->
  answer = state.questions[state.current-question-id - 1].answer
  current-answer = state.current-answer + letter

  if answer.starts-with current-answer
    used-letters = [...state.used-letters, id]
    { ...state, current-answer, used-letters }

  else
    state


load-next-question = (state, actions) ->
  if state.current-question-id == state.questions.length
    { ...state, completed: true }

  else
    current-question-id = state.current-question-id + 1
    image = state.questions[current-question-id].image

    get-palette(image)
      .then(actions.set-palette)

    { ...state, current-question-id, current-answer: "", used-letters: [] }


rgb-to-hex = (rgb) ->
  hex = Number(rgb).toString 16
  hex = "0" + hex if hex.length < 2
  hex


get-palette = (img) ->
  Vibrant
    .from img
    .get-palette()



change-bg-palette = (state, palette) ->
  { ...state, palette }


initial-state = {
  questions: []
  current-question-id: 1
  current-answer: ""
  used-letters: []
  palette: {}
  completed: false
}


actions = {
  select-letter: ({ letter, id }) -> (state) ->
    select-letter state, letter, id
  next: ->
    load-next-question
  set-palette: (palette) ->
    (state) ->
      change-bg-palette state, palette
}


module.exports = {
  actions,
  state: initial-state
}
