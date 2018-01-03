{ create-factory } = require \react
{ connect } = require \react-redux
{ div } = require \react-dom-factories


navigation = require "./navigation/main.ls"
play-quiz-dialog = require "./play-quiz/main.ls"
create-quiz-dialog = require "./create-quiz/main.ls"



# require the styles


require "./styles.scss"



# React Redux Bindings


map-state-to-props = ({ quiz-in-creation, quiz-in-play }) ->
  { quiz-in-creation, quiz-in-play }



# Main Component


main = ({ quiz-in-play, quiz-in-creation }) ->
  if quiz-in-play?
    play-quiz-dialog {}
  else if quiz-in-creation?
    create-quiz-dialog {}
  else
    navigation {}


# Connected Main Component


module.exports = create-factory <| connect map-state-to-props <| main
