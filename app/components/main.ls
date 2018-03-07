navigation = require "./navigation/main.ls"
# play-quiz-dialog = require "./play-quiz/main.ls"
create-quiz-dialog = require "./create-quiz/main.ls"

{ div, h1, button } = require "../dom-elements.ls"



# require the styles


require "./styles.scss"



foo = ->
  debugger


# Main Component


module.exports = (state, actions) ->
  console.log("state", state)
  console.log("actions", actions)

  if false #state.play.is-running
    # play-quiz-dialog {}
    1 + 1
  else if state.create.is-creating
    create-quiz-dialog { state: state.create, actions: actions.create }
  else
    navigation { actions }
