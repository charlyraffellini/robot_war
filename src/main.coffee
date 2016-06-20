_ = require "lodash"
colors = require 'colors'
include = require "include"
Board = include "src/Board"
Robot = include "src/Robot"
Position = include "src/Position"
Rotor = include "src/Rotor"
Table = include "src/Table"
parser = include "src/parser"
Context = include "src/Context"
log = require('single-line-log').stdout;

repl = require 'repl'

stars = "*****************************************".magenta
mainTile = "        Robot War Is Starting        ".bgRed.black
startPage = """

#{stars}



#{mainTile}




#{stars}

"""

play = (movements) ->
  log startPage
  setInterval () ->
    table = new Table boardContext.board
    gameTitle = "Enjoy Robot War".bgGreen.black
    log """

      #{gameTitle}

      #{table.toString().bgYellow.inverse}

      #{table.printDeads().bgCyan.black}


  """
    if movements.length == 0 then process.exit(0)
    movement = movements.shift()
    movement()
  , 2000

boardContext = new Context(play)


evalCallback = (cmd, context, filename, callback) ->
  try
    expression = parser.parse(cmd).value
    ret = expression boardContext
    callback(null, ret)
  catch error
    console.log "Please check the command syntaxis".underline.red
    console.log error.toString().bgMagenta
    callback(error)

repl.start
  prompt: "robot war>"
  eval: evalCallback
