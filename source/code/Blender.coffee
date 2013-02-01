###DEV ONLY ###
_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
__isNode = true
###DEV ONLY ###

#@ todo: (4 3 3) Move this to uLogger (from uRequire's Logger)
l = console.log
prettify =
  do (inspect = require('util').inspect)->
  #do (inspect = require('./inspect'))->
    if __isNode
      (o)->
        pretty = "\u001b[0m#{(inspect o, false, null, true)}"
        if _.isArray o
          pretty.replace /\n/g, ''
        else
          pretty
    else
      (o)->
        JSON.stringify o, null, ''

p = prettify
lp = _.compose l,p

###
  Based conceptually on deepExtend.coffee,
  (as a poor man's B, since that's a bit far from now... ?)
###

type = require './type'
certain = require('./certain')
simpleMutateCertain = (o)-> certain o #ommit other params
mutate = require './mutate'
go = require './go'
deepExtend = require './deepExtend'


# Blender / blend

class Blender
  knownTypes = ['Array', 'Arguments', 'Function', 'String', 'Number', 'Date', 'RegExp', 'Boolean', 'Null', 'Undefined', 'Object']
  defaultBlend = ['dst', 'src']       # `action` is stored in {dst:src} objects
  parentRE = /\${\s*?_\s*?}/

  constructor:-> @_constructor.apply @, arguments

  ###


  @param benderBehaviors {Array<BlenderBehavior>} The blender behaviors with which to perform the blending. Precedence is left to right.

  @param actions {Object} actions that extend this Blender instance, and can be used by your benderBehaviors.
                            They can overwrite built in ones, or call them. @ is always bound to the instance.

  @todo:(2 8 2) also allow (blenderBehaviours...) style call ?
  @todo:(1 6 3) make a curryable version ?
  ###
  _constructor: (@blenderBehaviors, @actions)=>

    ###
      setup of @defaultBlenderBehavior
    ###
    @defaultBlenderBehavior =           # defined in constructor, cause we want @ to refer to @ instance
      "String":                         # destination (if destination is type 'Undefined')
        "String": @overwriteOrReplace   # source      (if source is type ANYTHING, will call @overwrite)

        "Array": (prop, src, dst)-> """
          '#{dst[prop]}' - the following Array landed on preceding String!
          #{(i for i in src[prop]).join '|'}
        """

      "Array":
#        "Array": @arrayToArrayPush
        "Array": 'deepOverwrite'
#        "Array": => # ommit nulls
#          array = @deepOverwrite.apply(null, arguments)
#          _.reject array, (v)->_.isNull v

        "Undefined": "-> []"

      "Object":
        "Object": @deepOverwrite

      "*": "*": @overwriteOrReplace

    #_.each @blenderBehavior, (dstType)->
        #   dstType['Null'] = -> #skip nulls for all destinations '_B_blendSkip' !

    # Finally, add default '*':"*" behaviour (@overwrite) to all destinations as default
    mutate @defaultBlenderBehavior,
      (v,k,oa)=>
        if _.isUndefined(v["*"]) and k isnt 'blend'
          v["*"] = @defaultBlenderBehavior['*']['*']
        v


    # Create a @certainBlenderBehaviors that stands for @blenderBehavior.
    # Ammendment is that all non-action/final properties become 'certain' functions
    # that being passed a key, if key is found; they return value else default value (keyed as '*')
    @certainBlenderBehaviors = []
    for bb in @blenderBehaviors
      bb = _.clone bb, true # a deep clone

      # first bind all actions to this Blender instance
      # @todo: (5 7 3) do for all levels, not just `dst:src` / `src:dst`, but also for `src:dst:jpath` or simply src etc.
      for dstTypeKey, dstTypeHash of bb                  #eg 'String' as a destination category
        for srcTypeKey, srcTypeAction of dstTypeHash     #eg 'Array' as a source action
  #        if dstTypeKey is 'Number' and srcTypeKey is 'Function'
  #          console.log dstTypeHash[srcTypeKey].toString()
  #        if dstTypeKey is 'Array' and srcTypeKey is 'Array'
  #          console.log dstTypeHash[srcTypeKey].toString()
          if _.isFunction srcTypeAction
            dstTypeHash[srcTypeKey] = _.bind srcTypeAction, @

      @certainBlenderBehaviors.push(
        simpleMutateCertain(
          mutate(bb, simpleMutateCertain) #, (v)->not _.isArray(v))
        )
      )#todo: dont mutate, map!
    lp @certainBlenderBehaviors

    #add defaults as the last BB
    @blenderBehaviors.push @defaultBlenderBehavior
    @certainBlenderBehaviors.push( simpleMutateCertain (mutate @defaultBlenderBehavior, simpleMutateCertain) )

    @currentPath = []

  # our `blend` function
  blend: (dst, sources...)->
    for src in sources
      for own prop of src
        @currentPath.push prop
        types = {dst: type(dst[prop]), src: type(src[prop])} # just a shortcut
