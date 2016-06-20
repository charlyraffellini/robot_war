include = require "include"
Board = include "src/Board"
Rotor = include "src/Rotor"
Position = include "src/Position"
Empty = include "src/Empty"
root = include "src/parser"
_ = require "lodash"

identityRunner = (lambdaMovements) ->
  _.forEach lambdaMovements, (it) => it()

module.exports =
class Context
  constructor: (@runner = identityRunner) ->
    @board = null
    @movements = {}
    @_secuence = 0

  run: =>
    lambdaMovements = @getAllFlattenedMovements()
    @runner(lambdaMovements)

  getAllFlattenedMovements: =>
    _.flatMap @movements, (robotMovements, robotName) =>
      robot = _.find @board.robots, (it) => it.name is robotName
      if (!robot) then throw new Error "Robot not found \"#{robotName}\" as #{typeof robotName}"
      @_getMovements(robot, robotMovements)

  _getMovements: (robot, robotMovements) =>
    _.map robotMovements, (it) =>
      movementToLambda =
        P: () => robot.spin(Rotor.Positive())
        N: () => robot.spin(Rotor.Negative())
        M: () => robot.goAhead(@board)

      movementToLambda[it]

  nextName: =>
    ret = @_secuence
    @_secuence++
    "#{ret}"
