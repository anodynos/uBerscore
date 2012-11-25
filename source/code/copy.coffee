_ = require("lodash")
options =
  clone: "mutate clone collection"
  deep:  ""

copy = (options= _.defaults options, copyDest, sources...) ->

  obj

module.exports = copy


## Inline dev tests
#data = require '../spec/spec-data'
## clone to check mutability
#projectDefaults = _.clone data.projectDefaults, true
#globalDefaults = _.clone data.globalDefaults, true
#bundleDefaults = _.clone data.bundleDefaults, true
#
#result = deepExtend globalDefaults, projectDefaults, bundleDefaults
#
#console.log JSON.stringify result, null, ' '
