{ connect } = require \react-redux
{ div, h1, input, img, label } = require \react-dom-factories
{ create-factory } = require \react
{ Button } = require \material-ui


button = create-factory Button



# React Redux Bindings


map-state-to-props = ({ create }) ->
  create


map-dispatch-to-props = (dispatch) ->
  on-publish: (questions, category-id) ->
    ->
      dispatch { type: \QUIZ_CREATE_PUBLISH, questions, category-id }



# Main Component


main = ({ questions, category-id, on-publish }) ->
  div {},
    button { on-click: on-publish questions, category-id }, "publish"



# Connected Main Component


module.exports = create-factory <| connect map-state-to-props, map-dispatch-to-props <| main
