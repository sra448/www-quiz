{ values, shuffle, random, take } = require \lodash


# State Definitions


initial-state =
  quiz-in-creation: undefined
  quiz-in-play: undefined
  quizes: JSON.parse (local-storage.get-item "quizes") || "[]"


initial-play-quiz-state =
  category-id: undefined
  questions: []
  current-answer: ""
  current-question-id: 1
  score: 0


initial-create-quiz-state =
  category-id: undefined
  current-question-id: 0
  questions: {}
  is-finished: false


initial-create-question-state =
  image: undefined
  answer: ""



# Create a quiz


create-quiz = (state) ->
  { ...state, quiz-in-creation: initial-create-quiz-state }


create-quiz-choose-category = (state, category-id) ->
  quiz-in-creation = { ...state.quiz-in-creation, category-id }
  { ...state, quiz-in-creation }


create-quiz-add-question = (image, state) -->
  current-question-id = state.quiz-in-creation.current-question-id + 1
  question = { ...initial-create-question-state, image }
  questions = { ...state.quiz-in-creation.questions, "#{current-question-id}": question }
  quiz-in-creation = { ...state.quiz-in-creation, questions, current-question-id }

  { ...state, quiz-in-creation }


create-quiz-change-question-answer = (state, answer) ->
  { quiz-in-creation } = state
  { current-question-id } = quiz-in-creation

  current-question = quiz-in-creation.questions[current-question-id]
  question = { ...current-question, answer }
  questions = { ...quiz-in-creation.questions, "#{current-question-id}": question }
  quiz-in-creation = { ...state.quiz-in-creation, questions }

  { ...state, quiz-in-creation }


create-quiz-show-preview = (state) ->
  { quiz-in-creation } = state
  quiz-in-creation = { ...state.quiz-in-creation, is-finished: true }
  { ...state, quiz-in-creation }


create-quiz-publish-current = (state) ->
  { questions, category-id } = state.quiz-in-creation
  quizes = [...state.quizes, { questions: values questions, category-id }]
  local-storage.set-item "quizes", JSON.stringify quizes
  { ...state, quizes, quiz-in-creation: undefined  }




# Play a quiz


load-random-quiz = (state) ->
  id = random 0, state.quizes.length - 1
  quiz = state.quizes[id] || {}
  questions = quiz.questions.map (q) ->
    { ...q, letters: get-letters-for q.answer }

  quiz-in-play = { ...initial-play-quiz-state, ...quiz, questions }
  { ...state, quiz-in-play }


get-letters-for = (word) ->
  amount = word.length * 2 + 2
  shuffle take [...word, ...([0 to amount].map -> String.from-char-code random 97, 122)], amount



current-quiz-choose-answer-letter = (state, letter) ->
  answer = state.quiz-in-play.questions[state.quiz-in-play.current-question-id - 1].answer
  current-answer = state.quiz-in-play.current-answer + letter

  if answer.starts-with current-answer
    quiz-in-play = { ...state.quiz-in-play, current-answer }
    { ...state, quiz-in-play }
  else
    state


load-next-question = (state) ->
  if state.quiz-in-play.current-question-id == 3
    quiz-in-play = { ...quiz-in-play, completed: true }
    { ...state, quiz-in-play }

  else
    current-question-id = state.quiz-in-play.current-question-id + 1
    quiz-in-play = { ...state.quiz-in-play, current-question-id, current-answer: "" }

    { ...state, quiz-in-play }


maybe-finish-quiz = (state) ->
  current-question-id = state.quiz-in-play.current-question-id

  if current-question-id <= 3
    state
  else
    { ...state, quiz-in-play: undefined }



# Reducer


module.exports = (state = initial-state, action) ->
  console.log action, state

  switch action.type

    case \QUIZ_PLAY
      load-random-quiz state

    case \QUIZ_PLAY_ANSWER_CHOOSE_LETTER
      current-quiz-choose-answer-letter state, action.letter
        # |> maybe-finish-quiz

    case \QUIZ_PLAY_NEXT_QUESTION
      load-next-question state

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

    case \QUIZ_CREATE_PUBLISH_CURRENT
      create-quiz-publish-current state

    default state
