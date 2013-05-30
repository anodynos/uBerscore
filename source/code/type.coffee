_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies: exports: bundle' !

# @todo: provide a more plausible implementation, instead of a looping ?

type = (o, isShort=false)->
  for long, shorts of type.TYPES
    if _["is#{long}"] o
      return if isShort then shorts[0] else long

  return 'UNKNOWN'

type.toShort = (aType)->
  if type.TYPES[aType]
    type.TYPES[aType][0]
  else
    for longType, shorts of type.TYPES
      if aType in shorts
        return shorts[0]

type.toLong = (aType)->
  if type.TYPES[aType]
    aType
  else
    for longType, shorts of type.TYPES
      if aType in shorts
        return longType

type.areEqual = (aType, bType)->
  type.toShort(aType) is type.toShort(bType)

type.isType = (aType)->  type.toLong(aType) in _.keys type.TYPES
# {longType : [shortType, others...]
type.TYPES = {
  'Arguments': ['args', "..."] #
  'Array'    : ['[]', 'A']
  'Function' : ['->', 'F']
  'String'   : ["''", 'S', '""'] # S
  'Date'     : ['D']
  'RegExp'   : ['//', 'R']
  'Number'   : ['N']
  'Boolean'  : ['B']

  'Object'   : ['{}', 'O'] # due to order, Object is returned only for PLAIN objects (i.e _.isPlainObject),
                           # not for [], ->, Boolean, Number etc
                           # @todo: (5 7 2) ammend to work irrespective of order

  'Null'     : ['null', "-"]  #
  'Undefined': ['U', "void", "?"]
}


module.exports = type

#inline tests
#oOs = {
#  'Array': ['this', 'is', 1, 'array']
#  #'Arguments':# todo: test this
#  'Function': (x)->x
#  'String': "I am a String!"
#  'Number': 667
#  'Date': new Date()
#  'RegExp': /./g
#  'Boolean': true
#  'Null': null
#  'Undefined': undefined
#  'Object': {a:1, b:2}
#  'Arguments': arguments
#}

