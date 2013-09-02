define ['types/type'], (type)->

  class DeepCloneBlender extends (require '../.././blending/Blender')

    @behavior:
      order: ['dst', 'src']

      "*":
        '[]': 'deepCloneOverwrite' # '[]' is type.toShort('Array')
        '{}': 'deepCloneOverwrite' # '{}' is type.toShort('Object')
        '->': (prop, src)-> src[prop] # just copy/overwrite function reference
        'Undefined': @SKIP

      deepCloneOverwrite: (prop, src, dst)->
        srcType = type src[prop] #src[prop] is oneOf Array, Object, Function
        dstType = type dst[prop]
        if dstType isnt srcType
          similarTypes = ['Function', 'Object']
          if not (dstType in similarTypes and srcType in similarTypes)
            dst[prop] = if srcType is 'Array' then [] else {}

        @deepOverwrite prop, src, dst