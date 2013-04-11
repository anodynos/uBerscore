# got from http://stackoverflow.com/questions/8024149/is-it-possible-to-get-the-non-enumerable-inherited-property-names-of-an-object
_ = require 'lodash'

getAllPropertyNames = (obj) ->
  props = []
  loop
    Object.getOwnPropertyNames(obj).forEach (prop) ->
      props.push prop  if props.indexOf(prop) is -1

    obj = Object.getPrototypeOf(obj)
    if (not obj) or _.isEmpty(obj) # eliminate empty {}, should be the terminal Object # todo:check assumption!
      break

  props

module.exports = getAllPropertyNames