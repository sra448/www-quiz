{ connect } = require \react-redux
{ div, h1, a } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


button = create-factory Button



# React Redux Bindings


map-dispatch-to-props = (dispatch) ->
  on-play-click: ->
    dispatch { type: \QUIZ_PLAY }
  on-create-click: ->
    dispatch { type: \QUIZ_CREATE }



# Main Component


main = ({ on-play-click, on-create-click }) ->
  div {},
    h1 {}, "www quiz"
    button { on-click: on-play-click }, "Play"
    button { on-click: on-create-click }, "Create"



# Connected Main Component


module.exports = create-factory <| connect undefined, map-dispatch-to-props <| main
