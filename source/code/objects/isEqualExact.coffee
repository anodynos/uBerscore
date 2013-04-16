###
  Shortcut of isEqual with default options = { exact: true }
###
isEqual = (require './isEqual')

isEqualExact = (a, b, callback, thisArg, options={})->
  options.exact = true
  isEqual.apply undefined, [a, b, callback, thisArg, options]

module.exports = isEqualExact


#_ = require 'lodash'
#
#l = (new (require './../Logger') 'isEqualExactLogger', 40, true)
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
#isEqualInherited = require './isEqualInherited'
#isEqualInheritedExact = (a, b, callback, thisArg, options={})->
#  options.exact = true
#  isEqualInherited.apply undefined, [a, b, callback, thisArg, options]
#
#isRefDisjoint = require '../objects/isRefDisjoint'
#
#go = require '../collections/go'
#deepInherited = {deep:true, inherited:true}
#
#l.warn '#### _.isEqual - shallow ####'
#l.log _.isEqual objectShallowClone1, object
#l.log _.isEqual objectShallowClone2, object
#
#l.warn '#### _B.isEqualExact - shallow ####'
#l.log 'objectShallowClone1', 'isEqualExact is true:'+ isEqualExact objectShallowClone1, object
#l.log 'objectShallowClone2', 'isEqualExact is true:'+ isEqual objectShallowClone2, object, undefined, undefined, exact: true
#
#l.warn '#### _.isEqual - deepClones ####'
#l.log _.isEqual objectDeepClone1, object
#l.log _.isEqual objectDeepClone2, object
#
#l.warn '#### _B.isEqualExact - deepClones ####'
#l.log 'objectDeepClone1', 'isEqualExact is false:'+ isEqualExact objectDeepClone1, object
#l.log 'objectDeepClone2', 'isEqualExact is false:'+ isEqual objectDeepClone2, object, undefined, undefined, exact: true
#
#l.warn '#### _B.isEqualExact & inherited - inheritedClones ####'
#l.log 'inheritedShallowClone', 'isEqualExact is false:'+ isEqualExact inheritedShallowClone, object
#l.log 'inheritedShallowClone', '_.isEqual is false:'+ _.isEqual inheritedShallowClone, object
#l.log 'inheritedShallowClone', '_.isEqual is false:'+ _.isEqual object, inheritedShallowClone
#
#l.log 'inheritedDeepClone', 'isEqualExact is false:'+ isEqualExact inheritedDeepClone, object
#
#
#l.log 'inheritedShallowClone', 'isEqualInheritedExact is true:'+ isEqualInheritedExact inheritedShallowClone, object
#l.log 'inheritedShallowClone', 'isEqualInherited is true:'+ isEqualInherited object, inheritedShallowClone
#
#l.log 'inheritedDeepClone', 'isEqualInheritedExact is false:'+ isEqualInheritedExact inheritedDeepClone, object
#l.log 'inheritedDeepClone', 'isEqualInherited is true:'+ isEqualInherited inheritedDeepClone, object
