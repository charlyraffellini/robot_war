sinon = require "sinon"
include = require "include"
Context = include "src/Context"
Board = include "src/Board"

context = null
myRobot = null

describe "Context", ->
  beforeEach ->
    context = new Context()
    myRobot =
      name: "3"
      spin: sinon.spy()
      goAhead: sinon.spy()
    context.board = new Board 8, 8, [myRobot]
    context.movements["3"] = [ 'P', 'P', 'M', 'M', 'M', 'N', 'N' ]

  it "when run the robot movement methods are called the exactly amount of times", ->
    context.run()
    myRobot.spin.callCount.should.be.exactly 4
    myRobot.goAhead.callCount.should.be.exactly 3
