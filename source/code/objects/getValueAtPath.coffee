_ = require 'lodash'

defaultOptions =
  separator: '/'
  stopKey: "#"              # @todo: alternative as callback
  terminateKey: undefined   # @todo: alternative as callback
  defaultKey: "*"           # @todo: alternative as callback
  isReturnLast: false       # @todo: doc it & spec it!

###
  Gets a value from an Object, with a given path from either a textual description (with separator) or an array of path names.

  Its guaranteed only one path will be followed (or an undefined will be returned)

  While walking/retrieving path keys from o, there are some twists:

    terminateKey: @todo: spec it!
      Before looking for any actual key, if this key is found on current object, then walking stopKeys and
      the value within terminateKey is returned (with terminateKey it self as root).

      eg if terminateKey = '|', in
      {
        'a':'b':
          'c':
            'd':'d'
          '|':'terminated'
      }
     with (valid) path = 'a/b/c/d' the result will be {'|':'terminated'} instead of 'd'.

    stopKey:
      If a key's value is undefined, then it attempts to retrieve '#' (as defaultKey).
      If a value is found on '#', it stops and the returns that value.

    defaultkey:
      if a key's value is undefined then it attempts to retrieve '*' (defaultKey) before giving up.
      If a value is found on '*', it continues as if the original not-found key value was found.

    Note: Precendence is terminateKey, stopKey & finally defaultkey.
          So using defaultKey along stopKey or terminateKey & any other is pointless:
            terminateKey is always returned, if it exists, then stopKey and finally,
            if those aren't there, defaultkey is returned.

    isReturnLast:
      If true, it returns the last non-undefined value found.

    Note: to disable them, use set them to '' (dont set them to undefined, they'll get overwritten by defaults)

  @param o {Object} The object to search into.

  @param path {String|Array<String>} Either a path as a String (separated by separator) or an array of path key names.

  @param options {Object}
    @option separator {String} The seperator to split a String path with. The defaultKey is '/'.

    @option stopKey {String} The stopKey to retrieve, if original not found, and then stop walking returning it.

    @option defaultKey {String} The defaultKey to retrieve if original not found - walking continues as normal if defaultKey is found

    @option terminateKey {String} The key that terminates all further walking and even if the key requested exists, it instead
                               returns an object with one key (the terminateKey) and the value of the terminateKey in the original object.

    @option isReturnLast {truthy} If true, it returns the last non-undefined value found. # @todo: spec it

    @option iter: a callback with objectAtPath, path, o @todo: NOT IMPLEMENTED

###
getValueAtPath = (o, path, options = defaultOptions)->
  _.defaults options, defaultOptions if options isnt defaultOptions

  if not _.isArray(path)
    if _.isString path
      path = path.split options.separator
    else
      if _.isNumber path
        path = [path + '']
      else
        if path is undefined
          return o
        else
          throw "_B.getValueAtPath Error: invalid path: #{path}"

  for p in path when p+'' #hanldle p being a Number
    lastO = o if o isnt undefined

    if not _.isObject o
      o = undefined
      break

    if options.terminateKey
      if o[options.terminateKey]
        returnWithTerminator = {}
        returnWithTerminator[options.terminateKey] = o[options.terminateKey]
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

#l = new (require '../Logger') 'uberscore/getValueAtPath'
#
#o =
#  '$':
#    bundle:
#      some: path:"|": terminated:"because of terminateKey !"
#
#      anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
#      dependencies:
#        depsVars: "Bingo"
#        '#': 'No deps when terminal key is found'
#        "|": terminatedAgain:" again because of terminateKey !"
#      '*': 'paparo values'

#l.log getValueAtPath o, '$/bundle/some/path', terminateKey:'|'
#l.log getValueAtPath o, '/$/bundle/dependencies/malakies', isReturnLast: true, terminateKey:'|'
#
#o =
#  '$':
#    bundle:
#      anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
#      '*': IamA: "defaultValue"
#      dependencies:
#        depsVars: "Bingo"
#      someOtherKey:
#        '*': notReached: "defaultValue"
#        '#': IamA: Stop: "Value"
#      leadingToTerminate:
#        '|': terminated: 'terminated value'
#        someKey: someOtherKey: 'someValue'
#
#l.log getValueAtPath o, '$/bundle/leadingToTerminate/someKey/someOtherKey', terminateKey:'|'