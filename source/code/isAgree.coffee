###
  @param o {Anything} An Object, String, number etc that we check against fltr.

  @param fltr If its a RegExp, it `test`s against o (as string),
              If its a Function where its simply called with o as param
              Othewise _.isEqual is applied
###
define ['lodash'], (_)->
  (o, fltr)->
    if _.isRegExp fltr
      fltr.test (o + '')
    else
      if _.isFunction fltr
        fltr o
      else
        _.isEqual o, fltr