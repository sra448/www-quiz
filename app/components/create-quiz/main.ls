{ connect } = require \react-redux
{ create-factory } = require \react


categories = require "./category-chooser.ls"
add-question-dialog = require "./add-question-dialog.ls"
publish-screen = require "./publish-screen.ls"



# require the styles


require "./styles.scss"



# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  quiz-in-creation



# Main Component


main = ({ category-id, is-finished }) ->
  if !category-id?
    categories {}
  else if !is-finished
    add-question-dialog {}
  else
    publish-screen {}



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props <| main
