urequire:                         # uRequire Module Configuration

  rootExports: ['_B', 'uBerscore'] # descr: 'export these names as global keys, with vthe alue being this Module.
                                  # type: ['String', '[]'], default: 'undefined'

  noConflict: true                # descr: 'Generate noConflict() for module'
                                  # type: 'boolean', default: false
  noAMDonly: true

#  rootExports for nodejs NOT working yet on uRequire 0.2.7 - wait for upgrade?!
#  nodejs: true                    # descr: 'Export & noConflict() for nodejs as well'
#                                  # type:'boolean', default: false

class uBerscore
  # @todo: instantation of a B object (ala jQuery object) - see B.coffee

  go: require './go'

  deepExtend: require './deepExtend'

  deepCloneDefaults: require './deepCloneDefaults'

  okv: require './okv'

  ###
  # Takes object o & returns a fn, that returns o[key] ? 'default' value (value with key '*')
  # if the o[key] is 'undefined'
  # @param o {Object} The object to query for keys
  # @return function(key) that returns value for key, or default value (if undefined)
  ###
  certain: (o)-> (key)-> o[key] ? o['*']


module.exports = new uBerscore



#! extendIf (maybe noit, you can achivie it with a chain. Still worth a shortcut!)

# value (propertyOrFunction, context)-> like _.result(), but used as ref, without an object... ??/ Is it meaningfull ?

