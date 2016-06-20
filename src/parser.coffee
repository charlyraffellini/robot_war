include = require "include"
Board = include "src/Board"
Robot = include "src/Robot"
Position = include "src/Position"
Empty = include "src/Empty"

Parsimmon = require "parsimmon"

regex = Parsimmon.regex
string = Parsimmon.string
optWhitespace = Parsimmon.optWhitespace
lazy = Parsimmon.lazy

lexeme = (p) ->
  p.skip optWhitespace

stringLexeme = (string) ->
  lexeme(Parsimmon.string string)

lparen = lexeme(string('('))
rparen = lexeme(string(')'))

number = lexeme(regex(/[0-9]+/).map(parseInt))
id = lexeme(regex(/[a-z_]\w*/i))

newLex = stringLexeme "new"
boardLex = stringLexeme "Board"
robotLex = stringLexeme "Robot"
colonLex = stringLexeme ":"
movement = stringLexeme("P")
.or stringLexeme("N")
.or stringLexeme("M")
movements = movement.many()
runLex = stringLexeme "run"

facingLex = stringLexeme("top")
.or stringLexeme("bottom")
.or stringLexeme("left")
.or stringLexeme("right")

root = lazy 'an s-expression', ->
  newBoadExpression
  .or newRobotExpression
  .or robotPathExpression
  .or runExpression

newBoadExpression = Parsimmon.seqMap newLex, boardLex, number, number,
(__,___,x,y) ->
  (context) ->
    context.board = new Board(x, y)
    "Board of #{x}x#{y} Was Created Successfully"

newRobotExpression = Parsimmon.seqMap newLex, robotLex, number, number, facingLex,
(__,___,x,y, facing) ->
  (context) ->
    name = context.nextName()
    position = new Position x, y, facing
    robot = new Robot position, name
    context.board.addRobot robot
    "Robot namend \"#{name}\" Was Created Successfully"

robotPathExpression = Parsimmon.seqMap number, colonLex, movements,
(robotNumber, __, movements) ->
  (context) ->
    name = robotNumber.toString()
    context.movements[name] = movements
    "Path for Robot \"#{robotNumber}\" Was Created Successfully"

runExpression = runLex.map (__) ->
  (context) ->
    context.run()
    "Game Running"

module.exports = root
