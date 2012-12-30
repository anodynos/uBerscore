#_ = require 'lodash' # not need anymore, we have it as a Bundle Dependency!
#isAgree = require './isAgree' # not need anymore, we have it as a Bundle Dependency!
arrayize = require './arrayizeTest/arrayize'


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

## todo: make specs!
#compiledFiles = /.*\.(coffee|iced|coco)$/i
#jsFiles = /.*\.(js|javascript)$/i
#
#include = [jsFiles, compiledFiles, 'papari.txt']
#exclude = [/.*lalakis.*/]
#
#libs = ['file.coffee', 'lalakis.coffee', 'superlalakis.js', 'papari.txt', 'loulou.gif', 'bla.js']
#
#console.log inFilters 'file.coffee', include