_ = require 'lodash'

setPropertyAtPath = (o, path, val, isForceCreate)-> #
  if not _.isArray(path)
    if _.isString path
      path = path.split('/')
    else
      throw "_B.setPropertyAtPath Error: invalid path: #{path}"

  if not _.isObject o
    throw "_B.setPropertyAtPath Error: invalid object: #{o}"

  pathLength = path.length
  for p, pi in path when p
    if not _.isObject o[p]
      if isForceCreate
        o[p] = {}
      else
        return false #cant set

    o = o[p] if pi < pathLength-1 #the last one is our {} to mutate

  if _.isObject o[p]
    o[p] = val
    true
  else
    false

module.exports = setPropertyAtPath

# inline tests @todo: spec it
l = new (require './../Logger')

blenderBehavior =
  order: ['path', 'src', 'dst']
  '$':
    bundle:
      dependencies:
        variableNames:
            '|' : "Bingo"

path = '$/bundle/dependencies/variableNames/hi'
l.log setPropertyAtPath blenderBehavior, path, "joke": "joke2":'JOKER', false
l.log blenderBehavior