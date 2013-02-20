_ = require 'lodash'
l = new (require './../Logger') 'Blending/shortify', 0
type = require '../type'

###
  Converts each key in bb (like 'Array', 'Object' etc) to their `type.toShort` equivalent (like '[]' or '{}')

  @param {BlenderBehavior} bb The BlenderBehavior Object to traverse

  # @todo:(5 6 1) Test spec it!
###
shortify = (bb)->
  bb = toShortTypeFormat bb # convert to `type.short` format, always use this internally
  for key, val of bb when type.isType(key) # ignore non-types (eg blendBehavior.order & actions)
    if _.isPlainObject(val) #recurse
      shortify val
  l.log 'shortified:', bb
  bb


###
  Changes all root keys named 'Array', 'Object' etc to '[]', '{}' etc
###
toShortTypeFormat = (o)->
  for key of o when type.isType(key)
    short = type.toShort key
    if short and (key isnt short)
      o[short] = o[key]
      delete o[key]
  o

module.exports = shortify

#ba = {
#    'order': ['src', 'dst'] # @todo: rename to ""flavor" ? "aroma"
#
#    'Null': -> 'MarkForRejection'
#    'Object': -> "All Objects go here"
#    'Array':
#      "Array": (prop, src, dst)-> _.reject @deepOverwrite(prop, src, dst), (v)->v is 'MarkForRejection'
#}
#console.log ba
#baa = shortify ba
#
#console.log "Finalle:\n", baa

console.log toShortTypeFormat {
  "Array": [1,2,3]
  Object: {}
  Malakies:"Paparia"
}
