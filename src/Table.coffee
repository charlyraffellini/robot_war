_ = require "lodash"
include = require "include"
Position = include "src/Position"

TableCli = require('cli-table');

facingToArrow =
  top: "↑"
  left: "←"
  bottom: "↓"
  right: "→"
  X: "X"


module.exports =
class Table
  constructor: (@board) ->
    @maxX = @board.maxX
    @maxY = @board.maxY

  getTable: =>
    table = new Array(@maxX + 1)

    _.times @maxX + 1, (it) =>
      _.map new Array(@maxX + 1), (__, index) =>
        elem = @board.getElementInPosition(new Position(index, @maxY - it, 0))
        "#{facingToArrow[elem.readableFacing()]}#{elem.name}"

  toString: =>
    table = new TableCli(head: _.union([""], (_.times @maxX + 1, (it) => "#{it}")))
    _.forEach @getTable(),
      (row, index) => table.push "#{@maxY - index}": row

    table.toString()

  printDeads: =>
    lines = _.map @board.deadRobots, (it) =>
      "Robot #{it.name} dead by the #{it.getKillerName()}\'s hands"

    _.join lines, "\n"
