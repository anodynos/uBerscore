describe """
  uRequire's `rootExports` & `noConflict():` (running on #{
    if __isNode then 'nodejs' else 'Web'} & loading via #{ if __isAMD then 'AMD' else 'noAMD/script' }):
  """, ->
    # `window._B` set on HTML
    _uB = require 'uberscore'

    it "registers globals - RUNS only `if __isWeb and !__isAMD` ", ->
      if __isWeb and !__isAMD
        equal window._B, _uB

    it "Doesn't register globals & noConflict on AMD (RUNS only `if __isAMD and !__isNode`) ", ->
      if __isAMD and !__isNode
        equal window._B, "Old global `_B`"

    it  "`noConflict()` returns module & sets old values (NOT only `if __isAMD and !__isNode`)", ->
      if !__isAMD and !__isNode
        equal window._B.noConflict(), _uB
        equal window._B, "Old global `_B`"
