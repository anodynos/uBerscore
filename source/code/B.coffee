### go & deepExtend & deepCloneDefaults combined! ###
###    work in progress                           ###
#_ = require 'lodash' # not need anymore, we have it as a Bundle Dependency!

B = (actions, oa...)-> # @todo: implmement it!


###
  @example

Note:
> If your [JavaScript doesn't guarantee Object Property Order](http://stackoverflow.com/questions/5525795/does-javascript-guarantee-object-property-order)
  to ensure actions are 'executed' in the correct order, it will require a special format :
  [
    aaa: (a)-> a
   ,
    bbb: (b)-> b
   ,
    ccc: (c)-> c
  ]
###

# inline dev tests

data = require '../spec/spec-data'
# clone to check mutability
projectDefaults = _.clone data.projectDefaults, true
globalDefaults = _.clone data.globalDefaults, true
bundleDefaults = _.clone data.bundleDefaults, true

# @example usage
myFinalSettings = B(
  filter: (val, key, oa)-> key in ['compilers']
  copy:
    #OAis: '[]O' # @todo: how do we treat O or A's in from & to ? in [ '[]', '[]O'] etc
    from: [projectDefaults, globalDefaults, bundleDefaults ] # always work left to right.
    to: {}    # if
    overwrite:
      (srcKey, srcVal, dstKey, dstVal)-> true #default: true
                                              # true overwrites property - couldhave set to true!
                                              # of all oa's in 'to' are overwritten
                                              # BUT all oa's in 'from' are always cloned and left intact!

    clone: (srcKey, srcVal, dstKey, dstVal)-> false #default: true
                                                    # If true, every overwrite is to a cloned value
                                                    # If false, its copied by reference.


  sort: (value, indexOrKey, collection)-> #see _B.go
  iter: (value, indexOrKey, collection)-> #see _B.go
  grab: (value, indexOrKey, collection)-> #see _B.go
  map: (value, indexOrKey, collection)-> #see _B.go

  opts:
    context: bundleDefaults
    deep:
      type: 'integer'
      descr: "how deep to go into sub-levels"
      default: 99999

    asynch: default: false
)

#console.log _.isEqual data.bundleDefaults, bundleDefaults
#console.log _.isEqual data.projectDefaults, projectDefaults
#console.log _.isEqual data.globalDefaults, globalDefaults
