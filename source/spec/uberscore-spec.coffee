define -> describe """
  uRequire's `rootExports` & `noConflict():`
    (running on #{if __isNode then 'nodejs' else 'Web'} loading via #{if __isAMD then 'AMD' else 'noAMD/script'}):
  """, ->

    _uB = require 'uberscore' #

    it "registers globals (NOT RUNS ON AMD) ", ->
      if not __isAMD
        equal window._B, _uB
        equal window.uberscore, _uB

    it "Doesn't register globals & noConflict on AMD (RUNS ONLY ON AMD) ", ->
      if __isAMD and !__isWeb
        equal window._B, undefined
        equal window.uberscore, undefined

    # `window._B` & `window.uberscore` must be set on browser
    # BEFORE loading uberscore lib (in SpecRunner_XXX.html)
    it  "noConflict() returns module & sets old values (NOT RUNS ON AMD)", ->
      if not __isAMD
        equal window._B.noConflict(), _uB

      if __isWeb # "Old global `_B`" etc only work on browser
        equal window._B, "Old global `_B`"
        equal window.uberscore, "Old global `uberscore`"
