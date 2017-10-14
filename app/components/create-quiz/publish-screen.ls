{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


button = create-factory Button



# React Redux Bindings


map-state-to-props = ({ quiz-in-creation }) ->
  quiz-in-creation


map-dispatch-to-props = (dispatch) ->
  on-publish: ->
    dispatch { type: \QUIZ_CREATE_PUBLISH_CURRENT }



# Main Component


main = ({ on-publish }) ->
  div {},
    "you've done it"
    button { on-click: on-publish }, "publish"



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
