{ random, values, shuffle, take } = require \lodash


enhance-question = (question) ->
  { ...question, letters: letters-for-word question.answer }


letters-for-word = (word) ->
  amount = word.length * 2 + 2
  random-letters = [0 to amount].map random-letter
  shuffle take [...word, ...random-letters], amount


random-letter = ->
  String.from-char-code random 97, 122


load-random-quiz = (state) ->
  random-id = random 0, state.quizes.length - 1
  quiz = state.quizes[random-id] || {}
  questions = values(quiz).map enhance-question
  play = { ...state.play, questions }

  { ...state, play, mode: modes.playing }


modes = {
  main: 0,
  creating: 1,
  playing: 2
}


initial-state = {
  mode: modes.main,
  quizes: JSON.parse (local-storage.get-item "quizes") || "[]"
}


actions = {
  start-create: -> (state) ->
    { ...state, mode: modes.creating }

  start-play: -> load-random-quiz

  publish-quiz: (quiz) -> (state) ->
    quizes = [...state.quizes, quiz]
    local-storage.set-item "quizes", JSON.stringify quizes
    { ...state, quizes, mode: modes.main }
}


module.exports = {
  actions,
  modes,
  state: initial-state
}
