#Blender = require '../Blender'
#if true
define ['../Blender'], (Blender)->

  l = new (require '../../Logger') 'uberscore/DeepExtendBlender'

  ###
   uBerscore adaptation of deepExtend, by [Kurt Milam](https://gist.github.com/1868955)

   Its mainly a demonstration of uBerscore's _B.Blender abilities.
   It can be easily further extended is you desire.

   It passes deepExtend's tests.

  # Changes/extra features
  # - extra: allow lodash'es 'shadowed' variables
  # - change: ${} instead of #{} in parentRE, cause it conflicts with Coffeescript!
  # - null _deletes_ object key, as well as array item
  # - copying Function over Object should replace it first

  @see /blending/deepExtend

  #todo: not working with Blender API for read/write/createAs/properties
  ###

  class DeepExtendBlender extends Blender

    @behavior:
      order: ['src', 'dst']

      String: '*': 'overwriteOrReplace'

      '[]':
        '[]': (prop, src, dst)-> # Filter null / undefined. (note `type.areEqual('[]', 'Array') is true`)
                _.reject @deepOverwrite(prop, src, dst), (v)-> v in [null, undefined]

        '*': (prop, src, dst)->
            throw """
              deepExtend: Error: Trying to combine an array with a non-array.

              Property: #{prop}
              destination[prop]: #{l.prettify dst[prop]}
              source[prop]: #{l.prettify src[prop]}
            """

      '{}':
        '{}': (prop, src, dst)-> # Delete null / undefined (note `type.areEqual('{}', 'Object') is true`)
                for key, val of deepBlended = @getAction('deepOverwrite')(prop, src, dst)
                  if (val is null) or (val is undefined)
                    delete deepBlended[key]
                deepBlended

        '*': (prop, src, dst)->
              throw """
                deepExtend: Error trying to combine a PlainObject with a non-PlainObject.

                Property: #{prop}
                destination[prop]: #{l.prettify dst[prop]}
                source[prop]: #{l.prettify src[prop]}
              """

      # Actions - local to this blenderBehavior
      ###
      Overwrites a source value on top of destination,
      but if sourceVal is a replaceRE holder,
      it _mainly_ returns `src[prop].replace @replaceRE, dst[prop]`
      ###
      overwriteOrReplace: (prop, src, dst)->
        replaceRE = /\${\s*?_\s*?}/ # it becomes a @ member of Blender instance

        if _.isString(src[prop]) and replaceRE.test(src[prop])
          if _.isString dst[prop]
            src[prop].replace replaceRE, dst[prop]
          else
            # if our dest is not a 'isPlain' value (eg String, Number), eg {key: "${}"}-> {key: someNonPlainVal}
            # it means it can't 'accept' a replacement, but we are just holding its value
            dst[prop]
        else
          src[prop] # simply overwrite