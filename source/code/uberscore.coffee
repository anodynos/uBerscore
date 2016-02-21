(urequire: rootExports: '_B', noConflict: true)

define ->
  class Uberscore
    VERSION: if not VERSION? then '{NO_VERSION}' else VERSION # `var VERSION = 'x'` added by 'urequire-rc-inject-version'

    '_': _ # require 'lodash' not needed - its injected through dependencies.imports

    isLodash: (lodash = _)->
      (_.name is 'lodash') or                   # wont work on lodash-min
      (                                         # use duck typing instead
        _.isFunction(lodash.isPlainObject) and
        _.isFunction(lodash.merge) and
        _.isFunction(lodash.omit)
       )

    Uberscore::[key] = val for key, val of { #add to :: from {}, easier to urequire `replaceCode` in an RC :-)
      # Blender
      Blender: require 'blending/Blender'
      traverse: require 'blending/traverse'
      clone: require 'blending/clone'

      # Objects
      okv: require 'objects/okv'
      mutate: require 'objects/mutate'
      setp: require 'objects/setp'
      getp: require 'objects/getp'
      isDisjoint: require 'objects/isDisjoint'
      isRefDisjoint: require 'objects/isRefDisjoint'
      getRefs: require 'objects/getRefs'
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
      isEqualArraySet: require "collections/array/isEqualArraySet"
      arrayize: require 'collections/array/arrayize'

      # Agreements
      isAgree: require 'agreement/isAgree'
      inAgreements: require 'agreement/inAgreements'

      # typing
      type: require 'types/type'
      isPlain: require 'types/isPlain'
      isHash: require 'types/isHash'

      # Logging / debugging
      Logger: require 'Logger'

      # various @todo either DEPRACATE or bring up to a proper decorator ?
      certain: require 'certain'

      CoffeeUtils: require 'utils/CoffeeUtils'
      CalcCachedProperties: require 'utils/CalcCachedProperties'
      subclass: require 'utils/subclass'
    }

    Uberscore::[key] = val for key, val of require 'blending/blenders'#/index.js

  new Uberscore
