{ Observable } = require \rxjs
{ random, values, shuffle, take } = require \lodash
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
    actions.reset-palette()
    current-question-id = state.current-question-id + 1
    { ...state, current-question-id, current-answer: "", used-letters: [] }


enhance-question = (question) ->
  { ...question, letters: letters-for-word question.answer }


letters-for-word = (word) ->
  amount = word.length * 2 + 2
  random-letters = [0 to amount].map random-letter
  shuffle take [...word, ...random-letters], amount


random-letter = ->
  String.from-char-code random 97, 122


reset-palette = (state, actions) ->
  image = state.questions[state.current-question-id].image
  if image
    get-palette(image)
      .then(actions.set-palette)


rgb-to-hex = (rgb) ->
  hex = Number(rgb).toString 16
  hex = "0" + hex if hex.length < 2
  hex


get-palette = (img) ->
  Vibrant
    .from img
    .get-palette()


set-palette = (state, palette) ->
  { ...state, palette }


load-quiz = (state, quiz) ->
  questions = values(quiz).map enhance-question
  { ...state, questions }


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
  reset-palette: ->
    reset-palette
  set-palette: (palette) ->
    (state) ->
      set-palette state, palette
}


module.exports = {
  actions,
  state: initial-state
}
