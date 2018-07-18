{ random } = require \lodash
firebase = require \firebase


modes = {
  main: 0,
  creating: 1,
  playing: 2
}


# firebase config


firebase.initializeApp {
  apiKey: "AIzaSyBiQUEUzIAs4BPqYR8z3CvrVcMnQQpaPws",
  authDomain: "quiz-48260.firebaseapp.com",
  databaseURL: "https://quiz-48260.firebaseio.com",
  projectId: "quiz-48260",
  storageBucket: "quiz-48260.appspot.com",
  messagingSenderId: "313622020172"
}

db = firebase.firestore()



# helper functions


random-quiz = (quizes) ->
  random-id = random 0, quizes.length - 1
  quiz = quizes[random-id] || {}


saveToDb = (quiz) ->
  db.collection "quizes"
    .add {
      category-id: quiz.category-id
      answer1: quiz.questions["1"].answer
      answer2: quiz.questions["2"].answer
      answer3: quiz.questions["3"].answer
    }



# actions


start-create = -> (state) ->
  { ...state, mode: modes.creating }


start-play = -> (state, actions) ->
  quiz = random-quiz state.quizes
  new-state = actions.play.load-quiz quiz
  { ...new-state, mode: modes.playing }


stop-play = -> (state) ->
  { ...state, mode: modes.main }


publish-quiz = (quiz) -> (state, actions) ->
  quizes = [...state.quizes, quiz]
  saveToDb quiz
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
    stop-play,
    publish-quiz
  }
}
