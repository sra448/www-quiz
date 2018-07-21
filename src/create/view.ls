categories = require "./components/category-chooser.ls"
add-question-dialog = require "./components/add-question-dialog.ls"
publish-screen = require "./components/publish-screen.ls"


require "./styles.scss"


module.exports = ({ state, actions, publish }) ->
  { category-id, is-finished } = state

  if !category-id?
    categories { state, actions }
  else if !is-finished
    add-question-dialog { state, actions }
  else
    publish-screen { state, publish }
