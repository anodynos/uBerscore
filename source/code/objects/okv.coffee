#_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !

###
 A helper to create an object literal with a dynamic (calculated) keys on the fly.

 Js/coffee right now dont like this:
 ```
  o = { "key" + name : "value"}
 ```
 All key/value pairs are augmenting given object, overwritting existing keys.

 @example
 `var name1 = 'foo', name2 = 'bar'`

 In javascript:
 ```o = okv({}, "key" + name1, "value1", "anotherKey" + name2, "value2")```

 or more naturally in coffeescript:
 ```o = okv {}, "key#{name1}",         "value1"
                 "anotherKey#{name2}", "value2"
 ```
 result
 ```o = {"keyfoo": "value1", "anotherKeybar", "value2"}```

 @param obj {Object} where k/v go
 @param keyValPairs... {String} key {String}, value {object} pairs.
        Keys (in even positions) should evaluate to String.
        Values can be any other objects.
        If even number is passed, the last one is ignored.
 @return obj {Object} with augmented properties.

 @todo : what happens if key is invalid (null/undefined) ?
          throw error ?
          Discard ?
          Perhaps have two versions, loose & strict
###
okv = (obj, keyValPairs...)->
  if _.isObject obj
    for keyName, idx in keyValPairs by 2 when idx+1 < keyValPairs.length
        obj[keyName] = keyValPairs[idx+1]
    obj
  else
    null

module.exports = okv
