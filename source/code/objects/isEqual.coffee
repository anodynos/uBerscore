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
l = new (require '../Logger') '_B.isEqual', 0

isEqualDefaults =
  inherited: false
  exclude: ['constructor']
  exact: false# if true, then all refs must point to the same objects, not lokkalike clones! #todo: NOT IMPLEMETED

isEqual = (a, b, callback, thisArg, options=isEqualDefaults)->

  # if callback is actually the options object, destructure it
  if _.isPlainObject(callback) and
      _.isUndefined(thisArg) and (options is isEqualDefaults)
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

  l.debug options if l.debugLevel > 20

  # if we aren't option.exact=true, _isEqual *true* is true enough
  aType = type(a); bType = type(b)
  if not (options.exact or options.inherited) and (_.isObject(a) or _.isObject(b))
    if _.isEqual a, b, callback, thisArg
      l.debug 'return true - non exact _.isEqual' if l.debugLevel > 40
      return true
      # no else: just cause _.isEqual is false, we can't yet decide;
      # not for inherited anyway

  # perhaps we have a strict `exact` match for Object types
  # or a & b really look different
  #
  # Lets eliminate some rudimentary cases
  if a is b
    l.debug 'return true - a is b' if l.debugLevel > 40
    return true
  else
    if isPlain(a) or isPlain(b) or _.isFunction(a) or _.isFunction(b)
      l.debug 'return  _.isEqual a, b' if l.debugLevel > 40
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
      #if l.debugLevel > 40 l.debug 'prop=', prop, 'a[prop]=', a[prop], 'b[prop]=', b[prop]
      if options.exact # and (_.isObject(a[prop]) or _.isObject(b[prop]))
        if a[prop] isnt b[prop] #exact match required for all nested references of a
          l.debug 'return false - exact ref not same' if l.debugLevel > 40
          return false

      if not _.isEqual a[prop], b[prop], callback, thisArg # todo: might not be needed: use base case
        if not isEqual a[prop], b[prop], callback, thisArg, options # 2nd chance: use isEqual instead as last resort!
          l.debug 'return false - not isEqual nested for prop =', prop, 'values = ', a[prop], b[prop] if l.debugLevel > 40
          return false

    l.debug 'return true - all properties considered true' if l.debugLevel > 40
    return true

  l.debug 'return false - nothing left to check!' if l.debugLevel > 40
  false

module.exports = isEqual