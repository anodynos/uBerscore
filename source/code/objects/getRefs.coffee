_ = require 'lodash'
#isPlain = require '../isPlain'
###
  Deflattens ALL references of Array or Objects, returns them as an array.
  @param oa <Object|Array> The Object or Array to get all references
  @param deep boolean If deep is true, all references in nested Objects/Arrays are tetrieved
###
getRefs = (oa, deep=false, refsArray = [])->
  _.each oa, (v)->
#    if not isPlain v
    if _.isObject v
      refsArray.push v
      if deep
        getRefs v, deep, refsArray

  refsArray

module.exports = getRefs