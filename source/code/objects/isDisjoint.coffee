_ = require 'lodash'
###
  Returns true if there are is no common value
  between the two objects/arrays (i.e their intersection is empty)

  @param {oa1} <Array|Object> The first Array or Object (order shouldn't matter)
  @param {oa1} <Array|Object> The second Array or Object
  @param equality Function change the default equality which is ===. Params are v1, v2
###
isDisjoint = (oa1, oa2, equality=(v1,v2)->v1 is v2)->
  found = false
  _.each oa1, (v1)->
      if _.any(oa2, (v2)-> equality(v1, v2))
        found = true
        return false # exit _.each

  return not found

module.exports = isDisjoint

#o1 = p1:1
#o2 = p2:2
#o3 = p3:3
#o4 = p4:4
#
#console.log isDisjoint [o1, o2], {P:p1:1, o3:o3}, _.isEqual