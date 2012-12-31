urequire:                        # uRequire Module Configuration
  rootExports: ['_B', 'uBerscore']
  noConflict: true

class uBerscore
  # @todo: instantation of a B object (ala jQuery object) - see B.coffee
  # Collection related
  go: require 'go'
  deepExtend: require './deepExtend'
  deepCloneDefaults: require 'deepCloneDefaults'

  # Object related
  okv: require 'okv'
  arrayize: require './arrayize'

  # agreement related - required both as bundleRelative & fileRelative for uRequire 's sake
  isAgree: require './agreement/isAgree'
  inFilters: require 'agreement/inFilters'

  certain: require 'certain'

  # mutators
  mutate: require 'mutate'

  backboner: require 'backboner'

module.exports = new uBerscore

ao = a:1, b:2, c:-1

ao = module.exports.go ao, fltr:'a'
#console.log ao

#! extendIf (maybe noit, you can achivie it with a chain. Still worth a shortcut?)

# value (propertyOrFunction, context)-> like _.result(), but used as ref, without an object... ??/ Is it meaningfull ?

