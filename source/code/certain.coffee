###
  Takes object o & returns a fn, that returns a defaultVal if a key asked is not there.

  Formally. its simply a `o[key] ? 'default value'`: a val for a 'key' asked, or a 'default value' if that `o[key]` is undefined.

  `defaultKey` defaults to '*' for Objects/Functions, or a large num for arrays

  @param o {Object} The object to query for keys
  @param defaultKey {String} The default key name , "*" is chosen if its not given
  @param defaultVal {Anything} The default value to return. OPTIONAL: If a default value is already present in o, its overwritten only if defaultVal exists
  @param isStrict {boolean} If true, throw error when undefined is returned whatsover. Defaults to false

  @return function(key) that returns value for key, or default value (if undefined)
###
isObject = require 'types/isObject'

certain = (o, defaultKey, defaultVal, isStrict=false)->
  if not (isObject(o) or _.isFunction(o)) # either {}, or -> hold properties. Arrays are a bad case for certain :-)
                                          # _.isPlainObject doesn't work if its constructor is user defined.
    throw """
      Error: _B.certain: o is neither an Object or Function.
      o=#{JSON.stringify o, null, ''}
    """

  defaultKey = "*" if _.isUndefined defaultKey
  #o[defaultKey] = defaultVal ? o[defaultKey] # no need to mutate o, we can still get defaultVal if o[defaultKey] isUndefined

  (key)->
    val = (o[key] ? o[defaultKey]) ? defaultVal # return either o[key] asked, or o[defaultKey] or defaultVal (in case o[defaultKey] changed)
    if isStrict and _.isUndefined val
      throw """
        Error: _B.certain: defaultKey is undefined.
          defaultVal is also undefined.
          key='#{key}' (o[#{key}] is obviously undefined too)
          defaultKey='#{defaultKey}'
          o=#{JSON.stringify o, null, ''}
      """

    val

module.exports = certain
# @todo: test specs!!!
#l = console.log
#o = {a:1,b:2,c:3}
#cO = certain o, null, undefined
##l o
#l cO 'd'