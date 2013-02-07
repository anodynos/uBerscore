###DEV ONLY ###
_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
#__isNode = true
debugLevel =  0
###DEV ONLY ###

l = new (require './../Logger') 'Blender', if debugLevel? then debugLevel else 0

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

  defaultBBOrder = ['src', 'dst']       # `action` is stored in {dst:src} objects

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
      _.bindAll @ # binds Funtions only

#    # YADC cant advice instance https://github.com/raganwald/YouAreDaChef/issues/18
#    if true #or l.debugLevel > 50
#      YADC = require('YouAreDaChef').YouAreDaChef
#      YADC(Blender)
#        .before /overwriteOrReplace|deepOverwrite|overwrite/, (match, prop, src, dst)->
#          l.debug """
#            YADC:#{match} '#{@currentPath.join('/')}' '#{type dst[prop]}' <--  '#{type src[prop]}'
#            #{l.prettify src[prop]}  <--  #{l.prettify dst[prop]}
#          """
    ###
      setup of @defaultBlenderBehaviors
    ###
    @defaultBlenderBehaviors or= [] # use the existing ones if they're set in some SubClass
    @defaultBlenderBehaviors.push {
        order: ['src', 'dst']

        Array:
          A: 'deepOverwrite' # 'A' is short for 'Array' (as also is '[]').
          '{}': 'deepOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')

        Object:
          O: 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
          '[]': 'deepOverwrite'

        #'Function' # Aren't Functions Objects ?
                    # How do we copy them ? They aren't just properties !

        "*": "*": 'overwrite'
    }

    # add default '*':"*" behaviour (@overwrite) to all destinations for the last BB
    lastDBB = _.last @defaultBlenderBehaviors
    for k, dbb of lastDBB
      if (not _.isArray dbb) and (_.isUndefined dbb["*"])
        dbb["*"] = lastDBB['*']['*'] # Anything placed at "*": "*" of lastDBB is default

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
    for src in sources
      for own prop of src
        @currentPath.push prop
        types =  # just a shortcut
          dst: type(dst[prop], true) # get short version of type, thats how we always handle it internally
          src: type(src[prop], true)

        # go through @certainBlenderBehaviors, until an 'action' match is found.
        visitNextBB = true
        for cbb, bbi in @certainBlenderBehaviors when visitNextBB
#          l.debug 20, "Trying #{if bbi+1 < @blenderBehaviors.length then '' else 'Default'} BlenderBehaviour ##{bbi}, with order #{l.prettify (@blenderBehaviors[bbi].order or defaultBBOrder)}"
          for bbOrder in (@blenderBehaviors[bbi].order or defaultBBOrder) # bbOrder is either 'src' or 'dst' @todo: or 'path'

            if _.isUndefined types[bbOrder]
              throw l.err  """
                _.Blender.blend: Error: Invalid BlenderBehaviour `order` '#{bbOrder}',
                while reading BlenderBehaviour ##{bbi} :\n""", @blenderBehaviors[bbi],
                "\n\nDefault BlenderBehaviour order is ", defaultBBOrder
                
            else
              if not ((cbb is undefined) or (cbb.isAction is @)) # never call undefined /Action, just stop!
                cbb =  cbb types[bbOrder]   # `cbb('Array')`, returns either another cbb or an Action (or undefined)
              else
                break

          if cbb is undefined
            continue
          else
            action = cbb

          # execute the action and retrieve the ActionResult (value or otrherwise)
          result = action prop, src, dst  # assume _.isFunction action (and bind with @)

          # Action() result handling
          visitNextBB = false # Optimistic - it always assumes we're finished with this value!
          if not (result in [@SKIP, @NEXT, @DELETE, @DELETE_NEXT])

            # we have a real value and a possible assignment

            if _.isArray(result) and (result[0] is @NEXT) # [@NEXT value] Action result format
              result = result[1]
              visitNextBB = true

#            l.debug 50, """
#              Value assigning, Path='#{@currentPath.join '/'}'
#              value = #{(l.prettify(result)+'').replace(/,\n\s*/g,', ')[0..150]}...
#            """
            dst[prop] = result # actually assign, by default all values

          else # we have some special ActionResult:
#            l.debug 50, "#{l.prettify result}"
            if result in [@DELETE, @DELETE_NEXT]
              delete dst[prop]
#              l.debug 70, "DELETEd prop = #{l.prettify prop}"

            if result in [@NEXT, @DELETE_NEXT]
#              l.debug 60, "Going to next BlenderBehaviour"
              visitNextBB = true

        @currentPath.pop()
    dst

  ###
  **Action() result handling**: How to process the decision (result) of an Action() call.

  An Action call returns either a _real value_ OR a special `ActionResult` singleton.

   - If its a "value",
    - its assigned to `dst[prop]`, by default. But this can change.
    - The property is considered as processed/finished.

   - If its an `ActionResult` its processed as follows....
  ###

  ###
  SKIP variable assignement resulted from Action call .
  Handling of this property is considered finished.
  ###
  SKIP: {ActionResult: "SKIP"}

  ###
  Go to NEXT BlenderBehavior in line, this one did (or didnt) do its work.
  The next BB in line must now take Action.

  - If its used alone, it also SKIPs assignment, cause NEXT is not a value!

  - If you also want to assign, use the as return [@NEXT, value]
    It assigns `value` to `dst[prop]` and then goes to the NEXT BlenderBehavior in line
  ###
  NEXT: {ActionResult: "NEXT"}

  ###
  DELETE the `dst[prop]`. Can be done in Action, but why not doit by contract ?
  ###
  DELETE: {ActionResult: "DELETE"}

  ###
  DELETE_NEXT - Like @DELETE, but also skip to next BlenderBehaviour in line.
  ###
  DELETE_NEXT: {ActionResult: "DELETE_NEXT"}


  ###
  Actions: Predefined/built in actions.

  You can define you own Acxtions when you create a Blender instance.
  ###

  ### Simply overwrites dst value with src value ###
  overwrite: (prop, src, dst)-> src[prop]



  ### Copy all properties of nested Objects (or Arrays) recursivelly. ###
  deepOverwrite: (prop, src, dst)->
    @blend dst[prop], src[prop] # @todo: try @_blend ?

  ###
  Append source array to destination.
  All non-undefined items are pushed @ dst
  ###
  arrayAppend: (prop, src, dst)->
    dst[prop].push s for s in src[prop]
    dst[prop] # return the appended array as the result

module.exports = Blender

#### DEBUG ###
YADC = require('YouAreDaChef').YouAreDaChef

YADC(Blender)
  .before /overwriteOrReplace|deepOverwrite|overwrite|print/, (match, prop, src, dst)->
    l.debug """
     YADC:#{match}
     '#{type dst[prop]}'    <--  '#{type src[prop]}'   /#{@currentPath.join('/')}
    """, dst[prop],'    <--  ', src[prop]


