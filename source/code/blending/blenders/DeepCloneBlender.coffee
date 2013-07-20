Blender = require '../Blender'
type = require 'types/type'

class DeepCloneBlender extends Blender

  constructor: (@blenderBehaviors...)->
    (@defaultBlenderBehaviors or= []).push DeepCloneBlender.behavior
    (@_optionsList or= []).unshift {} #no options
    super

  @behavior:
    order: ['dst', 'src']

    "*":
      '[]': 'deepCloneOverwrite' # '[]' is type.toShort('Array')
      '{}': 'deepCloneOverwrite' # '{}' is type.toShort('Object')
      '->': (prop, src)-> src[prop] # just copy/overwrite function reference
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
