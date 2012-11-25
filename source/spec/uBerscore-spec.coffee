console.log 'uBerscore-test loading'

chai = require 'chai'
_B = require '../code/uBerscore' #

assert = chai.assert
expect = chai.expect


describe 'deepCloneDefaults', ->
  it "should ", ->
    assert.deepEqual {}, _B.go {}
