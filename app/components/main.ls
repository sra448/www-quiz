{ create-factory } = require \react
{ connect } = require \react-redux
{ div } = require \react-dom-factories


navigation = require "./navigation/main.ls"
play-quiz-dialog = require "./play-quiz/main.ls"
create-quiz-dialog = require "./create-quiz/main.ls"



# require the styles


require "./styles.scss"



# React Redux Bindings


map-state-to-props = ({ create, play }) ->
  {
    is-running: play.questions.length > 0,
    is-creating: create.is-creating
  }



# Main Component


main = ({ is-running, is-creating }) ->
  if is-running
    play-quiz-dialog {}
  else if is-creating
    create-quiz-dialog {}
  else
    navigation {}


# Connected Main Component


module.exports = create-factory <| connect map-state-to-props <| main
