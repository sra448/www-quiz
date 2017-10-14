{ create-factory } = require \react
{ connect } = require \react-redux
{ div } = require \react-dom-factories


navigation = require "./navigation/main.ls"
create-dialog = require "./create-quiz/main.ls"



# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  { quiz-in-creation }



# Main Component


main = ({ quiz-in-creation }) ->
  div {},
    navigation {} if !quiz-in-creation
    create-dialog {} if quiz-in-creation?



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props <| main
