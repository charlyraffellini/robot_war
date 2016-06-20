_ = require("lodash")

module.exports = class Robot
  constructor: (@position, @name = "") ->

  spin: (rotor) =>
    @position = rotor.rotate(@position)

  goAhead: (board) =>
    newPosition = @position.next()
    newPosition.validate(board.maxX, board.maxY)
    element = board.getElementInPosition newPosition
    element.dead board, @
    @position = newPosition

  dead: (board, killer) =>
    board.kill @, killer

  isInPosition: (position) =>
    @position.equals position

  readableFacing: =>
    @position.readableFacing()
