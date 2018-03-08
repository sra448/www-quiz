# WWW Quiz

```
npm install
npm start
http-serve
```


Diagram Redux (Flux?)


Hyperapp

- small
- simple
- functional

- very strict, actions cannot be handled in different "reducers"
- you need to accurately model your state

- no stateful components / no hidden state
- no context (for connect function)

- passing arguments all the way down / no connect function



Pros

- very simple and elegant
- calling actions just as functions is very nice and easy to reason about
- no action creators, no reducers - little boilerplate
- no need for special async solutions like in redux
- small size / fast execution


Cons

- cannot use react components / libraries
- no strategy for big apps
- some weird / different-from-react behavior on the virtual DOM
- purist library / not for pragmatists


Alternatives

- Redux Box
- Redux Rematch
