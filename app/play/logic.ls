{ shuffle, random, take, values } = require \lodash



initial-state =
  questions: []
  current-question-id: 1
  current-answer: ""
  used-letters: []
  palette: {}
  completed: false


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


change-bg-palette = (state, palette) ->
  { ...state, palette }



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
      change-bg-palette state, action.palette

    case \QUIZ_CREATE_PUBLISH
      create-quiz-publish state, action.questions, action.category-id

    default state



# actions


initial-state = {
  questions: []
  current-question-id: 1
  current-answer: ""
  used-letters: []
  palette: {}
  completed: false
}


  #
  # case \QUIZ_PLAY
  #   load-random-quiz state
  #
  # case \QUIZ_PLAY_ANSWER_CHOOSE_LETTER
  #   current-quiz-choose-answer-letter state, action.letter, action.id
  #
  # case \QUIZ_PLAY_NEXT_QUESTION
  #   load-next-question state
  #
  # case \QUIZ_CHANGE_COLOR
  #   change-bg-palette state, action.palette
  #
  # case \QUIZ_CREATE_PUBLISH
  #   create-quiz-publish state, action.questions, action.category-id


actions = {
  start: -> (state) -> load-random-quiz state
  select-letter: ->
    debugger
    current-quiz-choose-answer-letter state, action.letter, action.id
}


module.exports = {
  actions,
  state: initial-state
}
