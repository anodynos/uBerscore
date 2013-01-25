chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore' #
data = require '../spec-data'

describe 'isAgree ', ->
  it "a String with another String", ->
    expect(
      _B.isAgree 'agelos', 'agelos'
    ).to.be.true

  it "a String with a RegExp", ->
    expect(
      _B.isAgree 'agelos', /agelos/
    ).to.be.true

  it "a String with undefined", ->
    expect(
      _B.isAgree 'agelos', undefined
    ).to.be.true

  it "a String with another object", ->
    expect(
      _B.isAgree {x:'agelos', toString:->@x}, 'agelos'
    ).to.be.true