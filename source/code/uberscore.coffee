urequire:                        # uRequire Module Configuration
  rootExports: ['_B', 'uberscore']
  noConflict: true
###
  The main class that gets exported (but all methods are static and independent :-)
###
class uberscore
  # @todo: instantation of a B object (ala jQuery object) - see B.coffee
  # some libs are required as bundleRelative others as fileRelative,
  # for uRequire's demonstration purposes!

  # Collection related
  go: require 'go'

  # extending, the deep way, TO BE DEPRACATED when Blender comes properly into play
  deepExtend: require './blending/deepExtend'
  deepCloneDefaults: require 'blending/deepCloneDefaults'


  Blender: require './blending/Blender'
  DeepExtendBlender: require './blending/blenders/DeepExtendBlender'

  #blendXXX: @todo:(6 5 5) provide default/predefined/common Blender instances,
  #                        for different purposes!

  # Object related
  okv: require 'okv'

  #various
  arrayize: require './arrayize'

  # agreement related
  isAgree: require './agreement/isAgree'
  inAgreements: require 'agreement/inAgreements'

  certain: require 'certain'

  # mutators
  mutate: require 'mutate'

  # types
  type: require 'type'
  isPlain: require 'isPlain'

  # Logging / debugging
  Logger: require './Logger'


module.exports = new uberscore