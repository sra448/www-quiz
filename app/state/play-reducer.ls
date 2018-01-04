{ shuffle, random, take, values } = require \lodash



initial-state =
  quizes: JSON.parse (local-storage.get-item "quizes") || "[]"
  questions: []
  current-question-id: 1
  current-answer: ""
  used-letters: []
  bg-color: "transparent"
  completed: false



load-random-quiz = (state) ->
  random-id = random 0, state.quizes.length - 1
  quiz = state.quizes[random-id] || {}
  questions = quiz.questions.map enhance-question
  { ...initial-state, questions }


enhance-question = (question) ->
  { ...question, letters: letters-for-word question.answer }


letters-for-word = (word) ->
  amount = word.length * 2 + 2
  random-letters = [0 to amount].map random-letter
  shuffle take [...word, ...random-letters], amount


random-letter = ->
  String.from-char-code random 97, 122


current-quiz-choose-answer-letter = (state, letter, id) ->
  answer = state.questions[state.current-question-id - 1].answer
  current-answer = state.current-answer + letter

  if answer.starts-with current-answer
    used-letters = [...state.used-letters, id]
    { ...state, current-answer, used-letters }

  else
    state


load-next-question = (state) ->
  if state.current-question-id == state.questions.length
    { ...state, completed: true }

  else
    current-question-id = state.current-question-id + 1
    { ...state, current-question-id, current-answer: "", used-letters: [] }


change-bg-color = (state, color) ->
  { ...state, color }


create-quiz-publish = (state, questions, category-id) ->
  quizes = [...state.quizes, { questions: values questions, category-id }]
  local-storage.set-item "quizes", JSON.stringify quizes
  { ...state, quizes }



# Reducer


module.exports = (state = initial-state, action) ->
  console.log action, state

  switch action.type

    case \QUIZ_PLAY
      load-random-quiz state

    case \QUIZ_PLAY_ANSWER_CHOOSE_LETTER
      current-quiz-choose-answer-letter state, action.letter, action.id

    case \QUIZ_PLAY_NEXT_QUESTION
      load-next-question state

    case \QUIZ_CHANGE_COLOR
      change-bg-color state, action.color

    case \QUIZ_CREATE_PUBLISH
      create-quiz-publish state, action.questions, action.category-id

    default state
