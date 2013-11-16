define ['types/type'], (type)->

  #class DeepCloneBlender extends (require '../.././blending/Blender')
  #  @behavior:

  DeepCloneBlender = (require '../.././blending/Blender').subclass {},

    behavior:
      order: ['dst', 'src']

      "*":
        '[]': 'deepCloneOverwrite'
        '{}': 'deepCloneOverwrite'
        '->': (prop, src)-> @read src, prop # just copy/overwrite function reference
        'Undefined': -> @SKIP

      deepCloneOverwrite: (prop, src, dst)->
        srcType = type @read src, prop #src[prop] is oneOf Array, Object, Function
        dstType = type @read dst, prop
        if dstType isnt srcType
          similarTypes = ['Function', 'Object']
          if not (dstType in similarTypes and srcType in similarTypes)
            # read as
            # `dst[prop] = if srcType is 'Array' then [] else {}`
#            @write dst, prop, @createAs @read src, prop
            @write dst, prop, if srcType is 'Array' then [] else {}

        @deepOverwrite prop, src, dst

