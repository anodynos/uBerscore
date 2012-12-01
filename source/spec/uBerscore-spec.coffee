chai = require 'chai'
assert = chai.assert
expect = chai.expect

_uB = require 'uBerscore' #
# @todo: test integrate with _, chainin etc



if isWeb # rootExports work only on browser (for now!)
         # window._B & window.uBerscore must be set
         # BEFORE loading uBerscore lib (in SpecRunner.html)

  describe 'uBerscore rootExports:', ->
    it "registers globals _B & uBerscore", ->
      expect( _B ).to.equal _uB
      expect( uBerscore ).to.equal _uB

    it "noConflict() returns module & sets old values to globals _B & uBerscore", ->
      # _B & uBerscore globals are registered in SpecRunner.html

      expect( _B.noConflict() ).to.equal _uB
      expect( _B ).to.equal "old _B"
      expect( uBerscore ).to.equal "old uBerscore"

  #  @todo : chainin & mixins
  #_.mixin({eachSort:__.eachSort})
  #
  #show _(o).chain().pick( "b", "aaa").eachSort().each( (value, key, list) -> show value, key).value()
  #
  #myo = {}
  #myo[key]=val for key, val of a
  #show myo
  #