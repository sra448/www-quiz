{ random } = require \lodash



# helper functions


modes = {
  main: 0,
  creating: 1,
  playing: 2
}


random-quiz = (quizes) ->
  random-id = random 0, quizes.length - 1
  quiz = quizes[random-id] || {}


# actions


start-create = -> (state) ->
  { ...state, mode: modes.creating }


start-play = -> (state, actions) ->
  quiz = random-quiz state.quizes
  new-state = actions.play.load-quiz quiz
  { ...new-state, mode: modes.playing }


publish-quiz = (quiz) -> (state) ->
  quizes = [...state.quizes, quiz]
  local-storage.set-item "quizes", JSON.stringify quizes
  { ...state, quizes, mode: modes.main }



# module


module.exports = {
  modes,
  state: {
    mode: modes.main,
    quizes: JSON.parse (local-storage.get-item "quizes") || "[]"
  },
  actions: {
    start-create,
    start-play,
    publish-quiz
  }
}
