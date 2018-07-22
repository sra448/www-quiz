{ div, button, input, label } = require "../../dom-elements.ls"



on-image-change = (id, callback) ->
  ->
    input-field = document.get-element-by-id id
    file = input-field.files[0]
    reader = new FileReader()

    reader.add-event-listener "load", ({ target }) ->
      callback target.result
    , false

    reader.read-as-data-URL file



# Main Component


module.exports = ({ id, onclick, button-props, class-name }, children) ->
  onchange = on-image-change id, onclick
  div { class-name },
    input { id, onchange, type: "file", accept: "image/*", capture: "camera" }
    label { html-for: id },
      children
