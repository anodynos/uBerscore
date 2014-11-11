DeepCloneBlender = require './blenders/DeepCloneBlender'

###
A clone wrapper to Blender, acception all Blender options & `deep`
###
clone = (obj, options)->
  if not options
    _.clone obj, options # lodash compatibility
  else
    if not (options is true or options.deep) # the lodash.clone `deep` option
      (new DeepCloneBlender ['*':'*': 'overwrite'], options).blend obj
    else
      (new DeepCloneBlender [], options).blend obj

module.exports = clone