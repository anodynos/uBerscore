# Push all items of `src[prop]` array to the `dst[prop]` array (when these are not in dst[prop] already).
# If either src[prop] or dst[prop] aren't arrays, they are `arrayize`'d first.
# @options unique : only unique array items enforced onto the array
#   false: all items are added.
#   true: all === items are not pushed.
#   Function (a,b){} : items where unique(a, b) is truthy are not pushed @todo: NOT IMPLEMETED

define ['require', 'exports', 'module', 'collections/array/arrayize'],
  (require, exports, module, arrayize)->
    class ArrayizeBlender extends (require './DeepCloneBlender')

      addMethod: 'push'
      unique: false
      reverse: false

      @behavior:
        order: ['src']

        '*': 'addToArray'   #todo: (derive a custom uRequire_ArrayPusher that deals only with `String` & `Array<String>`, throwing error otherwise ?)

        addToArray: (prop, src, dst)->
          ## arrayize dst[prop]
          dstArray = @write dst, prop, arrayize @read dst, prop #. `dst[prop] = arrayize dst[prop]`
          srcArray = arrayize @read src, prop

          if _.isEqual srcArray[0], [null] # `[null]` is a signpost for 'reset array'.
            dstArray = @write dst, prop, []
            srcArray = srcArray[1..]       # The remaining items of the array are the 'real' items to push.


          itemsToAdd =
            if @unique                                     # @todo: does unique belong to blender or blenderBehavior ?
              (v for v in srcArray when v not in dstArray) # @todo: unique can be a fn: isEqual/isIqual/etc or any other equal fn.
            else
              _.clone srcArray                             # add 'em all

          itemsToAdd.reverse() if @reverse

          dstArray[@addMethod] v for v in itemsToAdd # @todo: should concat be used? Its a waste of an []
          dstArray
          # _B.Blender.SKIP # no need to assign, we mutated dst[prop] #todo: needed or not ?

