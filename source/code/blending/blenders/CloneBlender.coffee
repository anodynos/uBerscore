Blender = require '../Blender'
_ = require 'lodash'
type = require '../../type'
isEqual = require '../../objects/isEqual'

class DeepCopyBlender extends Blender

  constructor: (@blenderBehaviors...)->
    (@defaultBlenderBehaviors or= []).push DeepCopyBlender.behavior
    super

  @behavior:
    order: ['dst', 'src']

    '|': # our 'dst <-- src' spec
      "*":
        'Array': 'deepObjectCreatorOverwrite' # 'A' is short for 'Array' (as also is '[]').
        'Object': 'deepObjectCreatorOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')
        'Function': 'deepObjectCreatorOverwrite'
        'Undefined': -> Blender.SKIP

    deepObjectCreatorOverwrite: (prop, src, dst, blender)->
      srcType = type src[prop]
      dstType = type dst[prop]
      if dstType isnt srcType
        similarTypes = ['Function', 'Object']
        if not (dstType in similarTypes and srcType in similarTypes)
          dst[prop] = if srcType is 'Array' then [] else {}

      blender.blend dst[prop], src[prop] # @todo: try _blend ?

module.exports = DeepCopyBlender

l = new (require '../../Logger') 'CloneBlender'
isRefDisjoint = require '../../objects/isRefDisjoint'
getRefs = require '../../objects/getRefs'
deepCopyBlender = new DeepCopyBlender

{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = require '../../../spec/spec-data'


destination = {}

source1 = objectWithProtoInheritedProps
#  aProp1: ->"aProp1"

#  aProp2: {'aProp2.1': "aVal2.1"}
#  aProp1: ['aProp1.1': "aVal1.1"]

source2 = {}
#  aProp1: [undefined, {'aProp1.1': {'aProp1.1.1': "aVal1.1.1"}}]
#
#l.log "'cloneBlender.blend destination, sources...'",
#       deepCopyBlender.blend destination, source1, source2
#
#l.log "'isRefDisjoint destination, sources.., deep:true'",
#    ((isRefDisjoint destination, source, deep: true) for source in [source1, source2])
#
#l.log "'isEqual destination, source1, inherited:true'",
#        isEqual source1, { aProp0: 'o0.aVal0' }, inherited:true
l.log _.isObject new Boolean(true)
l.log _.isBoolean new Boolean(true)
l.log type new Boolean(true)
l.log isEqual true, new Boolean(true)
