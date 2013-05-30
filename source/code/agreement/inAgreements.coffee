_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies: exports: bundle' !
isAgree = require './isAgree' # not need anymore, we have it as a uRequire 'dependencies: exports: bundle' !

arrayize = require './../collections/array/arrayize'

###
  @param o {Anything} an item to check through filters

  @param filters {Anything} One or more `filter`s to pass on `isAgree`

  @return true if o `isAgree` with any `filter`s, false otherwise
###
inAgreements = (o, agreements)->
  agreements = arrayize agreements

  if _.isEmpty agreements
    false
  else
    for agr in agreements
      if isAgree o, agr
        return true

  false

module.exports = inAgreements

