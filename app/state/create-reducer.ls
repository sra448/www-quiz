{ values, shuffle, random, take } = require \lodash


# State Definitions


initial-state =
  is-creating: false
  category-id: undefined
  current-question-id: 0
  questions: {}
  is-finished: false


initial-create-question-state =
  image: undefined
  answer: ""



# Create a quiz


create-quiz = (state) ->
  { ...initial-state, is-creating: true }


create-quiz-choose-category = (state, category-id) ->
  { ...state, category-id }


create-quiz-add-question = (image, state) -->
  current-question-id = state.current-question-id + 1
  question = { ...initial-create-question-state, image }
  questions = { ...state.questions, "#{current-question-id}": question }
  { ...state, questions, current-question-id }


create-quiz-change-question-answer = (state, answer) ->
  { current-question-id } = state

  current-question = state.questions[current-question-id]
  question = { ...current-question, answer }
  questions = { ...state.questions, "#{current-question-id}": question }

  { ...state, questions }


create-quiz-show-preview = (state) ->
  { ...state, is-finished: true }


create-quiz-publish = (state) ->
  { ...state, is-creating: false  }



# Reducer


module.exports = (state = initial-state, action) ->
  console.log action, state

  switch action.type

    case \QUIZ_CREATE
      create-quiz state

    case \QUIZ_CREATE_CATEGORY_CHOOSE
      create-quiz-choose-category state, action.id
        |> create-quiz-add-question action.image

    case \QUIZ_CREATE_QUESTION_ANSWER_CHANGE
      create-quiz-change-question-answer state, action.text

    case \QUIZ_CREATE_ADD_QUESTION
      create-quiz-add-question action.image, state

    case \QUIZ_CREATE_SHOW_PREVIEW
      create-quiz-show-preview state

    case \QUIZ_CREATE_PUBLISH
      create-quiz-publish state

    default state
