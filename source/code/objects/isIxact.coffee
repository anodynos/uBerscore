###
  shortcut of isEqual with default options = {
                            inherited: true
                            exclude: ['constructor']

                            exact: true
                        }
###
isIqual = (require './isIqual')

isIxact = (a, b, callback, thisArg, options={})->
  options.exact = true
  isIqual.apply undefined, [a, b, callback, thisArg, options]

module.exports = isIxact
#
#l = (new (require './../Logger') 'uberscore/isIxact', 40, true)
#_ = require 'lodash'
#{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = require '../../spec/spec-data'

