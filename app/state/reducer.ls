{ combine-reducers } = require \redux


create = require "./create-reducer.ls"
play = require "./play-reducer.ls"


module.exports = combine-reducers { create, play }
