_ = require 'lodash'

defaultOptions =
  separator: '/'
  terminalKey: "#"
  defaultKey: "*"

###
  Gets a value from an Object, with a given path from either a textual description (with separator) or an array of path names.

  Its guaranteed only one path will be followed (or an undefined will be returned)

  It has two twistsm, while walking/retrieving from o:
    terminalKey:
      if a key's value is undefined, then it retrieves '#' (as default).
      If a value is found on '#', it terminates and the returns that value.

    defaultkey:
      if a key's value is undefined then it retrieves '*' (default) before giving up.
      If a value is found on '*', it continues as if the original not-found key value was found.
      Note: terminalKey has precedence - using defaultKey along terminalKey is pointless.


  @param o {Object} The object to search into.

  @param path {String|Array<String>} Either a path as a String (separated by separator) or an array of path key names.

  @param options Object
    @option separator {String} The seperator to split a String path with. The default is '/'.
    @option terminalKey {String} The terminalKey to retrieve if original not found and then terminate.
    @option defaultkey {String} The defaultKey to retrieve if original not found
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
    if not _.isObject o
      return undefined

    if o[p] isnt undefined
      o = o[p]
    else
      if o[options.terminalKey] isnt undefined
        o = o[options.terminalKey] # @TODO: write specs for '#'.
        break
      else
        o = o[options.defaultKey] # @TODO: write specs for '*'.
  o

module.exports = getValueAtPath

l = new (require '../Logger') 'getValueAtPath'

o =
  '$':
    bundle:
      anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
      dependencies:
        variableNames: "Bingo"
        '#': 'No deps when terminal key is found'
      '*': 'paparo values'


l.log getValueAtPath o, '$/bundle////dependencies/malakies/toubana'