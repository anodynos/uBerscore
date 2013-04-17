###
  shortcut of isEqual with default options = {
                            inherited: true
                            exclude: ['constructor']
                        }
###
isEqual = (require './isEqual')

isIqual = (a, b, callback, thisArg, options={})->
  options.inherited = true
  (options.exclude or= []).push 'constructor'
  isEqual.apply undefined, [a, b, callback, thisArg, options]

module.exports = isIqual
#
#l = (new (require './../Logger') '', 40, true)
#_ = require 'lodash'
#{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = require '../../spec/spec-data'


#l.warn 'objectWithProtoInheritedProps : ##########################'
#l.log 'true?',isEqual objectWithProtoInheritedProps, expectedPropertyValues, undefined, undefined, inherited:true
#l.log 'true?',isIqual objectWithProtoInheritedProps, expectedPropertyValues
#l.log _.isEqual objectWithProtoInheritedProps, expectedPropertyValues #false
#
#l.warn 'c3 : ##########################'
#l.log 'true?',isEqual c3, expectedPropertyValues, undefined, undefined, inherited:true
#l.log 'true?', isIqual c3, expectedPropertyValues
#l.log _.isEqual c3, expectedPropertyValues #false
#
#l.warn 'clone objectWithProtoInheritedProps: ##########################'
#clone = _.clone(objectWithProtoInheritedProps, true)
# # imperfect clone - prototype is not copied!
#clone.__proto__ = objectWithProtoInheritedProps.__proto__
#l.log 'true?', isEqual expectedPropertyValues, clone, undefined, undefined, inherited:true
#l.log 'true?', isIqual clone, expectedPropertyValues
#l.log _.isEqual clone, expectedPropertyValues
#
#l.warn 'clone c3:##########################'
#clone = _.clone(c3, true)
#clone.__proto__ = c3.__proto__
#l.log 'true?', isEqual clone, expectedPropertyValues, undefined, undefined, inherited:true
#l.log 'true?', isIqual clone, expectedPropertyValues
#l.log _.isEqual clone, expectedPropertyValues
#a=->
#a.p=1
#b=->
#b.p=1
#l.log '_isEqual (->), (->)', 'isEqual is false:', _.isEqual(a, b)
#l.log 'isEqual (->), (->)', 'isEqual is false:', isEqual(a, b)
#l.log 'isIqual (->), (->)', 'isIqual is false:', isIqual(a, b)
