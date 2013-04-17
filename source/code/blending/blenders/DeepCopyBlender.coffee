Blender = require '../Blender'
_ = require 'lodash'
type = require '../../type'
isEqual = require '../../objects/isEqual'


#class Blender2 extends Blender
#  constructor: (@blenderBehaviors...)->
#    (@_optionsList or= []).unshift blender2Option: 'some value'
#    super

class DeepCloneBlender extends Blender

  constructor: (@blenderBehaviors...)->
    (@defaultBlenderBehaviors or= []).push DeepCloneBlender.behavior
    # default DeepCloneBlender options: copy __proto__ from object to object
    (@_optionsList or= []).unshift {} #no options
    super

  @behavior:
    order: ['dst', 'src']

    '|': # our 'dst <-- src' spec
      "*":
        'Array': 'deepCloneOverwrite' # 'A' is short for 'Array' (as also is '[]').
        'Object': 'deepCloneOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')
        'Function': 'deepCloneOverwrite'
        'Undefined': -> Blender.SKIP

    deepCloneOverwrite: (prop, src, dst, blender)->
      srcType = type src[prop] #src[prop] is oneOf Array, Object, Function
      dstType = type dst[prop]
      if dstType isnt srcType
        similarTypes = ['Function', 'Object']
        if not (dstType in similarTypes and srcType in similarTypes)
          dst[prop] = if srcType is 'Array' then [] else {}

      blender.deepOverwrite prop, src, dst, blender

module.exports = DeepCloneBlender

#l = new (require '../../Logger') 'CloneBlender'
#isRefDisjoint = require '../../objects/isRefDisjoint'
#getRefs = require '../../objects/getRefs'
#isIqual = require '../../objects/isIqual'
#{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = require '../../../spec/spec-data'
#
#deepCloneBlender = new DeepCloneBlender [] , {isCopyProto: true}
#destination = {}
#
#source1 = objectWithProtoInheritedProps
##  aProp1: ->"aProp1"
#
##  aProp2: {'aProp2.1': "aVal2.1"}
##  aProp1: ['aProp1.1': "aVal1.1"]
#
#source2 = {}
##  aProp1: [undefined, {'aProp1.1': {'aProp1.1.1': "aVal1.1.1"}}]
#clone = deepCloneBlender.blend destination, source1 #, source2
#l.log "'cloneBlender.blend destination, sources...'", clone
##l.log (p for own p of clone)
#
#l.log "'isRefDisjoint destination, sources.., deep:true'",
#    ((isRefDisjoint destination, source, {deep: true}) for source in [source1, source2])
#
#l.log "'isIqual(destination, objectWithProtoInheritedProps) is true'",
#        isIqual destination, objectWithProtoInheritedProps
