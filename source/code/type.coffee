_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !

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

type.TYPES = {
  'Arguments': ['args', ".."] #
  'Array'    : ['[]', 'A']
  'Function' : ['->', 'F']
  'String'   : ["''", 'S', '""'] # S
  'Date'     : ['D']
  'RegExp'   : ['//', 'R']
  'Object'   : ['{}', 'O'] # due to order, Object is return only for PLAIN objects (i.e _.isPlainObject), not for [] or ->
  'Number'   : ['N']
  'Boolean'  : ['B']
  'Null'     : ['null', "-"]  #
  'Undefined': ['U', "~"]
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
#
#
