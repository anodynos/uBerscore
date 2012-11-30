chai = require 'chai'
assert = chai.assert
expect = chai.expect

_B = require '../code/uBerscore' #

describe 'uBerscore', ->

# @todo: integrate with _ & allow chaining,

### not working: @rootExports not working on nodejs
#glob__B = 'I am the old _B'
#glob_uBerscore = -> 'I am the old _uBerscore'
#
#global._B = glob__B
#global._uBerscore = glob_uBerscore

#
#  it "rootExports: should register _B & uBerscore as globals ", ->
#    expect(_B).equal global._B
#    expect(_B).equal global._uBerscore

#  it "noConflict() should de-register globals, return 'em to previous state!", ->
#    _B.noConflict
#    expect(global._B).deepEqual glob__B
#    expect(global._uBerscore).deepEqual glob_uBerscore
###


  #  @todo : chainin & mixins
  #_.mixin({eachSort:__.eachSort})
  #
  #show _(o).chain().pick( "b", "aaa").eachSort().each( (value, key, list) -> show value, key).value()
  #
  #myo = {}
  #myo[key]=val for key, val of a
  #show myo
  #