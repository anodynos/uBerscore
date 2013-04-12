_ = require 'lodash'

isEqualArraySet = (a1, a2)->
  if _.difference(a1, a2).length is 0
    _.difference(a2, a1).length is 0
  else
    false

module.exports = isEqualArraySet


