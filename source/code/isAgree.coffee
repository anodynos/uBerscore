###
  @param o {Anything} An Object, String, number etc that we check against fltr.

  @param fltr If its a RegExp, it `test`s against o (as string),

              If its a Function where its simply called with o as param

              Undefined returns true! You can't disagree with what isn't defined!

              Othewise _.isEqual is applied
###
# The dependency is NOT NEEDED any more, cause we have it as bundle export.
# But leave it here to illustrate Bundle Dependency injection respects existing parameters!
define ['lodash'], (_)->
#_ = require 'lodash'
#module.exports =
  (o, fltr)->
    if _.isRegExp fltr
      fltr.test (o + '')
    else
      if _.isFunction fltr
        fltr o
      else
        if fltr is undefined
          true
        else
          _.isEqual o, fltr