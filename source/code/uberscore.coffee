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

  # Blender - blending Objects
  Blender: require './blending/Blender'
  DeepCloneBlender: require './blending/blenders/DeepCloneBlender'
  DeepExtendBlender: require './blending/blenders/DeepExtendBlender'
  DeepDefaultsBlender: require './blending/blenders/DeepDefaultsBlender'

  #blendXXX: @todo:(6 5 5) provide default/predefined/common Blender instances,
  #                        for different purposes!

  # extending, the deep way, TO BE DEPRACATED when Blender comes properly into play
  deepExtend: require './blending/deepExtend'
  deepCloneDefaults: require 'blending/deepCloneDefaults'



  # Objects
  okv: require './objects/okv'
  # mutators
  mutate: require './objects/mutate'
  setValueAtPath: require './objects/setValueAtPath'
  getValueAtPath: require './objects/getValueAtPath'
  isDisjoint: require './objects/isDisjoint'
  isRefDisjoint: require './objects/isRefDisjoint'
  getRefs: require './objects/getRefs'
  getInheritedPropertyNames: require "objects/getInheritedPropertyNames"
  isEqual: require "objects/isEqual"
  isIqual: require "objects/isIqual"
  isExact: require "objects/isExact"
  isIxact: require "objects/isIxact"

  # Collections
  go: require './collections/go'
  isEqualArraySet: require "collections/array/isEqualArraySet"
  arrayize: require './collections/array/arrayize'

  # Agreements
  isAgree: require './agreement/isAgree'
  inAgreements: require 'agreement/inAgreements'

  # typing
  type: require 'type'
  isPlain: require 'isPlain'

  # Logging / debugging
  Logger: require './Logger'

  # various
  certain: require './certain'


module.exports = new uberscore