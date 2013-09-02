type = require 'types/type'

# Returns true if the data type is "plain" in terms of not
# naturally/normally having nested items in it.
#
# Its similar to `not _.isObject(o)` but nor not really it,
# cause new String() is considered _B.isPlain but also _.isObject().
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