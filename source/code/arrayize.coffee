_ = require 'lodash'

###
  @return Array If item not already an Array, it becomes an item of an array.
                If its null or undefined, empty array is returned (to prevent loops)
###
arrayize = (item)->
  if _.isArray item
    item
  else
    if _.isUndefined(item) or _.isNull(item)
      []
    else
      [item]

module.exports = arrayize

# @todo: spec it!
#console.log arrayize 'a'
#console.log arrayize 1
#console.log arrayize [1, 'john']
#console.log arrayize undefined

