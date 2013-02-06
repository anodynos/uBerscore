_ = require 'lodash'
type = require './type'

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