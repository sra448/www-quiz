{ h } = require \hyperapp


elementFactory = (name) ->
  (options, ...children) ->
    h name, options, children


module.exports = {
  div: elementFactory "div"
  h1: elementFactory "h1"
  h2: elementFactory "h2"
  button: elementFactory "button"
  img: elementFactory "img"
  label: elementFactory "label"
  input: elementFactory "input"
  a: elementFactory "a"
}
