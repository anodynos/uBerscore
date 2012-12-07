urequire:                         # uRequire Module Configuration
  rootExports: ['_B', 'uBerscore'] # descr: 'export these names as global keys, with vthe alue being this Module.
                                  # type: ['String', '[]'], default: 'undefined'

  noConflict: true                # descr: 'Generate noConflict() for module'
                                  # type: 'boolean', default: false

#  rootExports for nodejs NOT working yet on uRequire 0.2.7 - wait for upgrade?!
#  nodejs: true                    # descr: 'Export & noConflict() for nodejs as well'
#                                  # type:'boolean', default: false

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

module.exports = new uBerscore


#! extendIf (maybe noit, you can achivie it with a chain. Still worth a shortcut?)

# value (propertyOrFunction, context)-> like _.result(), but used as ref, without an object... ??/ Is it meaningfull ?

