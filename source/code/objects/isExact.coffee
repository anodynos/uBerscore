###
  Shortcut of isEqual with default options = { exact: true }
###
isEqual = (require './isEqual')

isExact = (a, b, callback, thisArg, options={})->
  options.exact = true
  isEqual.apply undefined, [a, b, callback, thisArg, options]

module.exports = isExact
#
#
#_ = require 'lodash'
#
#l = (new (require './../Logger') 'uberscore/isExact', 40, true)
#
#{ objectWithProtoInheritedProps, Class3, expectedPropertyValues
#
#  object
#  objectShallowClone1, objectShallowClone2
#  objectDeepClone1, objectDeepClone2
#  inheritedShallowClone
#  inheritedDeepClone
#
#} = require '../../spec/spec-data'
##
#isIqual = require './isIqual'
#isIxact = (a, b, callback, thisArg, options={})->
#  options.exact = true
#  isIqual.apply undefined, [a, b, callback, thisArg, options]
#
#isRefDisjoint = require '../objects/isRefDisjoint'
#
#go = require '../collections/go'
#deepInherited = {deep:true, inherited:true}

#l.warn '#### _.isEqual - shallow ####'
#l.log _.isEqual objectShallowClone1, object
#l.log _.isEqual objectShallowClone2, object
#
#l.warn '#### _B.isExact - shallow ####'
#l.log 'objectShallowClone1', 'isExact is true:'+ isExact objectShallowClone1, object
#l.log 'objectShallowClone2', 'isExact is true:'+ isEqual objectShallowClone2, object, undefined, undefined, exact: true
#
#l.warn '#### _.isEqual - deepClones ####'
#l.log _.isEqual objectDeepClone1, object
#l.log _.isEqual objectDeepClone2, object
#
#l.warn '#### _B.isExact - deepClones ####'
#l.log 'objectDeepClone1', 'isExact is false:'+ isExact objectDeepClone1, object
#l.log 'objectDeepClone2', 'isExact is false:'+ isEqual objectDeepClone2, object, undefined, undefined, exact: true
#
#l.warn '#### _B.isExact & inherited - inheritedClones ####'
#l.log 'inheritedShallowClone', 'isExact is false:'+ isExact inheritedShallowClone, object
#l.log 'inheritedShallowClone', '_.isEqual is false:'+ _.isEqual inheritedShallowClone, object
#l.log 'inheritedShallowClone', '_.isEqual is false:'+ _.isEqual object, inheritedShallowClone
#
#l.log 'inheritedDeepClone', 'isExact is false:'+ isExact inheritedDeepClone, object
#
#
#l.log 'inheritedShallowClone', 'isIxact is true:'+ isIxact inheritedShallowClone, object
#l.log 'inheritedShallowClone', 'isIqual is true:'+ isIqual object, inheritedShallowClone
#
#l.log 'inheritedDeepClone', 'isIxact is false:'+ isIxact inheritedDeepClone, object
#l.log 'inheritedDeepClone', 'isIqual is true:'+ isIqual inheritedDeepClone, object
