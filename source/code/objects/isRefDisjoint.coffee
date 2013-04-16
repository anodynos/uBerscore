_ = require 'lodash'
getRefs = require './getRefs'
isDisjoint = require './isDisjoint'
###
  Given two Objects, it returns true if there are no common/shared
  references in their properties.

  @param oa1 <Array|Object> The first Array or Object (order shouldn't matter)
  @param oa1 <Array|Object> The second Array or Object

  @param deep <Boolean> If true, then all nested references are considered.
###

isRefDisjointDefaults =
    deep: false
    inherited: false

isRefDisjoint = (oa1, oa2, options=isRefDisjointDefaults)->
  _.defaults(options, isRefDisjointDefaults) if options isnt isRefDisjointDefaults

  if oa1 is oa2
    false
  else
    refs1 = getRefs oa1, options
    refs1.unshift oa1

    refs2 = getRefs oa2, options
    refs2.unshift oa2

    isDisjoint refs1, refs2

module.exports = isRefDisjoint