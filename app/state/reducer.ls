
initial-state =
  quiz-in-creation: undefined


module.exports = (state = initial-state, action) ->
  console.log action, state
  state
