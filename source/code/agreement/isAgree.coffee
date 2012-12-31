###
  @param o {Anything} An Object, String, number etc that we check against fltr.

  @param fltr If its a RegExp, it `test`s against o (as string),

              If its a Function where its simply called with o as param

              Undefined returns true! You can't disagree with what isn't defined!

              Othewise _.isEqual is applied
###
# The 'lodash' dependency is NOT NEEDED any more, cause we have it as bundle export.
# But leave it to illustrate Bundle Dependency injection respects existing parameters as injected variable names
define ['lodash'], (_)->
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
          if _.isEqual o, fltr
            true
          else
            (o + '') is (fltr + '') # convert both to Strings