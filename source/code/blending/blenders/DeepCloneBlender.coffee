_ = require 'lodash'
Blender = require '../Blender'
type = require '../../type'

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
