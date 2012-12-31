#_ = require 'lodash' # not need anymore, we have it as a Bundle Dependency!
#isAgree = require './isAgree' # not need anymore, we have it as a Bundle Dependency!
arrayize = require './../arrayize'


###
  @param o {Anything} an item to check through filters

  @param filters {Anything} One or more `filter`s to pass on `isAgree`

  @return true if o `isAgree` with any `filter`s, false otherwise
###
inFilters = (o, filters)->
  filters = arrayize filters

  if _.isEmpty filters
    false
  else
    for fltr in filters
      if isAgree o, fltr
        return true

  false

module.exports = inFilters

