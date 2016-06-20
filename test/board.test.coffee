include = require "include"
Board = include "src/Board"
Robot = include "src/Robot"
Position = include "src/Position"
Empty = include "src/Empty"

describe "Board", ->
  robotSample = new Robot(new Position(1,1,"top"))
  board = new Board 8, 8, [
    new Robot(new Position(0,0,"top")),
    robotSample,
    new Robot(new Position(5,5,"top")),
  ]

  it "can get the robot in position", ->
    position = new Position 5,5,"bottom"
    robot = board.getElementInPosition(position)
    robot.isInPosition(position)

  it "can get the empty element in position", ->
    position = new Position 5, 4,"bottom"
    element = board.getElementInPosition(position)
    (element instanceof Empty).should.be.true()

  it "can kill a robot", ->
    board.kill robotSample
    board.robots.length.should.be.exactly 2
    board.deadRobots.length.should.be.exactly 1
