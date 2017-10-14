{ div, input, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


button = create-factory Button



on-image-change = (id, callback) ->
  ->
    input-field = document.get-element-by-id id
    file = input-field.files[0]
    reader = new FileReader()

    reader.add-event-listener "load", ({ target }) ->
      callback { image: target.result }
    , false

    reader.read-as-data-URL file



# Main Component


module.exports = ({ id, on-click }, children) ->
  on-change = on-image-change id, on-click
  div {},
    input { id, on-change, type: "file", accept: "image/*", capture: "camera" }
    label { html-for: id },
      button {}, children
