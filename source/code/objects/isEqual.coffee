###
  Just like _.isEqual BUT with more options :
    * `inherited` : if true, it checks all properties of inheritance chain (__proto_ chain)
       for both a & b and decides if their root-level properties are also isEqual ,,,options
    * `exclude`: array of exclusions, default is ['constructor']
###
_ = require 'lodash'
type = require '../type'
isPlain = require '../isPlain'
isEqualArraySet = require '../collections/array/isEqualArraySet'

isEqualDefaults = {
    inherited: false
    exclude: ['constructor']
    exact: false# if true, then all refs must point to the same objects, not lokkalike clones! #todo: NOT IMPLEMETED
    #callback:-> #todo: implement this way of calling
    #thisArg:that #todo: implement this way of calling
}

isEqual = (a, b, callback, thisArg, options=isEqualDefaults)->

  # is callback actually the options object?
  if _.isPlainObject(callback) and
      _.isUndefined(thisArg) and (options is isEqualDefaults) # destructure it
        options = _.clone options, true
        options[p] or= callback[p] for p in _.keys(isEqualDefaults)
        {callback, thisArg} = callback

  _.defaults(options, isEqualDefaults) if options isnt isEqualDefaults

  # handle callback irrespective of other options
  if _.isFunction(callback)
    cbResult = callback.apply thisArg, [a, b]
    if cbResult isnt undefined # respect only non-undefined as truthy or falsey
      return (if cbResult then true else false)
  else callback = undefined # lodash doesnt like non-function callbacks!

  console.log options

  # if we aren't option.exact=true, _isEqual true is good enough
  aType = type(a); bType = type(b)
  if not (options.exact or options.inherited) and (_.isObject(a) or _.isObject(b))
    if _.isEqual a, b, callback, thisArg
      console.log 'return true - non exact _.isEqual'
      return true
    # no else: but just cause _.isEqual is false, we can't yet decide;
    # not for inherited anyway

  # perhaps we have a strict `exact` match for Object types
  # or a & b really look different
  #
  # Lets eliminate some rudimentary cases
  if a is b
    console.log 'return true - a is b'
    return true
  else
    if isPlain(a) or isPlain(b)
      console.log 'return false - aType in [Boolean... etc]'
      return _.isEqual a, b

  # if we've passed this point, it means for both a & b we have
  # the same non-plain types (ie. we have naturally nested properties)

  if (options.inherited or options.exact)

    if options.inherited
      aKeys = (p for p of a when p not in options.exclude)
      bKeys = (p for p of b when p not in options.exclude)
    else
      aKeys = (p for own p of a when p not in options.exclude)
      bKeys = (p for own p of b when p not in options.exclude)

    return false if (aKeys.length isnt bKeys.length) or   # quickly return false for
                    (not isEqualArraySet aKeys, bKeys) # different set of keys

    for prop in aKeys # xKeys are equal
      #console.log 'prop=', prop, 'a[prop]=', a[prop], 'b[prop]=', b[prop]
      if options.exact # and (_.isObject(a[prop]) or _.isObject(b[prop]))
        if a[prop] isnt b[prop] #exact match required for all nested references of a
          console.log 'return false - exact ref not same'
          return false

      if not _.isEqual a[prop], b[prop], callback, thisArg # todo: might not be needed: use base case
        if not isEqual a[prop], b[prop], callback, thisArg, options # 2nd chance: use isEqual instead as last resort!
          console.log 'return false - not isEqual nested'
          return false

    console.log 'return true - all properties considered'
    return true

  console.log 'return false - nothing left to do!'
  false

module.exports = isEqual