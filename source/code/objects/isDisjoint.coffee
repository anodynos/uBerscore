###
  Returns true if there are is no common value
  between the two objects/arrays (i.e their intersection is empty)

  @param {oa1} <Array|Object> The first Array or Object (order shouldn't matter)
  @param {oa1} <Array|Object> The second Array or Object
  @param equality Function change the default equality which is ===. Params are v1, v2
###
isDisjoint = (oa1, oa2, equality = (v1, v2) -> v1 is v2)->
  found = false
  _.each oa1, (v1)->
      if _.some(oa2, (v2)-> equality(v1, v2))
        found = true
        return false # exit _.each

  return not found

module.exports = isDisjoint
