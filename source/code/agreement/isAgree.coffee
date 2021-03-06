###
  @param o {Anything} An Object, String, number etc that we check against agreement.

  @param agreement
    If its a RegExp, it `test`s against o (@todo: assuming string, what if it not ?),

    If its a Function where its simply called with o as param

    Undefined returns true! You can't disagree with an agreement that isn't defined!

    Othewise _.isEqual is applied
  @todo: refactor with Blender that decides what is compared to what, and is extendible!
###

define ->

  (o, agreement)->
    if _.isRegExp agreement
      agreement.test (o + '')
    else
      if _.isFunction agreement
        agreement o
      else
        if agreement is undefined #Undefined returns true! You can't disagree with what isn't defined!
          true
        else
          if _.isEqual o, agreement
            true
          else
            (o + '') is (agreement + '') # convert both to Strings and compare

