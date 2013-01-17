#_ = require 'lodash' # not need anymore, we have it as a Bundle Dependency!

deepExtend = require './deepExtend'
# @todo:6,2 make a non clone version ? Implications ?
# @todo:7,8 get rid of it and use B
###
  Works like `_.defaults`, but
  a) goes deep, not just surface like `_.defaults`
  b) clones defaults... objects
  @todo:at implications would it have ?
###
deepCloneDefaults = (o, defaults...)->
  reversedClonedDefaults = []
  for d in arguments
    reversedClonedDefaults.unshift _.clone d, true

  o = deepExtend.apply null, reversedClonedDefaults
  o

module.exports = deepCloneDefaults
