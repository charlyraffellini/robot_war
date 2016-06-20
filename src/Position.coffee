_ = require "lodash"

module.exports =
class Position
  constructor: (@x, @y, facing) ->
    @stringToNumber =
      top: 0
      left: 1
      bottom: 2
      right: 3
    @numberToString = _.invert @stringToNumber

    @facing =
      if _.isString(facing)
      then @stringToNumber[facing]
      else facing

  readableFacing: ->
    @numberToString[@facing]

  next: ->
    dictionary =
      top: new Position @x, @y + 1, @facing
      left: new Position @x - 1, @y, @facing
      bottom: new Position @x, @y - 1, @facing
      right: new Position @x + 1, @y, @facing

    dictionary[@numberToString[@facing]]

  equals: (other) =>
    (this.x is other.x) and
    (this.y is other.y)

  validate: (maxX, maxY) ->
    if @x > maxX or
      @x < 0 or
      @y > maxY or
      @y < 0
    then throw new Error "Movements outside the boundaries are not allowed"
