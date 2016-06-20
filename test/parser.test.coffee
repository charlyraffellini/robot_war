sinon = require "sinon"
include = require "include"
Board = include "src/Board"
Robot = include "src/Robot"
Position = include "src/Position"
Empty = include "src/Empty"
root = include "src/parser"


describe "Parser", ->
  it "can parse a new board expression", ->
    context = {}
    result = root.parse('new   Board 5   8').value
    result(context)
    context.should.have.property "board"

  it "can parse a new robot expression", ->
    nextNameCallback = sinon.stub().returns(42)
    addRobotCallback = sinon.spy()
    context =
      nextName: nextNameCallback
      board: addRobot: addRobotCallback

    result = root.parse('new   Robot  5 8   top').value
    result(context)
    addRobotCallback.calledOnce.should.be.true()
    (addRobotCallback.getCall(0).args[0]).should.be.have.property "name"
    nextNameCallback.calledOnce.should.be.true()

  it "can parse a robot path expression", ->
    context = movements: {}
    result = root.parse('3:   P PM MMN').value
    result(context)
    context.movements.should.be.deepEqual(
      "3": [ 'P', 'P', 'M', 'M', 'M', 'N' ]
    )

  it "can parse a run expression", ->
    runCallback = sinon.spy()
    context = run: runCallback
    result = root.parse('run').value
    result(context)
    runCallback.calledOnce.should.be.true()
