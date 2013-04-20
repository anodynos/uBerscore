_ = require 'lodash'
Blender = require '../Blender'
type = require '../../type'
DeepCloneBlender = require './DeepCloneBlender'

###
  It overwrites only if there is no other value - if its undefined.

  Nested Objects are naturally merged, (via DeepCloneBlender) but it never overwrites existing primitives.
  Its extending DeepCloneBlender, hence it creates a deep object copy of all src references.
###
class DeepDefaultsBlender extends DeepCloneBlender

  constructor: (@blenderBehaviors...)->
    (@defaultBlenderBehaviors or= []).push DeepDefaultsBlender.behavior
    (@_optionsList or= []).unshift {} # no options, keep it to remember how its used: {someOption: "someDefaultValue"}
    super

  @behavior:
    order: ['dst', 'src']

    '|':
      # Specifically declare that we want to process (overwrite) undefined & null destination values.
      "Undefined": -> Blender.NEXT
      "Null": -> Blender.NEXT

      # We also need to merge with nested destination types - when both dst & src are such.
      # We simply NEXT to use DeepCloneBlender's inherited BlenderBehaviours (which will pick 'deepCloneOverwrite' that doesn't overwrite).
      # @todo: use two BBs to simplify the following BB dstSrcSpec
      Object:
        Object: -> Blender.NEXT
        Array: -> Blender.NEXT
        Function: -> Blender.NEXT
        "*": -> Blender.SKIP

      # SKIP all other destinations (primitives, non undefined/null).
      "*": -> Blender.SKIP

  @behavior['|'].Array = @behavior['|'].Object
  @behavior['|'].Function = @behavior['|'].Object

module.exports = DeepDefaultsBlender