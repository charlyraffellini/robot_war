_ = require("lodash")

module.exports = class Rotor
  @Positive: ->
    new Rotor 1
  @Negative: ->
    new Rotor -1
  constructor: (@sense) ->

  rotate: (position) ->
    _.cloneDeepWith position, (value, key) =>
      if key is "facing" then return ((value + 4 + @sense) % 4)
