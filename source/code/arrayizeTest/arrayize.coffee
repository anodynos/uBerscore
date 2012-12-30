#_ = require 'lodash' # not need anymore, we have it as a Bundle Dependency!
define ['../agreeTest/isAgree'], (isAgree)->
  ###
    @return Array If item not already an Array, it becomes an item of an array.
                  If its null or undefined, empty array is returned (to prevent loops)
  ###
  #  module.exports =
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
