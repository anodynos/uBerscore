#_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !

###
  Places item in a new array, if its not already an array.
  @return Array If item not already an Array, it becomes an item of an array.
                If its null or undefined, empty array is returned (to prevent loops)
  @param item <anything> item to place in a (new) array, if its not already.
###
define ['./agreement/isAgree'], (isAgree)->
  (item, fltr)->
    if isAgree item, fltr
      if _.isArray item
        item
      else
        if _.isUndefined(item) or _.isNull(item)
          []
        else
          [item]
    else
      item
