class uBerscore # @todo: integrate with _ & allow chaining,
                # @todo: instantation of a B object (ala jQuery object) - see B.coffee

  go: require './go'

  deepExtend: require './deepExtend'

  deepCloneDefaults: require './deepCloneDefaults'

  ###
  # Takes object o & returns a fn, that returns o[key] ? 'default' value (value with key '*')
  # if the o[key] is 'undefined'
  # @param o {Object} The object to query for keys
  # @return function(key) that returns value for key, or default value (if undefined)
  ###
  certain: (o)-> (key)-> o[key] ? o['*']

  B: require './B'


module.exports = new uBerscore



#! extendIf (maybe noit, you can achivie it with a chain. Still worth a shortcut!)

# value (propertyOrFunction, context)-> like _.result(), but used as ref, without an object... ??/ Is it meaningfull ?

