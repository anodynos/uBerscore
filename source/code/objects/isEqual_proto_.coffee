###
  Just like _.isEqual BUT       # NOT VALID in case of non-equal, NOT VALID #
  it checks all properties of inheritance chain (__proto_ chain using `./getAllPropertyNames`)
  for both a & b and decides if their root-level properties are _.isEqual
###
_ = require 'lodash'
getAllPropertyNames = require('./getAllPropertyNames')

isEqual_proto_ = (a, b, callback, thisArg)->
  allProps = _.union getAllPropertyNames(a), getAllPropertyNames(b)

  for prop in allProps
    if not _.isEqual a[prop], b[prop], callback, thisArg
      return false

  true

module.exports = isEqual_proto_