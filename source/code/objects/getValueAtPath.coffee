_ = require 'lodash'

defaultOptions =
  separator: '/'
  stopKey: "#"
  terminatorKey: undefined
  defaultKey: "*"

  isReturnLast: false # @todo: doc it & spec it!

###
  Gets a value from an Object, with a given path from either a textual description (with separator) or an array of path names.

  Its guaranteed only one path will be followed (or an undefined will be returned)

  While walking/retrieving path keys from o, there are some twists:

    terminatorKey: @todo: spec it!
      Before looking for any actual key, if this key is found on current object, then walking stops and
      the value within terminatorKey is returned (with terminatorKey it self as root).

      eg if terminatorKey = '|', in
      {
        'a':'b':
          'c':
            'd':'d'
          '|':'terminated'
      }
     with (valid) path = 'a/b/c/d' the result will be {'|':'terminated'} instead of 'd'.

    stopKey:
      If a key's value is undefined, then it attempts to retrieve '#' (as default).
      If a value is found on '#', it stops and the returns that value.

    defaultkey:
      if a key's value is undefined then it attempts to retrieve '*' (default) before giving up.
      If a value is found on '*', it continues as if the original not-found key value was found.

    Note: Precendence is terminatorKey, stopKey & finally defaultkey.
          So using defaultKey along stopKey or terminatorKey & any other is pointless:
            terminatorKey is always returned, if it exists, then stopKey and finally,
            if those aren't there, defaultkey is returned.

    isReturnLast:
      If true, it returns the last non-undefined value found.

    Note: to disable them, use set them to '' (dont set them to undefined, they'll get overwritten by defaults)

  @param o {Object} The object to search into.

  @param path {String|Array<String>} Either a path as a String (separated by separator) or an array of path key names.

  @param options {Object}
    @option separator {String} The seperator to split a String path with. The default is '/'.

    @option stopKey {String} The stopKey to retrieve, if original not found, and then terminate returning it.

    @option defaultkey {String} The defaultKey to retrieve if original not found - walking continues as normal

    @option terminatorKey {String} The key that stops all further walking and even if the key requested exists, it instead
                                    returns an object with one key (it self) and the value of it self in the original object.

    @option isReturnLast {truthy} If true, it returns the last non-undefined value found. # @todo: spec it

###
getValueAtPath = (o, path, options = defaultOptions)->
  _.defaults options, defaultOptions if options isnt defaultOptions

  if not _.isArray(path)
    if _.isString path
      path = path.split options.separator
    else
      if path is undefined
        return o
      else
        throw "_B.getValueAtPath Error: invalid path: #{path}"

  for p in path when p
    lastO = o if o isnt undefined

    if not _.isObject o
      o = undefined
      break

    if options.terminatorKey
      if o[options.terminatorKey]
        returnWithTerminator = {}
        returnWithTerminator[options.terminatorKey] = o[options.terminatorKey]
        o = returnWithTerminator
        break

    if o[p] isnt undefined
      o = o[p]
    else
      if options.stopKey and o[options.stopKey] isnt undefined
        o = o[options.stopKey]
        break
      else
        o = if options.defaultKey and o[options.defaultKey]
              o[options.defaultKey]
            else
              undefined

  if o is undefined
    if options.isReturnLast then lastO else o
  else
    o

module.exports = getValueAtPath

l = new (require '../Logger') 'getValueAtPath'

o =
  '$':
    bundle:
      some: path:"|": terminated:"because of terminatorKey !"

      anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
      dependencies:
        variableNames: "Bingo"
        '#': 'No deps when terminal key is found'
        "|": terminatedAgain:" again because of terminatorKey !"
      '*': 'paparo values'

#l.log getValueAtPath o, '$/bundle/some/path', terminatorKey:'|'
l.log getValueAtPath o, '/$/bundle/dependencies/malakies', isReturnLast: true, terminatorKey:'|'
