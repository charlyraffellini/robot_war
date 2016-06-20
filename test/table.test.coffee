_ = require "lodash"
include = require "include"
Board = include "src/Board"
Robot = include "src/Robot"
Position = include "src/Position"
Table = include "src/Table"

removeColors = (string) ->
  string.replace(
    /[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]/g, '')

board = null
robot3 = null

describe "Table", ->
  beforeEach ->
    robot = new Robot(new Position(1,1,"top"), 0)
    robot1 = new Robot(new Position(7,7,"top"), 1)
    robot2 = new Robot(new Position(0,1,"top"), 2)
    robot3 = new Robot(new Position(2,1,"left"), 3)
    board = new Board 7, 7, [
      robot,
      robot1,
      robot2,
      robot3
    ]

  it "can render a printable table", ->
    table = new Table board
    result = table.toString()
    result = removeColors(result)

    result.should.be.exactly [
       '┌───┬────┬────┬────┬────┬────┬────┬────┬────┐'
      ,'│   │ 0  │ 1  │ 2  │ 3  │ 4  │ 5  │ 6  │ 7  │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 7 │ XX │ XX │ XX │ XX │ XX │ XX │ XX │ ↑1 │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 6 │ XX │ XX │ XX │ XX │ XX │ XX │ XX │ XX │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 5 │ XX │ XX │ XX │ XX │ XX │ XX │ XX │ XX │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 4 │ XX │ XX │ XX │ XX │ XX │ XX │ XX │ XX │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 3 │ XX │ XX │ XX │ XX │ XX │ XX │ XX │ XX │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 2 │ XX │ XX │ XX │ XX │ XX │ XX │ XX │ XX │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 1 │ ↑2 │ ↑0 │ ←3 │ XX │ XX │ XX │ XX │ XX │'
      ,'├───┼────┼────┼────┼────┼────┼────┼────┼────┤'
      ,'│ 0 │ XX │ XX │ XX │ XX │ XX │ XX │ XX │ XX │'
      ,'└───┴────┴────┴────┴────┴────┴────┴────┴────┘'
      ].join("\n")

  it "can render deads robots", ->
    robot3.goAhead(board)
    robot3.goAhead(board)

    table = new Table board
    table.printDeads().should.be.exactly """
Robot 0 dead by the 3's hands
Robot 2 dead by the 3's hands
"""
