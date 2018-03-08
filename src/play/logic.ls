{ Observable } = require \rxjs
{ random, values, shuffle, take } = require \lodash
Vibrant = require \node-vibrant



# helper functions


enhance-question = (question) ->
  { ...question, letters: letters-for-word question.answer }


letters-for-word = (word) ->
  amount = word.length * 2 + 2
  random-letters = [0 to amount].map random-letter
  shuffle take [...word, ...random-letters], amount


random-letter = ->
  String.from-char-code random 97, 122


rgb-to-hex = (rgb) ->
  hex = Number(rgb).toString 16
  hex = "0" + hex if hex.length < 2
  hex


get-palette = (img) ->
  Vibrant
    .from img
    .get-palette()



# actions


load-quiz = (quiz) -> (state, actions) ->
  questions = values(quiz).map enhance-question
  new-state = { ...initial-state, questions }
  image = new-state.questions[0].image
  actions.reset-palette image
  new-state


select-letter = ({ letter, id }) -> (state) ->
  answer = state.questions[state.current-question-id].answer

  if state.used-letters.length >= answer.length &&
     (state.used-letters.index-of undefined) == -1

    state
  else
    i = if (state.used-letters.index-of undefined) >= 0
      state.used-letters.index-of undefined
    else
      state.used-letters.length

    used-letters = state.used-letters
    used-letters[i] = [id, letter]
    { ...state, used-letters }


remove-letter = (i) -> (state) ->
  used-letters = state.used-letters
  used-letters[i] = undefined

  { ...state, used-letters }


next = -> (state, actions) ->
  if state.current-question-id + 1 < state.questions.length
    current-question-id = state.current-question-id + 1
    new-state = { ...state, current-question-id, used-letters: [] }
    image = state.questions[current-question-id].image
    actions.reset-palette image
    new-state

  else
    { ...state, completed: true }


reset-palette = (image) -> (state, actions) ->
  get-palette(image)
    .then(actions.set-palette)


set-palette = (palette) -> (state) ->
  { ...state, palette }



# module


initial-state = {
  questions: []
  current-question-id: 0
  used-letters: []
  palette: {}
  completed: false
}


module.exports = {
  state: initial-state,
  actions: {
    load-quiz,
    select-letter,
    remove-letter,
    next,
    reset-palette,
    set-palette
  }
}
