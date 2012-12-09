urequire:                         # uRequire Module Configuration

  rootExports: ['_B', 'uBerscore']

  noConflict: true

class uBerscore
  # @todo: instantation of a B object (ala jQuery object) - see B.coffee

  # Collection related
  go: require './go'
  deepExtend: require './deepExtend'
  deepCloneDefaults: require './deepCloneDefaults'

  # Object related
  okv: require './okv'
  arrayize: require './arrayize'
  isAgree: require './isAgree'
  inFilters: require './inFilters'
  certain: require './certain'
  backboner: require './backboner'

module.exports = new uBerscore


#! extendIf (maybe noit, you can achivie it with a chain. Still worth a shortcut?)

# value (propertyOrFunction, context)-> like _.result(), but used as ref, without an object... ??/ Is it meaningfull ?

