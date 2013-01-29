_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !

knownTypes = ['Array', 'Arguments', 'Function', 'String', 'Number', 'Date', 'RegExp', # @todo: test those with Object.prototype.toString ?
             'Boolean', 'Null', 'Undefined', 'Object'] # testTypes

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