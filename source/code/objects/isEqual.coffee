###
  Just like _.isEqual BUT with more options :

  *  inherited: false # if true, examine all (inherited) properties, not just *own*

  *  exact: false # if true, then all refs must point to the same objects, not loolkalike clones!

  *  like: false # if true, check only if 1st arg's are isEqual with the 2nd's, even if the 2nd has more properties to it

  *  path: undefined # path: pass an Array, populated with key/index as objects/arrays are traversed - usefull for debuging!

  *  exclude: []<String  # keys to be excluded
      # todo: NOT IMPLEMNTED: Function, called with (key, val, ??) excludes true returns

  *  allProps: false # if true, all props are considered for all Object types (eg Array props but also String, Number etc)

  *  onlyProps: false # if true, equality only cares about properties, NOT values OR types of function, Number, Boolean etc
                      # forces allProps behavior on all types (incl Arrays)

  The `options` object can be passed as the 5th parameter (to maintain compatibility with *lodash*),
  but also as the 3rd, in place of callback.

  In all cases you can pass `callback` and `ctx` as properties of `options`,
  which will have precedence over the respective arguments.

  @todo: integrate docs with defaults definition below

  @todo: remove dependency from 'lodash' callback, allowing underscore to work the exact same way.

###
type = require 'types/type'
isPlain = require 'types/isPlain'
isHash = require 'types/isHash'
isEqualArraySet = require '../collections/array/isEqualArraySet'
l = new (require '../Logger') 'uberscore/isEqual'

isEqual = (a, b, callback, ctx, options=isEqual.defaults)->
  # options handling - might be in callback's place
  # if callback is actually the options object, destructure it
  if isHash(callback)
    options = _.defaults callback, options
  if options isnt isEqual.defaults
    _.defaults (options or= {}), isEqual.defaults

  callback = options.callback if options.callback
  ctx = options.ctx if options.ctx

  # handle callback irrespective of other options
  if _.isFunction(callback)
    if not callback.optioned
      cb = callback
      callback = (a,b)-> cb.call this, a, b, options
      callback.optioned = true
      options.callback = callback if options.callback
    cbResult = callback.call ctx, a, b # @todo we could pass options, but need to be consistent with lodash's cb
    if cbResult isnt undefined # respect only non-undefined as truthy or falsey
      return (if cbResult then true else false)
  else
    callback = undefined # lodash doesnt like non-function callbacks!
    options.callback = undefined

  l.deb 'options = ', options if l.deb 20

  # Lets eliminate some rudimentary cases
  if a is b
    l.deb 'return true - a is b' if l.deb 40
    return true

  return a.isEqual b if _.isFunction a?.isEqual
  return b.isEqual a if _.isFunction b?.isEqual

  # if we aren't using any _B options, then _.isEqual is enough
  if (_.isEqual isEqual.defaults, (_.pick options, _.keys isEqual.defaults))
    l.deb "return _.isEqual a, b - no _B.isEqual options" if l.deb 40
    return  _.isEqual a, b, callback, ctx # @todo: needed ? callback was handled before

  # check equality of value types, if we dont just care about
  # `onlyProps` with both a & b being 'Objects' (even `new Boolean` or `new Number` etc)
  # onlyProps & like: ignores value & lack of a's props
  if not (options.onlyProps and _.isObject(b) and (_.isObject(a) or options.like))

    if type(a) isnt type(b) # types returns the real type, eg type(new Number) is 'Number'
      l.deb 'return false - type(a) isnt type(b) and not options.onlyProps' if l.deb 40
      return false

    isValueType = (x)-> isPlain(x) or _.isFunction(x) # (function is considered a value)
    if isValueType(a) or isValueType(b)
      if not _.isEqual a, b, callback, ctx
        return false
      else
        return true if not (options.allProps) # true is not enough - we need to check props

  # if we've passed this point, it means we care
  # about properties about any type (even plain)
  # or we have some nested type ({} or [])
  aKeys = getProps a, options
  bKeys = getProps b, options

  if not options.like
    if (aKeys.length isnt bKeys.length) or     # quickly return false for
       (not isEqualArraySet aKeys, bKeys)      # different set of keys
          if _.isArray(options.path)
            if not (key = _.difference(aKeys, bKeys)[0]) # both ways with _.difference
              key = _.difference(bKeys, aKeys)[0]
            options.path.push key
          return false

  for prop in aKeys # xKeys are equal
    options.path.push prop if _.isArray options.path

    if options.exact
      if a[prop] isnt b[prop] # `exact` equality required for nested props
        l.deb 'return false - exact ref not same' if l.deb 40
        return false

    if not isEqual a[prop], b[prop], callback, ctx, options # 2nd chance: use isEqual instead as last resort!
      l.deb 'return false - not isEqual nested for prop =', prop, 'values = ', a[prop], b[prop] if l.deb 40
      return false

    options.path.pop() if _.isArray options.path

  l.deb 'return true - all properties considered true' if l.deb 40
  return true

isEqual.defaults =
  inherited: false # if true, examine all (inherited) properties, not just *own*

  exact: false # if true, then all refs must point to the same objects, not loolkalike clones!

  like: false # if true, check only if 1st arg's are isEqual with the 2nd's, even if the 2nd has more properties to it

  path: undefined # path: pass an Array, populated with key/index as objects/arrays are traversed - usefull for debuging!

  exclude: [] # keys to be excluded - <String> of excluded key names.
              # todo: NOT IMPLEMENTED: Array<String> & a Function, then its called with (key, val, ??) that excludes calls returning true

  allProps: false # if true, all props are considered for all Object types (eg Array props but also String, Number etc)

  onlyProps: false # if true, equality only cares about properties, NOT values OR types of function, Number, Boolean etc
                   # forces allProps behavior on all types (incl Arrays)

getProps = (oa, options={})->
  isExcluded = (prop)-> _.some options.exclude, (p)->p+'' is prop+'' # allows to check for 3 or '3'

  if _.isArray(oa) and not (options.allProps or options.onlyProps)
    i for i in [0...oa.length] when not isExcluded i
  else
    pi for pi of oa when (not isExcluded pi) and
      (options.inherited or {}.hasOwnProperty.call(oa, pi))

module.exports = isEqual
