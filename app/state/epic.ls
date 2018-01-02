{ Observable } = require \rxjs


rgb-to-hex = (rgb) ->
  hex = Number(rgb).toString 16
  hex = "0" + hex if hex.length < 2
  hex


get-color = (img) ->
  Observable.create (observer) ->
    image = new Image()
    image.onload = (->
      debugger
      canvas = document.create-element "canvas"
      canvas.width = image.width
      canvas.height = image.height

      context = canvas.get-context "2d"
      context.draw-image image, 0, 0

      image-data = context.get-image-data 0, 0, canvas.width, canvas.height

      # // Now you can access pixel data from image-data.data.
      # // It's a one-dimensional array of RGBA values.
      # // Here's an example of how to get a pixel's color at (x,y)

      index = (image.height * image-data.width + 0) * 4
      red = rgb-to-hex image-data.data[index]
      green = rgb-to-hex image-data.data[index + 1]
      blue = rgb-to-hex image-data.data[index + 2]

      # debugger
      observer.next "#{red}#{green}#{blue}")


    image.src = img



module.exports = (action$, store) ->
  action$
    .of-type \QUIZ_PLAY, \QUIZ_PLAY_NEXT_QUESTION
    # .switch-map ->
    #   { quiz-in-play } = store.get-state()
    #   image = quiz-in-play.questions[quiz-in-play.current-question-id - 1].image
    #   get-color image
    .map (color) ->
      { type: \QUIZ_CHANGE_COLOR, color }


