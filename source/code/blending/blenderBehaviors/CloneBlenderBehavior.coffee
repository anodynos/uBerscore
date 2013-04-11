
  deepObjectCreatorOverwrite: (prop, src, dst, blender)->
    if not _.isObject(dst[prop])
      dst[prop] = {}
    blender.blend dst[prop], src[prop] # @todo: try _blend ?

