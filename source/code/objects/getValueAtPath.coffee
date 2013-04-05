_ = require 'lodash'

getValueAtPath = (o, path, separator = '/')->
  if not _.isArray(path)
    if _.isString path
      path = path.split separator
    else
      throw "_B.getValueAtPath Error: invalid path: #{path}"

  for p in path when p
    if not _.isObject o
      return undefined
    o = o[p]

  o

module.exports = getValueAtPath
#
##inline tests
#blenderBehavior =
#  order: ['path', 'src', 'dst']
#  '$':
#    bundle:
#      dependencies:
#        variableNames: "Bingo"
#
#l = new (require './../Logger')
#l.log getValueAtPath blenderBehavior, '$.}.bundle.}.dependencies.}.', '.}.'

