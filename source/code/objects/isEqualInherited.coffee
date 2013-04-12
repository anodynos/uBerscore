###
  shortcut of isEqual = (a, b, callback, thisArg, options={
                            inherited:false
                            exclude: ['constructor']
                        })->
###
isEqual = (require './isEqual')

isEqualInherited = (a, b, callback, thisArg, options={})->
  options.inherited = true
  (options.exclude or= []).push 'constructor'
  isEqual.apply [a, b, callback, thisArg, options]

module.exports = isEqualInherited

#l = (new (require './../Logger') '', 40, true)
#_ = require 'lodash'
#{ objectWithPrototypeInheritedProps, Class3, expectedPropertyValues } = require '../../spec/spec-data'
#c3 = new Class3
#
#l.warn 'objectWithPrototypeInheritedProps :'
#l.log isEqual objectWithPrototypeInheritedProps, expectedPropertyValues, undefined, undefined, inherited:true
#l.log isEqualInherited objectWithPrototypeInheritedProps, expectedPropertyValues
#l.log _.isEqual objectWithPrototypeInheritedProps,expectedPropertyValues #false
#
#l.warn 'c3 :'
#l.log isEqual c3, expectedPropertyValues, undefined, undefined, inherited:true
#l.log isEqualInherited c3, expectedPropertyValues
#l.log _.isEqual c3, expectedPropertyValues #false
#
#l.warn 'clone objectWithPrototypeInheritedProps:'
#clone = _.clone(objectWithPrototypeInheritedProps, true)
#l.log isEqual clone, expectedPropertyValues, undefined, undefined, inherited:true
#l.log isEqualInherited clone, expectedPropertyValues
#l.log (_.isEqual clone, expectedPropertyValues)
#
#l.warn 'clone c3:'
#clone = _.clone(c3, true)
#l.log isEqual clone, expectedPropertyValues, undefined, undefined, inherited:true
#l.log isEqualInherited clone, expectedPropertyValues
#l.log (_.isEqual clone, expectedPropertyValues)
