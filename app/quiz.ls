{ create-element } = require \react
{ create-store } = require \redux
{ render } = require \react-dom
{ Provider } = require \react-redux


reducer = require "./state/reducer.ls"
main-component = require "./components/main.ls"



# bind redux store to component


store = create-store reducer
app = create-element Provider, { store }, main-component {}



# kick off app

render app, document.get-element-by-id \main
store.dispatch { type: \APP_LOADED }
