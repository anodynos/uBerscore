chai = require 'chai'
assert = chai.assert
expect = chai.expect

_uB = require 'uberscore' #
# @todo: test integrate with _, chainin etc

describe """
  uRequire's `rootExports` & `noConflict()`
     (running on #{if __isNode then 'nodsjs' else 'Web'} via #{if __isAMD then 'AMD' else 'noAMD/script'})
""", ->
  if __isWeb # rootExports work only on browser (for now!)
    it "registers globals '_B' & 'uberscore'", ->
      expect( _B ).to.equal _uB
      expect( uberscore ).to.equal _uB

    # `window._B` & `window.uberscore` must be
    # set BEFORE loading uberscore lib (in SpecRunner_XXX.html)
    it "noConflict() returns module & sets old values to globals '_B' & 'uberscore'", ->
      expect( _B.noConflict() ).to.equal _uB
      expect( _B ).to.equal "Old global `_B`"
      expect( uberscore ).to.equal "Old global `uberscore`"

  else
    it "NOT TESTING `rootExports`, I am on node/#{if __isAMD then 'AMD' else 'plain'}!", ->
    it "NOT TESTING `noConflict()`, I am on node/#{if __isAMD then 'AMD' else 'plain'}!", ->

    #  @todo : chainin & mixins
    #_.mixin({eachSort:__.eachSort})
    #
    #show _(o).chain().pick( "b", "aaa").eachSort().each( (value, key, list) -> show value, key).value()
    #
    #myo = {}
    #myo[key]=val for key, val of a
    #show myo
    #
