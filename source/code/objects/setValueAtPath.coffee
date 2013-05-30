_ = require 'lodash'

#todo: use defaultOptions = {forceCreate: false, separator: '.'}
setValueAtPath = (o, path, val, forceCreate=false, separator='/')-> #
  if not _.isArray path
    if _.isString path
      path = path.split separator
      path = (p for p in path when p) # clean up any empty paths
    else
      throw """_B.setValueAtPath Error: invalid path: #{path}.
                Use either an Array, eg ['path1', 'path2']
                or `separator`-ed String, eg 'path1.path2'"""

  if not _.isObject o
    throw "_B.setValueAtPath Error: invalid object: #{o}"

  for p, pi in path
    if not _.isObject o[p]
      if forceCreate # either true or a string will do
        newObj = {}
                                       # preserve current value of `o[p]`
        if not _.isUndefined(o[p]) and # if there is any value
          _.isString(forceCreate)      # under `forceCreate` key (eg 'oldValue')
            newObj[forceCreate] = o[p]

        o[p] = newObj
      else
        if _.isUndefined(o[p])
          return false # wont set value on inexistent path

    o = o[p] if pi < path.length-1 #the last one is our {} to mutate

  o[p] = val
  true

module.exports = setValueAtPath

#inline tests

#l = new (require './../Logger') 'uberscore/setValueAtPath'
#
#o=
#  '$':
#    bundle:
#      anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
#      dependencies:
#        depsVars: "Bingo"
#
#oClone = _.clone o, true
#l.log setValueAtPath( oClone,
#  '$/bundle/dependencies/newKey/anotherNewKey', 'just_a_String', 'oldValue'
#)
#
#
#l.log oClone