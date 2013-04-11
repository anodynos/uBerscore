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
isRefDisjoint = (oa1, oa2, deep)->
  refs1 = getRefs oa1, deep
  refs2 = getRefs oa2, deep

  isDisjoint refs1, refs2

module.exports = isRefDisjoint

