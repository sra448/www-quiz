initial-create-question-state = {
  image: undefined
  answer: ""
}


select-category = (state, category-id) ->
  { ...state, category-id }


add-question = (image, state) -->
  current-question-id = state.current-question-id + 1
  question = { ...initial-create-question-state, image }
  questions = { ...state.questions, "#{current-question-id}": question }
  { ...state, questions, current-question-id }


change-current-answer = (state, answer) ->
  { current-question-id } = state

  current-question = state.questions[current-question-id]
  question = { ...current-question, answer }
  questions = { ...state.questions, "#{current-question-id}": question }

  { ...state, questions }



# actions


initial-state = {
  is-creating: false
  category-id: undefined
  current-question-id: 0
  questions: {}
  is-finished: false
}



actions = {
  start: -> (state) ->
    { ...initial-state, is-creating: true }

  select-category: ({ id, image }) -> (state) ->
    select-category state, id
      |> add-question image

  add-question: (image) -> (state) ->
    add-question image, state

  change-current-text: (text) -> (state) ->
    change-current-answer state, text

  review: -> (state) ->
    { ...state, is-finished: true }

  publish: -> (state) ->
    { ...state, is-creating: false  }
}


module.exports = {
  actions,
  state: initial-state
}
