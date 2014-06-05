urequire:  # uRequire Module Configuration
  rootExports: ['_B', 'uberscore']
  noConflict: true

### The main class doesnt get exported - onle a sinle instance with all methods ###
define ->

  class Uberscore
    # @todo: instantation of a B object (ala jQuery object) - see B.coffee
    # some libs are required as bundleRelative others as fileRelative,
    # for uRequire's demonstration purposes!
    VERSION: if not VERSION? then '{NO_VERSION}' else VERSION # 'VERSION' variable added by grant:concat

    '_': _ # require 'lodash' not needed - its injected through dependencies.exports.bundle

    isLodash: (lodash = _)->
      (_.name is 'lodash') or                   # wont work on lodash-min
      (                                         # use duck typing instead
        _.isFunction(lodash.isPlainObject) and
        _.isFunction(lodash.merge) and
        _.isFunction(lodash.omit)
       )

    Uberscore::[key] = val for key, val of { #add to :: from {}, easier to urequire `replaceCode` in an RC :-)
      # Blender - blending Objects
      Blender: require './blending/Blender'

      DeepCloneBlender: require './blending/blenders/DeepCloneBlender'
      DeepExtendBlender: require './blending/blenders/DeepExtendBlender'
      DeepDefaultsBlender: require './blending/blenders/DeepDefaultsBlender'
      ArrayizePushBlender: require './blending/blenders/ArrayizePushBlender'

      traverse: require './blending/traverse'
      clone: require './blending/clone'

      #blendXXX: @todo:(6 5 5) provide default/predefined/common Blender instances,
      #                        for different purposes!

      # extending, the deep way, TO BE DEPRACATED when Blender comes properly into play
      # key removed in 'min' build, along with its dependency added to `defineArrayDeps`
      deepExtend: require './blending/deepExtend'

      # Objects
      okv: require './objects/okv'

      # mutators
      mutate: require './objects/mutate'
      setp: require './objects/setp'
      getp: require './objects/getp'
      isDisjoint: require './objects/isDisjoint'
      isRefDisjoint: require './objects/isRefDisjoint'
      getRefs: require './objects/getRefs'
      getInheritedPropertyNames: require "objects/getInheritedPropertyNames"
      isEqual: require "objects/isEqual"
      isIqual: require "objects/isIqual"
      isExact: require "objects/isExact"
      isIxact: require "objects/isIxact"
      isLike: require "objects/isLike"

      isTrue: require "types/isTrue"
      isFalse: require "types/isFalse"
      isOk: (val)-> !!val

      # Collections
      go: require './collections/go'
      isEqualArraySet: require "collections/array/isEqualArraySet"
      arrayize: require './collections/array/arrayize'

      # Agreements
      isAgree: require './agreement/isAgree'
      inAgreements: require 'agreement/inAgreements'

      # typing
      type: require 'types/type'
      isPlain: require 'types/isPlain'
      isHash: require 'types/isHash'

      # Logging / debugging
      Logger: require './Logger'

      # various @todo either DEPRACATE or bring up to a proper decorator ?
      certain: require './certain'

      CoffeeUtils: require 'utils/CoffeeUtils'
      CalcCachedProperties: require 'utils/CalcCachedProperties'
      subclass: require 'utils/subclass'
    }

  new Uberscore #return
