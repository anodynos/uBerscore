
_ = require 'lodash'
###
 Retrieve all properties of the object that are NOT their own.

  got from http://stackoverflow.com/questions/8024149/is-it-possible-to-get-the-non-enumerable-inherited-property-names-of-an-object
###
getInheritedPropertyNames = (obj) ->
  _getInheritedPropertyNames Object.getPrototypeOf(obj)
#  _.filter (prop for prop of obj when prop isnt 'constructor'), (v)-> v in ownKeys


_getInheritedPropertyNames = (obj) ->
  props = []

  loop # eliminate empty {}, undefined or empty objs with no proto's (terminal Object) # todo:check assumption!
    if (not obj) or (obj is undefined) or (_.isEmpty(obj) and not Object.getPrototypeOf(obj))
      break

    Object.getOwnPropertyNames(obj).forEach (prop) ->
      if (props.indexOf(prop) is -1) and prop not in ['constructor']
        props.push prop

    obj = Object.getPrototypeOf(obj)

  props

module.exports = getInheritedPropertyNames