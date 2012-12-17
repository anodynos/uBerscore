_ = require 'lodash'
go = require './go'
isAgree = require './isAgree'

###
  Mutates the `Value` for each of the `Keys` of a given Object or Array

  @param oa Object or Array
  @param Function mutator (v,k) is given the old val & key and returns a new value.
  @param Filter as in `_B.isAgree`, otherwise this key/value its not mutated. Note: isAgree allows "undefined" as a truthy filter
###
mutate = (oa, mutator, fltr)->
  if _.isFunction mutator #todo:2 other non-function mutators ?
    go oa, iter:(v,k)->
      if isAgree v, fltr
        oa[k] = mutator v
  oa

module.exports = mutate

##@done: turned into specs
#o = a:1, b:2, c:-1
#mutate o, (v,k)->if v<0 then v+10 else v+20
#console.log o # gives { a: 21, b: 22, c: 9 }
#
#a = [1, 2, -1]
#mutate a, (v,k)->if v<0 then v+10 else v+20
#console.log a # gives [21, 22, 9]
#
#mutate( a,
#          (v,k)->if v<0 then v+10 else v+20
#          (v)->v>10 #fltr
#         )
#console.log a # gives [41, 42, 9]
#
## ############
#res =  mutate {key1: 'lalakis', key2: ['ok','yes']}, require('./arrayize'), _.isString
#console.log JSON.stringify res, null, ' '

