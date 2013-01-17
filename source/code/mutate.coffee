#_ = require 'lodash' # not need anymore, we have it as a Bundle Dependency!
# isAgree = require './agreement/isAgree' # not need anymore, we have it as a Bundle Dependency!
go = require './go'

###
  Mutates the `Value` for each of the `Keys` of a given Object or Array

  @param oa Object or Array
  @param Function mutator (v,k) is given the old val & key and returns a new value.
  @param Filter as in `_B.isAgree`, otherwise this key/value its not mutated. Note: isAgree allows "undefined" as a truthy filter

  @todo: mutateKey() ?
###
mutate = (oa, mutator, fltr)->
  if _.isFunction mutator #todo:2 other non-function mutators ?
    go oa, iter:(v,k)->
      if isAgree v, fltr
        oa[k] = mutator v
  oa

module.exports = mutate