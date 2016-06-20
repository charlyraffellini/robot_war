include = require "include"
Rotor = include "src/Rotor"
Position = include "src/Position"

describe "Rotor", ->
  it "can rotate a positive unit", ->
    newPosition = Rotor.Positive().rotate(new Position(1,2,"top"))
    newPosition.readableFacing().should.be.exactly "left"

  it "can rotate a negative unit", ->
    newPosition = Rotor.Negative().rotate(new Position(1,2,"top"))
    newPosition.readableFacing().should.be.exactly "right"
