define -> describe """
  uRequire's `rootExports` & `noConflict():`
    (running on #{if __isNode then 'nodejs' else 'Web'} via #{if __isAMD then 'AMD' else 'noAMD/script'}):
  """, ->

    _uB = require 'uberscore' #

    it "registers globals '_B' & 'uberscore'", ->
      expect( window._B ).to.equal _uB
      expect( window.uberscore ).to.equal _uB

    # `window._B` & `window.uberscore` must be set on browser
    # BEFORE loading uberscore lib (in SpecRunner_XXX.html)
    it "noConflict() returns module & sets old values to globals '_B' & 'uberscore'", ->
      expect( window._B.noConflict() ).to.equal _uB

      if __isWeb # "Old global `_B`" etc only work on browser
        expect( window._B ).to.equal "Old global `_B`"
        expect( window.uberscore ).to.equal "Old global `uberscore`"
#      else
#        expect( window._B ).to.be.undefined
#        expect( window.uberscore ).to.be.undefined
#      window._B = _uB