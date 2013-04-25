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

    # Specifically declare that we want to process (overwrite) undefined & null destination values.
    "Undefined": -> Blender.NEXT
    "Null": -> Blender.NEXT

    # We also need to merge with nested destination types
    # but ONLY when both dst & src are 'compatible' nnested types.
    #
    # This BB (and its parent) consider 'Function' & 'Object' to be 'compatible',
    # but 'Array' to bedifferent to these - hence no merging is attempted.
    #
    # We simply NEXT to use DeepCloneBlender's inherited BlenderBehaviors
    # (which will pick 'deepCloneOverwrite' that doesn't simply overwrite).
    # and will SKIP the rest.
    # @todo: simplify the following BB dstSrcSpec ?
    Object: # repeating for Array & Function
      Object: -> Blender.NEXT
      Function: -> Blender.NEXT
      "*": -> Blender.SKIP
    Function:
      Object: -> Blender.NEXT
      Function: -> Blender.NEXT
      "*": -> Blender.SKIP
    Array:
      Array: -> Blender.NEXT
      "*": -> Blender.SKIP

    # SKIP all other destinations (primitives, non undefined/null).
    "*": -> Blender.SKIP


module.exports = DeepDefaultsBlender