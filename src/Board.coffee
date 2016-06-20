_ = require "lodash"
include = require "include"
Empty = include "src/Empty"
Robot = include "src/Robot"

module.exports =
class Board
  constructor: (@maxX, @maxY, @robots = []) ->
    @deadRobots = []

  getElementInPosition: (position) ->
    value = _.find @robots, (robot) ->
      robot.isInPosition position
    value || new Empty

  kill: (robot, killer) =>
    @robots = _.filter @robots, (it) => not(it is robot)
    @deadRobots =
    _.concat @deadRobots, new DeadRobot(robot, killer)

  addRobot: (robot) =>
    @robots.push robot

class DeadRobot
  constructor: ({ @name }, @killer) ->

  getKillerName: =>
    @killer.name
