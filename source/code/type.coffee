_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !

knownTypes = ['Arguments'
              'Array',
              'Function'
              'String'
              'Date'
              'RegExp'
              'Object' # due to order, Object is return only for REAL objects (i.e _.isPlainObject), not for [] or ->
              'Number'
              'Boolean'
              'Null'
              'Undefined'
              ]
# @todo: provide a more plausible implementation, instead of a looping hack hell!
module.exports =
  type = (o)->
    for testType in knownTypes
      if _["is#{testType}"] o
        return testType

    return 'UNKNOWN'

# inline tests
#oOs = {
#  'Array': ['this', 'is', 1, 'array']
#  #'Arguments':# todo: test this
#  'Function': (x)->x
#  'String': "I am a String!"
#  'Number': 667
#  'Date': new Date()
#  'RegExp': /./g
#  'Boolean': true
#  'Null': null
#  'Undefined': undefined
#  'Object': {a:1, b:2}
#}
#
#for k, v of oOs
#  console.log  (type v) is k