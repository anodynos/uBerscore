###DEV ONLY ###
_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
#__isNode = true
###DEV ONLY ###

Logger = require './../Logger'
l = new Logger 'Blender', 0

type = require '../type'
certain = require '../certain'
simpleMutateCertain = (o)-> certain o #ommit other params
mutate = require '../mutate'

bindAndCertain = require './bindAndCertain'
go = require '../go'

###
  A highly configurable variant of deepExtend / jQuery.extend / lodash.merge
  (as a poor man's B, since that's a bit far from now... ?)
###
class Blender

  knownTypes = ['Array', 'Arguments', 'Function', 'String', 'Number', 'Date', 'RegExp', 'Boolean', 'Null', 'Undefined', 'Object']
  defaultBlend = ['dst', 'src']       # `action` is stored in {dst:src} objects
  parentRE: /\${\s*?_\s*?}/

  constructor:-> @_constructor.apply @, arguments

  ###

  @param benderBehaviors {Array<BlenderBehavior>} The blender behaviors with which to perform the blending. Precedence is left to right.

  @param actions {Object} actions that extend this Blender instance, and can be used by your benderBehaviors.
                            They can overwrite built in ones, or call them. @ is always bound to the instance.

  @todo:(2 8 2) also allow (blenderBehaviours...) style call ? Where do we fit actions ?
  @todo:(1 6 3) make a curryable version ?
  ###
  _constructor: (@blenderBehaviors=[], @actions)=>

    ###
      setup of @defaultBlenderBehaviors
      #todo : (8 2 1) - make them an array, just like params
    ###
    @defaultBlenderBehaviors = [ # defined in constructor, cause we want @ to refer to @ instance #@todo: refactor ?
      {
        "String":                         # destination (if destination is type 'Undefined')
          "String": @overwriteOrReplace   # source      (if source is type ANYTHING, will call @overwrite)

          "Array": (prop, src, dst)-> """
            '#{dst[prop]}' - the following Array landed on preceding String!
            #{(i for i in src[prop]).join '|'}
          """

        "Array": # @todo: (7 8 2) synomym: '[]'.
  #        "Array": @arrayToArrayPush
          "Array": 'deepOverwrite'
  #        "Array": => # ommit nulls
  #          array = @deepOverwrite.apply(null, arguments)
  #          _.reject array, (v)->_.isNull v

          "Undefined": ->"-> []"

        "Object": # @todo: (7 8 2) synomym: '{}'.
          "Object": @deepOverwrite

        "*": "*": @overwriteOrReplace
      }
    ]

    # add default '*':"*" behaviour (@overwrite) to all destinations for the last BB
    lastDBB = _.last @defaultBlenderBehaviors
    for k, dbb of lastDBB
      if (not _.isArray dbb) and (_.isUndefined dbb["*"])
        dbb["*"] = lastDBB['*']['*']

    # treat them as normal blenderBehaviours: they go at the end, presenting the last resort
    @blenderBehaviors.push bb for bb in @defaultBlenderBehaviors

    # Create a @certainBlenderBehaviors that stands for each @blenderBehavior.
    # Ammendment are
    #   - all non-action/final properties become 'certain' functions
    #   - bind all 'actions' to to @Blender instance. Actions are all functions (or Strings that are Function names of @)
    @certainBlenderBehaviors = []
    for bb in @blenderBehaviors
      bb = _.clone bb, true # a deep clone
      @certainBlenderBehaviors.push bindAndCertain(bb, @)

    @currentPath = []

  # A cover to the "real" _blend, that takes the root objects into blendingBehaviour.
  # It recurses recurses root '$' path, to apply rules even on root objects (eg blend({}, [])
  # should NOT be used otherwise, only for roots!
  blend: (dst, sources...)=>
    if _.isEmpty @currentPath
      dstObject = {'$':dst}
      for src in sources
        @_blend dstObject, {'$':src}

      dstObject.$
    else
      @_blend.apply @, arguments

  # our real `blend` function
  _blend: (dst, sources...)=>
