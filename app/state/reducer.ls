initial-state =
  quiz-in-creation: undefined
  quizes: []


initial-new-quiz-state =
  category-id: undefined
  current-question-id: 0
  questions: {}
  is-finished: false


initial-new-question-state =
  image: undefined
  answers:
    0: "" # first value is the correct answer
    1: ""
    2: ""



create-quiz = (state) ->
  { ...state, quiz-in-creation: initial-new-quiz-state }


create-quiz-choose-category = (state, category-id) ->
  quiz-in-creation = { ...state.quiz-in-creation, category-id }
  { ...state, quiz-in-creation }


create-quiz-add-question = (image, state) -->
  current-question-id = state.quiz-in-creation.current-question-id + 1
  question = { ...initial-new-question-state, image }
  questions = { ...state.quiz-in-creation.questions, "#{current-question-id}": question }
  quiz-in-creation = { ...state.quiz-in-creation, questions, current-question-id }

  { ...state, quiz-in-creation }


create-quiz-change-question-answer = (state, id, text) ->
  { quiz-in-creation } = state
  { current-question-id } = quiz-in-creation
  current-question = quiz-in-creation.questions[current-question-id]
  answers = { ...current-question.answers, "#{id}": text }
  question = { ...current-question, answers }
  questions = { ...quiz-in-creation.questions, "#{current-question-id}": question }
  quiz-in-creation = { ...state.quiz-in-creation, questions }

  { ...state, quiz-in-creation }


create-quiz-show-preview = (state) ->
  { quiz-in-creation } = state
  quiz-in-creation = { ...state.quiz-in-creation, is-finished: true }
  { ...state, quiz-in-creation }


create-quiz-publish-current = (state) ->
  { questions, category-id } = state.quiz-in-creation
  quizes = [...state.quizes, { questions, category-id }]
  { ...state, quizes, quiz-in-creation: undefined  }



module.exports = (state = initial-state, action) ->
  console.log action, state

  switch action.type
    case \QUIZ_CREATE
      create-quiz state

    case \QUIZ_CREATE_CATEGORY_CHOOSE
      create-quiz-choose-category state, action.id
        |> create-quiz-add-question action.image

    case \QUIZ_CREATE_QUESTION_ANSWER_CHANGE
      create-quiz-change-question-answer state, action.id, action.text

    case \QUIZ_CREATE_ADD_QUESTION
      create-quiz-add-question action.image, state

    case \QUIZ_CREATE_SHOW_PREVIEW
      create-quiz-show-preview state

    case \QUIZ_CREATE_PUBLISH_CURRENT
      create-quiz-publish-current state

    default state
