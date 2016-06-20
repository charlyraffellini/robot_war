_ = require "lodash"
should = require 'should'
include = require "include"
Rotor = include "src/Rotor"
Position = include "src/Position"
Robot = include "src/Robot"

should.Assertion.add 'position', (value) ->
    extected = this.params.expected
    assertion = (property) =>
      value.should.have.property(property).which.is.a.Number()
      .and.be.exactly this.obj[property]

    assertion("x")
    assertion("y")
    assertion("facing")

describe "Position", ->
  it "are equals", ->
    areEquals = (new Position 0,0,0 ).equals new Position(0,0,0)
    areEquals.should.be.true()

  it "are differents", ->
    areDifferents = not ((new Position 0,0,0).equals new Position(0,1,1))
    areDifferents.should.be.true()

  itClause = (facing, expected) ->
    it "can get next towards #{facing}", ->
      position = new Position(1,2,"#{facing}")
      position.next().should.be.position expected

  expectations = [
    ["top",new Position(1,3,"top")],
    ["left",new Position(0,2,"left")],
    ["right",new Position(2,2,"right")],
    ["bottom",new Position(1,1,"bottom")],
  ]

  _.forEach expectations, (params) ->
    itClause params[0], params[1]
