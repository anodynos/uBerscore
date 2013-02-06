###DEV ONLY ###
_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
#__isNode = true
###DEV ONLY ###


l = new (require './../Logger') 'Blender', 0

type = require '../type'
isPlain = require '../isPlain'
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
  defaultBBOrder = ['dst', 'src']       # `action` is stored in {dst:src} objects
  replaceRE: /\${\s*?_\s*?}/

  constructor:-> @_constructor.apply @, arguments

  ###

  @param benderBehaviors {Array<BlenderBehavior>}
         The blender behaviors with which to perform the blending.
         Precedence is left to right.
         If benderBehaviors arg is not [], then all args are assumed to be BBs.

  @param actions {Object} A hash of named actions that extend this Blender instance and can be used by your benderBehaviors.
                          They can overwrite built in ones.
                          You can simply call them (on @).
                          @/this is always bound to the Blender instance.
                          Note: If benderBehaviors arg is not [], then all args are assumed to be BBs, hence no `actions`!
                          Note: DONT overwrite `blend` or `_blend` !

  ###
  _constructor: (@blenderBehaviors, @actions)=>
    # also allow (blenderBehaviours...) style call with no actions
    if not _.isEmpty arguments  
      if (not _.isArray @blenderBehaviors)
        @actions = undefined
        @blenderBehaviors = [].slice.call arguments, 0 # all args are BBs

    @blenderBehaviors or= []

    if _.isObject @actions
      _.extend @, @actions
      _.bindAll @, _.keys @actions

    ###
      setup of @defaultBlenderBehaviors
    ###
    @defaultBlenderBehaviors = [ # defined in constructor, cause we want @ to refer to @ instance #@todo: refactor ?
      {
        "order": ['dst', 'src']
        "''":                         # destination (if destination is type 'Undefined')
          "''": 'overwriteOrReplace'   # source      (if source is type ANYTHING, will call @overwrite)

        "[]": # short: '[]'
          "[]": 'deepOverwrite'

          "Undefined": ->"-> []"

        "{}": # short for 'Object'.
          "{}": @deepOverwrite

        "*": "*": @overwriteOrReplace
      }
    ]

    # add default '*':"*" behaviour (@overwrite) to all destinations for the last BB
    lastDBB = _.last @defaultBlenderBehaviors
    for k, dbb of lastDBB
      if (not _.isArray dbb) and (_.isUndefined dbb["*"])
        dbb["*"] = lastDBB['*']['*'] # Anything placed at "*": "*" is default

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
    if _.isEmpty @currentPath #todo: (4 6 2) optimize with a @isRoot = true ?
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
          dst: type(dst[prop], true)
          src: type(src[prop], true)
        l.debug "Path -->:'/#{@currentPath.join('/')}' '#{types.src}' --> '#{types.dst}'"

        # go through @certainBlenderBehaviors, until an 'action' match is found.
        action = undefined
        for cbb, bbi in @certainBlenderBehaviors when (action is undefined)
          l.debug "trying order #{l.prettify (@blenderBehaviors[bbi].order or defaultBBOrder)}"
          for blendPart in (@blenderBehaviors[bbi].order or defaultBBOrder) # blendPart is either 'src' or 'dst'

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
    Actions: Predefined/built in actions
  ###

  # simply overwrites dst value with src value
  overwrite: (prop, src, dst)-> src[prop]

  # Overwrites a source value on top of destination,
  # but if sourceVal is a replaceRE holder, ->src[prop].replace @replaceRE, dst[prop]
  overwriteOrReplace: (prop, src, dst)->
    if _.isString(src[prop]) and @replaceRE.test(src[prop])
      if isPlain dst[prop]
        src[prop].replace @replaceRE, dst[prop]
      else
        # if our dest is not a 'isPlain' value (eg String, Number), eg {key: "${}"}-> {key: someNonPlainVal}
        # it means it can't 'accept' a replacement, but we are just holding its value
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
YADC = require('YouAreDaChef').YouAreDaChef
#
YADC(Blender)
  .before /overwriteOrReplace|deepOverwrite|overwrite/, (match, prop, src, dst)->
    l.debug """YADC:#{match} '/#{@currentPath.join('/')}' '#{type src[prop]}'-->'#{type dst[prop]}'
      src:
      #{l.prettify src[prop]}
      dst:
      #{l.prettify dst[prop]}
    """
#
#### inline tests ###
#
blender = new Blender([
    'order': ['src', 'dst'] # @todo: rename to ""flavor" ? "aroma"
    'Null': '*': -> 'MarkForRejection'
    '[]':
      "[]": (prop, src, dst)-> _.reject @deepOverwrite(prop, src, dst), (v)->v is 'MarkForRejection'
#      'Array': 'arrayToArrayPush'
      "{}": (prop, src, dst)-> @deepOverwrite(prop, src, dst)
  ,
    order: ['dst','src']
    "''":
      "[]": (prop, src, dst)-> """
        '#{dst[prop]}' - the following Array landed on preceding String!
                         #{(i for i in src[prop]).join '|'}
      """


]

#  ,printIt: (prop, src, dst)-> l.log "PRINTIT:", prop, src[prop], dst[prop]
#  ,
#    'Number':
#      'String': -> console.log 'Number<-String'
#    "*":
#      "*" : "Paparies"
)

result = blender.blend(
  {value: arr: [1,       2,        3,  4]},
  {value:
    arr: ["${_}",  null]
    arr2: [5, 6, a:"a"]
  }
)

#result = blender.blend(
#  "I am a String and...",
#  [11,22,33]
#)

l.log "result: \n", result
l.log _.isEqual result, {
  value:
    arr: [ 1, 3, 4 ]
    arr2: [5, 6, a:"a"]
}

l.log blender.blend(
          {
            foo:"foo"
            bar:
              name:"bar"
              price:20
          }
          ,
          {
            foo:null
            bar:
              price:null
          }
)

b = blender.blend(
  [100,     {id: 1234}, true, "foo", [250, 500]],
  ["${_}", "${_}", false, "${_}", "${_}"]
)

l.log b