#    @currentPath.push '$' if _.isEmpty @currentPath
    for src in sources
      for own prop of src
        @currentPath.push prop
        types =  # just a shortcut
          dst: type(dst[prop])
          src: type(src[prop])
        l.debug "Path -->:'/#{@currentPath.join('/')}' '#{types.src}' --> '#{types.dst}'"

        # go through @certainBlenderBehaviors, until an 'action' match is found.
        action = undefined
        for cbb, bbi in @certainBlenderBehaviors when (action is undefined)
          l.debug "trying blendParts #{l.prettify (@blenderBehaviors[bbi].blend or defaultBlend)}"
          for blendPart in (@blenderBehaviors[bbi].blend or defaultBlend) # blendPart is either 'src' or 'dst'
            if _.isUndefined types[blendPart]
              throw """
                _.Blender.blend: Invalid blendPart #{blendPart}
              """
            else
              if not ((cbb is undefined) or (cbb.isAction is @)) # never call the action, just stop!
                cbb =  cbb types[blendPart] # `cbb('Array')`, returns another cbb or a final function
              else
                break

          if cbb is undefined
            continue
          else
            action = cbb

        # execute the action and retrieve its value
        val = action prop, src, dst  # assume _.isFunction action (and bind with @)

        # @question: Should mutation/assignment go on here ?
        #            Or allow only actions to mutate, and not return anything ?
        # @answer: NO, it breaks our filtering flow!

        if (val is undefined) and _.isObject(dst)
          delete dst[prop] # @todo: Can we move 'delete' behaviour to an action ?
                           #        Should make it optional & user configurable!
        else
          if val isnt @     # @todo: should we ALWAYS assign ?
            dst[prop] = val #        Can everything be expressed like this ?

        @currentPath.pop()
    dst

  ###
    predefined/built in actions
  ###

  # simply overwrites dst value with src value
  overwrite: (prop, src, dst)-> src[prop]

  # Overwrites a source value on top of destination,
  # but if sourceVal is a parentRE holder, it is replacing it using parentRE.
  overwriteOrReplace: (prop, src, dst)->
    if _.isString(src[prop]) and @parentRE.test(src[prop])
      if _.isString dst[prop]
        src[prop].replace @parentRE, dst[prop]
      else
        # if our dest is not a String, eg {key: someVal} <-- {key: "${}"}
        # it means it can't 'accept' a replacement,
        # but we are just holding its value:
        dst[prop]
    else
      src[prop] # simply overwrite

  deepOverwrite: (prop, src, dst)->
    @blend dst[prop], src[prop] #standard copy over

  #append source array to destination. All non-undefined items are pushed @ dst
  arrayToArrayPush: (prop, src, dst)->
    dst[prop].push s for s in src[prop] when s isnt undefined
    dst[prop] # return the appended array as the result

module.exports = Blender

#### DEBUG ###
#YADC = require('YouAreDaChef').YouAreDaChef
##
#YADC(Blender)
#  .before /overwriteOrReplace|deepOverwrite|overwrite/, (match, prop, src, dst)->
#    l.debug """YADC:#{match} '/#{@currentPath.join('/')}' '#{type src[prop]}'-->'#{type dst[prop]}'
#      src:
#      #{l.prettify src[prop]}
#      dst:
#      #{l.prettify dst[prop]}
#    """
#
#### inline tests ###
#
#blender = new Blender([
#    'blend': ['src', 'dst'] # @todo: rename to ""flavor" ? "aroma"
#    'Null': '*': -> 'MarkForRejection'
#    'Array':
#      "Array": (prop, src, dst)-> _.reject @deepOverwrite(prop, src, dst), (v)->v is 'MarkForRejection'
##      'Array': 'arrayToArrayPush'
#      "Object": (prop, src, dst)-> @deepOverwrite(prop, src, dst)
#,
#    'blend': ['dst','src']
#    "String": (prop, src, dst)-> @overwrite(prop, src, dst)
#
##  ,
##    'Number':
##      'String': -> console.log 'Number<-String'
##    "*":
##      "*" : "Paparies"
#])
#
#result = blender.blend(
#  {value: arr: [1,       2,        3,  4]},
#  {value:
#    arr: ["${_}",  null]
#    arr2: [5, 6, a:"a"]
#  }
#)
#
##result = blender.blend(
##  "I am a String and...",
##  [11,22,33]
##)
#
#l.log "result: \n", result
#l.log _.isEqual result, {
#  value:
#    arr: [ 1, 3, 4 ]
#    arr2: [5, 6, a:"a"]
#}

#l.log blender.blend(
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

#b = blender.blend(
#  [100,     {id: 1234}, true, "foo", [250, 500]],
#  ["${_}", "${_}", false, "${_}", "${_}"]
#)
#
#l.log b

