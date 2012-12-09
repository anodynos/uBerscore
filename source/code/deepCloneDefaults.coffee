_ = require 'lodash'

deepExtend = require './deepExtend'
#@todo: test _.mixin deepExtend

deepCloneDefaults = (o, defaults...)->
  reversedClonedDefaults = []
  for d in arguments
    reversedClonedDefaults.unshift _.clone d, true

  o = deepExtend.apply null, reversedClonedDefaults
  o

module.exports = deepCloneDefaults

# inline dev tests
#data = require '../spec/spec-data'
## clone to check mutability
#projectDefaults = _.clone data.projectDefaults, true
#globalDefaults = _.clone data.globalDefaults, true
#bundleDefaults = _.clone data.bundleDefaults, true
#
#result = deepCloneDefaults bundleDefaults, projectDefaults, globalDefaults
#
#console.log JSON.stringify result, null, ' '
#
#console.log _.isEqual data.bundleDefaults, bundleDefaults
#console.log _.isEqual data.projectDefaults, projectDefaults
#console.log _.isEqual data.globalDefaults, globalDefaults
