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

  'Object'   : ['{}', 'O'] # due to order, Object is returned only for {} hashes
                           # not for [], ->, Boolean, Number etc
  'Null'     : ['null', "-"]  #
  'Undefined': ['U', "void", "?"]
}

module.exports = type