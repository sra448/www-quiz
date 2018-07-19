{ random } = require \lodash
{ get } = require \axios
firebase = require \firebase/app

require \firebase/firestore
require \firebase/storage


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
storage = firebase.storage().ref()



# getting a quiz


get-quiz = (id) ->
  Promise.all [
    (get-answers id),
    (get-images id)
  ]
    .then ([answers, images]) ->
      {
        category-id: 1,
        questions: {
          "1": {
            image: images[0],
            answer: answers.answer1
          },
          "2": {
            image: images[1],
            answer: answers.answer2
          },
          "3": {
            image: images[2],
            answer: answers.answer3
          },
        }
      }


get-answers = (quiz-id) ->
  db
    .collection "quizes"
    .doc quiz-id
    .get()
    .then (doc) ->
      doc.data()


random-quiz = (quizes) ->
  random-id = random 0, quizes.length - 1
  quiz = quizes[random-id] || {}


get-images = (quiz-id) ->
  Promise.all [
    (get-image "#{quiz-id}-1"),
    (get-image "#{quiz-id}-2"),
    (get-image "#{quiz-id}-3")
  ]


get-image = (id) ->
  storage.child id
    .get-download-URL()
    .then (url) ->
      get url, { responseType: "arraybuffer" }
    .then ({ data }) ->
      new Buffer(data, "binary").toString("base64")
    .then (str) ->
      "data:image/jpeg;base64,#{str}"



# saving a quiz


persist-quiz = (quiz) ->
  save-answers quiz
    .then (ref) -> ref.id
    .then save-images quiz


save-answers = (quiz) ->
  db.collection "quizes"
    .add {
      category-id: quiz.category-id
      answer1: quiz.questions["1"].answer
      answer2: quiz.questions["2"].answer
      answer3: quiz.questions["3"].answer
    }


save-images = (quiz) -> (quiz-id) ->
  save-image quiz-id, quiz.questions["1"].image, "1"
  save-image quiz-id, quiz.questions["2"].image, "2"
  save-image quiz-id, quiz.questions["3"].image, "3"


save-image = (name, image, id) ->
  storage
    .child("#{name}-#{id}")
    .putString((image.replace /\s/g, ""), "data_url", { contentType: "image/jpg" })



# actions


start-create = -> (state) ->
  { ...state, mode: modes.creating }


start-play = (quiz-id) -> (state, actions) ->
  # quiz = if quiz-id?
  #   get-quiz quiz-id
  # else
  #   random-quiz state.quizes

  get-quiz quiz-id
    .then (quiz) ->
      actions.start-quiz quiz

  state



start-quiz = (quiz) -> (state, actions) ->
  new-state = actions.play.load-quiz quiz
  { ...new-state, mode: modes.playing }


stop-play = -> (state) ->
  { ...state, mode: modes.main }


publish-quiz = (quiz) -> (state, actions) ->
  quizes = [...state.quizes, quiz]
  persist-quiz quiz
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
    start-quiz,
    stop-play,
    publish-quiz
  }
}
