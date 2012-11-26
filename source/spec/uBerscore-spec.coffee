chai = require 'chai'
assert = chai.assert
expect = chai.expect

_B = require '../code/uBerscore' #

describe 'deepCloneDefaults', ->
  it "should ", ->
    assert.deepEqual {}, _B.go {}



  #  @todo : chainin & mixins
  #_.mixin({eachSort:__.eachSort})
  #
  #show _(o).chain().pick( "b", "aaa").eachSort().each( (value, key, list) -> show value, key).value()
  #
  #myo = {}
  #myo[key]=val for key, val of a
  #show myo
  #