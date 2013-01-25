chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore' #

data = require './spec-data'
# @todo: use data + more examples

describe 'mutate :', ->

  simpleCalc = (v)->if v<0 then v+10 else v+20
  it "mutate Object values", ->
    o = a:1, b:2, c:-1
    expect(
      _B.mutate o, simpleCalc
    ).to.deep.equal {
      a: 21, b: 22, c: 9
    }

  it "arrayize if string", ->
    o =
      key1: 'lalakis'
      key2: ['ok','yes']
    expect(
      _B.mutate o, _B.arrayize, _.isString
    ).to.deep.equal
      key1: ["lalakis"]
      key2: ["ok", "yes"]

  describe 'mutate arrays :', ->
    a = [1, 2, -1]
    it "mutate array with simplecalc ", ->
      expect(
        _B.mutate a, simpleCalc
      ).to.deep.equal [21, 22, 9]

    it "mutate array again with fltr", ->
      expect(
        _B.mutate a, simpleCalc, (v)->v>10 #fltr
      ).to.deep.equal [41, 42, 9]