module.exports =
  order: ['src', 'dst']

  '|':
    String:'*':'overwriteOrReplace'

    Array:
      '[]': (prop, src, dst, blender)-> # Filter null / undefined. (note `type.areEqual('[]', 'Array') is true`)
              _.reject blender.deepOverwrite(prop, src, dst, blender), (v)-> v in [null, undefined]

      '*': (prop, src, dst)->
          throw """
            deepExtend: Error: Trying to combine an array with a non-array.

            Property: #{prop}
            destination[prop]: #{l.prettify dst[prop]}
            source[prop]: #{l.prettify src[prop]}
          """

    Object:
      '{}': (prop, src, dst, blender)-> # Delete null / undefined (note `type.areEqual('{}', 'Object') is true`)
              for key, val of deepBlended = blender.getAction('deepOverwrite')(prop, src, dst, blender)
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

