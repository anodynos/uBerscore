_ = require 'lodash'
type = require './type'

# Returns true if the data type is "plain" in terms of not having nested items in it.
# Its similar to `not _.isObject(o)` but nor not really it,
# cause String is considered plain but it isObject().
isPlain = (o)->
  type(o) in isPlain.PLAIN_TYPES


isPlain.PLAIN_TYPES = [
  'String'
  'Date'
  'RegExp'
  'Number'
  'Boolean'
  'Null'
  'Undefined'
]

module.exports = isPlain