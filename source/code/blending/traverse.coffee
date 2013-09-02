Blender = require './Blender'

###
A wrapper to a traverseBlender, that simply traverses all nested objects, performing no assignements and not exposing dst at all.
A new Blender instance is created for each invocation.

@param data {Object|Array} Our nested object or Array in which we visit each item recursivelly (depth first)
                           Deeper current branch recursion stops if false is returned from callback

@param callback {Function} A callback to be called at each item.
       It is actually each value's parent (src) object and the property name carying the value.
       If `false` is returned from callback, deeper recursion of current branch is stoped (but continues on previous branches).

  @param prop String the property name of the current visiting parent

  @param src  String the parent of the object we are visting. `src[prop]` gives us the current item's value

  @param blender Blender a blender instance, conveying information such as path etc - see Blender.
         Its also passed as context (this value) in the callback (if callback is unbound).

###
traverse = (data, callback)->
  dummy = {}                    # needed for blend() that checks for prop on this
  recurse = true                # flag changed by callback - intially true to skip srcRoot
  traverseBlender =
    new Blender [{
      order: ['src']
      '[]': 'traverse'
      '{}': 'traverse'
      '->': 'traverse'
      '*': Blender.SKIP

      traverse: (prop, src, dst, blender)->
        if src[prop] isnt data  # dont pass data / rootSrc with $ property!
          recurse = callback.call(this, prop, src, blender) # we dont expose dst - not needed
        if recurse isnt false
          @blend dummy, src[prop]  # recurse - no real dst needed
        @SKIP                      # no assignment to dst[prop] ever!

    }], debugLevel:0
  traverseBlender.blend dummy, data

module.exports = traverse