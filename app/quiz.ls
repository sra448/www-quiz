{ create-element } = require \react
{ create-store, apply-middleware } = require \redux
{ render } = require \react-dom
{ Provider } = require \react-redux
{ create-epic-middleware } = require \redux-observable


reducer = require "./state/reducer.ls"
epic = require "./state/epic.ls"
main-component = require "./components/main.ls"



# bind redux store to component


epic-middleware = create-epic-middleware epic
store = create-store reducer, apply-middleware epic-middleware
app = create-element Provider, { store }, main-component {}



# kick off app

render app, document.get-element-by-id \main
store.dispatch { type: \APP_LOADED }
