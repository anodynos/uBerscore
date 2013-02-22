_ = require 'lodash'

getPropertyAtPath = (o, path)->
  if not _.isArray(path)
    if _.isString path
      path = path.split('/')
    else
      throw "_B.getPropertyAtPath Error: invalid path: #{path}"

  for p in path when p
    if not _.isObject o
      return undefined
    o = o[p]

  o

module.exports = getPropertyAtPath

# inline tests @todo: spec it
blenderBehavior =
  order: ['path', 'src', 'dst']
  '$':
    bundle:
      dependencies:
        variableNames:
            '|' : "Bingo"


l = new (require './../Logger')
path = '$/bundle/dependencies/variableNames'
l.log getPropertyAtPath blenderBehavior, path

#
