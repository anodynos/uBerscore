chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uBerscore' #

data = require './spec-data'
# @todo: use data + more examples

describe 'arrayize :', ->

  it "arrayize a String", ->
    expect(
      _B.arrayize 'agelos'
    ).to.deep.equal ['agelos']

  it "arrayize a Number", ->
    expect(
      _B.arrayize 19
    ).to.deep.equal [19]

  it "arrayize an existing array", ->
    arr = [1, 'john']
    expect(
      _B.arrayize arr
    ).to.equal arr

  it "arrayize nothingness", ->
    expect(
      _B.arrayize undefined
    ).to.deep.equal []