#        l "\n currentPath:'/#{@currentPath.join('/')}' '#{types.dst} <-- #{types.src}'"

        # go through @certainBlenderBehaviors, until an 'action' match is found.
        action = undefined
        for cbb, bbi in @certainBlenderBehaviors when (action is undefined)
          #l "trying blendParts #{p (@blenderBehaviors[bbi].blend or defaultBlend)}"
          for blendPart in (@blenderBehaviors[bbi].blend or defaultBlend) # blendPart is either 'src' or 'dst'
            if (cbb is undefined)
              break
            else
              cbb =  cbb types[blendPart]                                 # `cbb('Array')`, returns another cbb @todo:invalid blendPart?

          if cbb is undefined
            continue
          else
            action = cbb

        # @todo : no mutation/assignment should go on here!
        # should only actions mutate, and not return anything ?
        if _.isString action
          action = @[action] #get the action-function by that name!

        if not _.isFunction action
          throw "Wrong action: #{p action}"

        val = action prop, src, dst

        if (val is null) and _.isPlainObject(dst)
          delete dst[prop]
        else
          dst[prop] = val

        @currentPath.pop()
    dst

  ###
    predefined/built in actions
  ###

  # simply overwrites dst value with src value
  overwrite: (prop, src, dst)=> src[prop]

  # Overwrites a source value on top of destination,
  # but if sourceVal is a parentRE holder, it is replacing it using parentRE.
  overwriteOrReplace: (prop, src, dst)=>
    if _.isString(src[prop]) and parentRE.test(src[prop])
      if _.isString dst[prop]
        src[prop].replace parentRE, dst[prop]
      else
        # if our dest is not a String, eg {key: someVal} <-- {key: "${}"}
        # it means it can't 'accept' a replacement,
        # but we are just holding its value.
        dst[prop]
    else
      src[prop]# simply overwrite

  deepOverwrite: (prop, src, dst)=>
    @blend dst[prop], src[prop] #standard copy over

  #append source array to destination. All non-undefined items are pushed @ dst
  arrayToArrayPush: (prop, src, dst)->
    dst[prop].push s for s in src[prop] when s isnt undefined
    dst[prop]

module.exports = Blender

#### DEBUG ###
YADC = require('YouAreDaChef').YouAreDaChef
#
YADC(Blender)
  .before /overwriteOrReplace|deepOverwrite|overwrite/, (match, prop, src, dst)->
    l """YADC:#{match} '/#{@currentPath.join('/')}' '#{type src[prop]}'-->'#{type dst[prop]}'
         src: #{p src[prop]}
         dst: #{p dst[prop]}
      """

blender = new Blender([
#    'blend': ['src', 'dst'] # @todo: rename to ""flavor" ? "aroma"
    'Array':
      "Array": Blender::deepOverwrite
#      '*': 'overwriteOrReplace'
#  ,
#    'Number':
#      'String': -> console.log 'Number<-String'
#    "*":
#      "*" : "Paparies"
])
l "Result:", p blender.blend(
#          {arr: [1,       2,        3,  4]},
#          {arr: ["${_}",  null]}
          {arr: [10,        20,    30,   40,     50]},

          {arr: ["${_}",  null,    35,   45,  -> 55]}

)

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

