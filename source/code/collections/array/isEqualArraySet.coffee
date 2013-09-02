# Checks if the two sets are equal.
# Based on _.difference.

# @a1 Array 1st Array
# @a2 Array 2nd Array
# #todo: @equalsFn # _.difference currentlly supports === equality only. check https://github.com/bestiejs/lodash/issues/246
# #todo: reimplement this without _.difference

isEqualArraySet = (a1, a2, equalsFn)->
  if _.difference(a1, a2).length is 0
    _.difference(a2, a1).length is 0
  else
    false

module.exports = isEqualArraySet
