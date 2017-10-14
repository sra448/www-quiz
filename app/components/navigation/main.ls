{ connect } = require \react-redux
{ div, h1, a } = require \react-dom-factories
{ create-element } = require \react
{ Button } = require \material-ui



create-factory = (component) ->
  (...args) ->
    create-element component, ...args


button = create-factory Button



# React Redux Bindings


map-dispatch-to-props = (dispatch) ->
  on-create-click: ->
    dispatch { type: \QUIZ_CREATE }



# Main Component


main = ({ on-create-click }) ->
  div {},
    h1 {}, "www quiz"
    button {}, "Play"
    button { on-click: on-create-click }, "Create"



# Connected Main Component


module.exports = create-factory <| connect undefined, map-dispatch-to-props <| main
