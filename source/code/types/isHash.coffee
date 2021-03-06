###
Why do we need another `isObject` function ? Well its different

 - it returns true ONLY and ALWAYS if type is a Hash {}, and always false
   for `Array` or `Function` `new String()` etc (unlike underscore's/lodash's 'isObject')

 - it returns true for any hash {}, even if its an *instance* {} NOT created by `Object` creator,
   but by some Function/class constructor (unlike lodash's 'isPlainObject')
###
#define ['types/type'], (type)-> (o)-> type(o) is 'Object'

module.exports = isHash =
  (o) ->
    o is Object(o) and
      Object.prototype.toString.call(o) not in [
        'Array'
        'Arguments'
        'Function'
        'String'
        'Number'
        'Date'
        'RegExp'
        'Boolean'
        'Null'
        'Undefined'
      ].map (t) -> """[object #{t}]"""
