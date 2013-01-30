_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !

l = console
prettify = (o)-> JSON.stringify o, null, ''

###
  Based conceptually on deepExtend.coffee, as a poor man's B, since that's a bit far from now...
###

type = require './type'
certain = require './certain'
mutate = require './mutate'
go = require './go'

knownTypes = ['Array', 'Arguments', 'Function', 'String', 'Number', 'Date', 'RegExp', 'Boolean', 'Null', 'Undefined', 'Object']

parentRE = /\${\s*?_\s*?}/

# candidate names:
# Blender / blend
# Unifier / unify
# Conflater / conflate
# Combiner /combine
# Mixer / mix (clashes with mixin ?)
# merge (clashes from lodash)
#
Blender = (extenderBehavior)->

  #actions:
  #  "replace" "overwrite" -> write source value on top of destination default
  #  "push" -> push (append) value at the array

  # overwrite or replace with parentRE
  overwrite = (src, dst, prop)->
#      console.log 'Overwriting:', "'#{prop}'", dst[prop], '<--', src[prop]
      if parentRE.test src[prop]
        if _.isString dst[prop]
          src[prop].replace parentRE, dst[prop]
        else
          dst[prop] # if our dest is not a String, eg {key: someVal} <-- {key: "${}"}
                    # it means it can't 'accept' a replacement,
                    # but we are just holding its value.

      else
        src[prop]

  deepOverwrite = (src, dst, prop)-> blend dst[prop], src[prop] #standard copy over

  arrayToArrayPush = (src, dst, prop)->  #push @ dst
                dst[prop].push s for s in src[prop]
                dst[prop]


  defaultBlenderBehavior = {
      "Undefined":
        "*": overwrite

      "String":
        "String": overwrite

        "Array": (src, dst, prop)-> """
            '#{dst[prop]}' - the following Array landed on preceding String!
            #{(i for i in src[prop]).join '|'}
            """

        "Number": overwrite

        "*": overwrite

      "Array":
#        "Array": arrayToArrayPush
        "Array": -> # ommit nulls
          array = deepOverwrite.apply(null, arguments)
          _.reject array, (v)->_.isNull v

        "Undefined": -> []
        "*": overwrite

      "Object":
        "Object": deepOverwrite
        "*": overwrite

      "*":
        "*": overwrite
  }

#  _.each defaultBlenderBehavior, (dstType)-> dstType['Null'] = -> #'_B_blendSkip' # skip nulls for all destinations!

#  console.log defaultBlenderBehavior.String.Null.toString()


  blenderBehavior = defaultBlenderBehavior unless blenderBehavior
  certainExtenderBehavior = certain (mutate blenderBehavior, certain)

  blend = (dst, sources...) ->
    for src in sources
      for own prop of src
        srcType = type src[prop]
        dstType = type dst[prop]

        action = certainExtenderBehavior(dstType) srcType
#        l.log "##########", dstType, '<--', srcType

        # @todo : no mutation/assignment should go on here!
        # Only actions should mutata, and not return anything!
        val = action src, dst, prop
        if (val is null) and (_.isPlainObject dst)
          delete dst[prop]
        else
          dst[prop] = val

    dst

  blend # our `blend` function

module.exports = Blender

#blend = Blender()
#
#console.log prettify blend(
##          {arr: [1,       2,        3,  4]},
##          {arr: ["${_}",  null]}
#          {arr: [10,       20,        30,  40]},
#          {arr: ["${_}",  null, 35, 45, 55]}
#)
#
#console.log prettify blend(
#          {
#            foo:"foo"
#            bar:
#              name:"bar"
#              price:20
#          }
#          ,
#          {
#            foo:null
#            bar:
#              price:null
#          }
#)