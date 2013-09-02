
# Push all items of `src[prop]` array to the `dst[prop]` array (when these are not in dst[prop] already).
# If either src[prop] or dst[prop] aren't arrays, they are `arrayize`'d first.
# @options unique : are unique array items enforced onto the array ?
#                   false: all items are added.
#                   true: all === items are not pushed.
#                   Function (a,b){} : items where unique(a, b) is truthy are not pushed @todo: NOT IMPLEMETED

define ['require', 'exports', 'module', 'collections/array/arrayize'],
  (require, exports, module, arrayize)->
    class ArrayizePushBlender extends (require './DeepCloneBlender')

      @behavior:
        order: ['src']
        unique: false

        '*': 'pushToArray'   #todo: (derive a custom uRequire_ArrayPusher that deals only with `String` & `Array<String>`, throwing error otherwise ?)

        pushToArray: (prop, src, dst)->
          dst[prop] = arrayize dst[prop]
          srcArray = arrayize src[prop]

          if _.isEqual srcArray[0], [null] # `[null]` is a signpost for 'reset array'.
            dst[prop] = []
            srcArray = srcArray[1..]       # The remaining items of the array are the 'real' items to push.

          itemsToPush =
            if @unique                                    # @todo: does unique belong to blender or blenderBehavior ?
              (v for v in srcArray when v not in dst[prop]) # @todo: unique can be a fn: isEqual/isIqual/etc or any other equal fn.
            else
              srcArray                                      # add 'em all

          dst[prop].push v for v in itemsToPush
          dst[prop]
          #_B.Blender.SKIP # no need to assign, we mutated dst[prop] #todo: needed or not ?