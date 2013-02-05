_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
isAgree = require './agreement/isAgree' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
go = require './go'

###
  Mutates the `Value` for each of the `Keys` of a given Object or Array

  @param oa Object or Array
  @param Function mutator (v,k) is given the old val & key and returns a new value.
  @param Filter as in `_B.isAgree`, otherwise this key/value its not mutated. Note: isAgree allows "undefined" as a truthy filter

  @todo: (2 2 2) mutateKey() ?
###
mutate = (oa, mutator, fltr)-> # @todo: (4 4 4): make fltr an {option.fltr}, along with o.mode etc
  if _.isFunction mutator #todo:(2 6 4) other non-function mutators ?
    go oa, iter:(v,k)->
      if isAgree v, fltr
        oa[k] = mutator v #, k, oa # @todo: (2 2 2): this is dangerous!
  oa

module.exports = mutate