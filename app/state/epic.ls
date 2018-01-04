{ Observable } = require \rxjs
Vibrant = require \node-vibrant


rgb-to-hex = (rgb) ->
  hex = Number(rgb).toString 16
  hex = "0" + hex if hex.length < 2
  hex


get-palette = (img) ->
  Observable.from-promise do
    Vibrant
      .from img
      .get-palette()


module.exports = (action$, store) ->
  action$
    .of-type \QUIZ_PLAY, \QUIZ_PLAY_NEXT_QUESTION
    .flat-map ->
      { play } = store.get-state()
      image = play.questions[play.current-question-id - 1].image
      get-palette image
    .map (palette) ->
      # debugger
      { type: \QUIZ_CHANGE_COLOR, color: palette.DarkVibrant.get-hex() }


