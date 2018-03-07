categories = require "./category-chooser.ls"
add-question-dialog = require "./add-question-dialog.ls"
publish-screen = require "./publish-screen.ls"



# require the styles


require "./styles.scss"



# Main Component


module.exports = ({ state, actions }) ->
  { category-id, is-finished } = state
  
  console.log "category-id, is-finished"
  console.log category-id, is-finished
  # debugger

  if !category-id?
    categories { state, actions }
  else if !is-finished
    add-question-dialog { state, actions }
  else
    publish-screen { state, actions }
