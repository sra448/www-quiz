initial-state =
  quiz-in-creation: undefined



create-quiz = (state) ->
  { ...state, quiz-in-creation: {} }


create-quiz-choose-category = (state, category-id) ->
  quiz-in-creation = { ...state.quiz-in-creation, category-id }
  { ...state, quiz-in-creation }



module.exports = (state = initial-state, action) ->
  console.log action, state

  switch action.type
    case \QUIZ_CREATE
      create-quiz state

    case \QUIZ_CREATE_CATEGORY_CHOOSE
      create-quiz-choose-category state, action.id

    default state
