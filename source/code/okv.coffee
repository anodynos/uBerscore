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

 @param obj {Object} where k/v go
 @param keyValPairs... {String} key {String}, value {object} pairs.
        Keys (in even positions) should evaluate to String.
        Values can be any other objects.
        If even number is passed, the last one is ignored.
 @return obj {Object} with augmented properties.
###
okv = (obj, keyValPairs...)->
  for keyName, idx in keyValPairs by 2 when idx+1 < keyValPairs.length
      obj[keyName] = keyValPairs[idx+1]
  obj

module.exports = okv

o = okv {}, "marika", "pentagiotisa", "papari", 'orthio'
console.log o