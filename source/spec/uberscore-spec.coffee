assert = chai.assert
expect = chai.expect

_uB = require 'uberscore' #

describe """
  uRequire's `rootExports` & `noConflict():`
    (running on #{if __isNode then 'nodsjs' else 'Web'} via #{if __isAMD then 'AMD' else 'noAMD/script'}):
""", ->
  if __isWeb # rootExports work only on browser (for now!)
    it "registers globals '_B' & 'uberscore'", ->
      expect( window._B ).to.equal _uB
      expect( window.uberscore ).to.equal _uB

    # `window._B` & `window.uberscore` must be
    # set BEFORE loading uberscore lib (in SpecRunner_XXX.html)
    it "noConflict() returns module & sets old values to globals '_B' & 'uberscore'", ->
      expect( window._B.noConflict() ).to.equal _uB
      expect( window._B ).to.equal "Old global `_B`"
      expect( window.uberscore ).to.equal "Old global `uberscore`"

      # assign back ?
      window._B = _uB
  else
    it "NOT TESTING `rootExports`, I am on node/#{if __isAMD then 'AMD' else 'plain'}!", ->
    it "NOT TESTING `noConflict()`, I am on node/#{if __isAMD then 'AMD' else 'plain'}!", ->
