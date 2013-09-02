###
 A helper to augment (or create) an object with dynamic (calculated) keys on the fly.

 Js/coffee dont allow this:
 ```
  o = { "key" + name : "value"}
 ```
 Key/value pairs are augmenting given object, overwritting existing keys.
 if the first param _.isString, its becomes the first key and a new object is created and returned.

 @example
 `var name1 = 'foo', name2 = 'bar'`

 In javascript:
 ```o = okv({}, "key" + name1, "value1", "anotherKey" + name2, "value2")```

 or more naturally in coffeescript (passing a String instead of obj as 1st param):
 ```o = okv "key#{name1}",         "value1"
            "anotherKey#{name2}", "value2"
 ```
 result
 ```o = {"keyfoo": "value1", "anotherKeybar", "value2"}```

 @param obj {Object} where k/v go. If the first param _.isString, then it becomes the 1st key
        and a new object is created and returned.

  @param keyValPairs... {String} key {String}, value {object} pairs.
        Keys (in even positions) should evaluate to String.
        Values can be any other objects.
        If even number of key/values is passed, the last one is ignored.

 @return {Object} with augmented properties.

 @todo : what happens if key is invalid (null/undefined) ?
          throw error ?
          Discard ?
          Perhaps have two versions, loose & strict
###

okv = (obj, keyValPairs...)->
  if _.isString obj # no real obj passed, create a new one
    keyValPairs.unshift obj # its really a key, not an obj
    obj = {}

  if _.isObject obj
    for keyName, idx in keyValPairs by 2 when idx+1 < keyValPairs.length
        obj[keyName+''] = keyValPairs[idx+1]
    obj
  else
    null

module.exports = okv