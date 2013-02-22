###DEV ONLY ###
_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
#__isNode = true
debugLevel =  100
###DEV ONLY ###

l = new (require './../Logger') 'Blender', if debugLevel? then debugLevel else 0
type = require '../type'

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
  _constructor: (@blenderBehaviors...)=>

    (@defaultBlenderBehaviors or= []).push {
        # @todo: use the existing ones if they're set in some SubClass ?
        order: ['src', 'dst']

        '|': # our src <--> dst spec
          Array:
            A: 'deepOverwrite' # 'A' is short for 'Array' (as also is '[]').
            '{}': 'deepOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')

          Object:
            O: 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
            '[]': 'deepOverwrite'

          #'Function' # Aren't Functions Objects ?
                      # How do we copy them ?
                      # They aren't just properties - how do you clone a function ?

          "*": "*": 'overwrite'
    }


    lastDBB = _.last @defaultBlenderBehaviors
    # add defaultAction to all destinations for the last BB
    for typeName, dbb of lastDBB['|'] # when type.isType(typeName) # assumed
      if (_.isUndefined dbb["*"])
        dbb["*"] = lastDBB['|']['*']['*'] # Anything placed at '|':'*':'*' of lastDBB is default
    # treat defaulBBs as normal blenderBehaviours:
    # they just go at the end, being the last resort
    @blenderBehaviors.push bb for bb in @defaultBlenderBehaviors
    # shortify 'em
    @blenderBehaviors[bbi]['|'] = Blender.shortifyTypeNames bb['|'] for bb, bbi in @blenderBehaviors
    @path = []

  # Recursivelly convert all isType(keys) to `type.short` format
  # i.e it changes all nested keys named 'Array', 'Object' etc to '[]', '{}' etc
  # Blender always use short format internally
  @shortifyTypeNames: (bbSrcDstSpec)->
    for key, val of bbSrcDstSpec when type.isType(key) # ignore non-types (eg blendBehavior.order & actions)
      short = type.toShort key
      if short and (key isnt short)
        bbSrcDstSpec[short] = bbSrcDstSpec[key]
        delete bbSrcDstSpec[key]
      if _.isPlainObject(val) #recurse
        Blender.shortifyTypeNames val

    bbSrcDstSpec

  # Find the actionName as Function and return it.
  # Starts looking in BlenderBehaviours preceding currentBlenderBehaviour, and Blender it self as last resort
  # throws error if no action Function is found in any of those
  #
  # @param {String} actionName name of the action, eg 'deepOverwrite'
  # @return {Function} The first action Function found
  getAction: (actionName, belowBlenderBehaviorIndex = @currentBlenderBehaviorIndex)=>
    for bb, bbi in @blenderBehaviors when bbi >= belowBlenderBehaviorIndex
      if _.isFunction bb[actionName]
        return bb[actionName]

    # last resort, check this blender instance
    if _.isFunction @[actionName]
      return @[actionName]
    else
      throw l.err "_B.Blender.blend: Error: Invalid BlenderBehaviour `actionName` = ", actionName,
                " - no Function by that name is found in a preceding BlenderBehaviour or Blender it self.",
                " belowBlenderBehaviorIndex=#{belowBlenderBehaviorIndex}",
                " @currentBlenderBehaviorIndex=#{@currentBlenderBehaviorIndex}",
                " @blenderBehaviors=", @blenderBehaviors

  # A cover to the "real" _blend, that takes the root objects into blendingBehaviour.
  # It recurses recurses root '$' path, to apply rules even on root objects (eg blend({}, [])
  # A waste of isEmpty otherwise, only used for root!
  blend: (dst, sources...)=>
    if _.isEmpty @path #todo: (4 6 2) optimize with a @isRoot = true ?
      dstObject = {'$':dst}
      @dstRoot = dst
      for src in sources
        @srcRoot = src
        @_blend dstObject, {'$':src}

      dstObject.$
    else
      @_blend.apply @, arguments

  # our real `blend` function
  _blend: (dst, sources...)=>
    for src in sources
      for own prop of src
        @path.push prop
        types =  # just a shortcut: `scr:'[]', dst: '{}'`
          dst: type(dst[prop], true) # get short version of type, thats how we always handle it internally
          src: type(src[prop], true)
          #path: ? if path

        # go through @certainBlenderBehaviors, until an 'action' match is found.
        visitNextBB = true
        for bb, bbi in @blenderBehaviors when visitNextBB
          nextBBSrcDstSpec = bb['|']
          for bbOrder in (bb.order or defaultBBOrder) # bbOrder is either 'src' or 'dst' @todo: or 'path'

            if _.isUndefined types[bbOrder]
              #@todo: check for path
              throw l.err  """
                _.Blender.blend: Error: Invalid BlenderBehaviour `order` '#{bbOrder}',
                while reading BlenderBehaviour ##{bbi} :\n""", @blenderBehaviors[bbi],
                "\n\nDefault BlenderBehaviour order is ", defaultBBOrder
                # Invlaid type is excluded as a case
            else
              l.debug "Looking @ bbi=#{bbi}", " bbOrder=", bbOrder, ' types[bbOrder]=', types[bbOrder], ' nextBBSrcDstSpec=', nextBBSrcDstSpec
              nextBBSrcDstSpec = nextBBSrcDstSpec[types[bbOrder]] or nextBBSrcDstSpec['*'] # eg `bb = bb['[]']` to give us the bb descr for '[]', if any. Otherwise use default '*'
              l.debug 'Found nextBBSrcDstSpec', nextBBSrcDstSpec

            if (nextBBSrcDstSpec is undefined) or
               (not _.isObject nextBBSrcDstSpec ) or
                _.isString nextBBSrcDstSpec
              break

          if nextBBSrcDstSpec is undefined
            continue # go to next bb
          else
            action = nextBBSrcDstSpec # found an action (candidate)

            if not _.isFunction action
              if not _.isString action
                throw l.err  """
                  _B.Blender.blend: Error: Invalid BlenderBehaviour `action` (neither 'Function' nor 'String') : """, action
              else # try to find the actionName (String) as an existing Function.
                action = @getAction action, bbi # throws error if none is found, hence no other check needed

          # should have an _.isFunction(action) by now.
          @currentBlenderBehaviorIndex = bbi
          # execute the action and retrieve the ActionResult (value or otherwise)
          result = action prop, src, dst, @  # assume _.isFunction action
#          result = action prop, src, dst, @blenderBehaviors[bbi], @path

          # Action() result handling
          visitNextBB = false # Optimistic - it always assumes we're finished with this value!
          if not (result in [Blender.SKIP, Blender.NEXT, Blender.DELETE, Blender.DELETE_NEXT])

            # we have a real value and a possible assignment

            if _.isArray(result) and (result[0] is Blender.NEXT) # [@NEXT value] Action result format
              result = result[1]
              visitNextBB = true

            l.debug 80, """
              Value assigning, Path='#{@path.join '/'}'
              value = #{(l.prettify(result)+'').replace(/,\n\s*/g,', ')[0..150]}...
            """
            dst[prop] = result # actually assign, by default all values

          else # we have some special ActionResult:
#            l.debug 50, "#{l.prettify result}"
            if result in [Blender.DELETE, Blender.DELETE_NEXT]
              delete dst[prop]
#              l.debug 70, "DELETEd prop = #{l.prettify prop}"

            if result in [Blender.NEXT, Blender.DELETE_NEXT]
              l.debug 60, "Blender.XXX_NEXT: Going to NEXT BlenderBehaviour"
              visitNextBB = true

        @path.pop()
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
  @SKIP: {ActionResult: "SKIP"}

  ###
  Go to NEXT BlenderBehavior in line, this one did (or didnt) do its work.
  The next BB in line must now take Action.

  - If its used alone, it also SKIPs assignment, cause NEXT is not a value!

  - If you also want to assign, use the as return [@NEXT, value]
    It assigns `value` to `dst[prop]` and then goes to the NEXT BlenderBehavior in line
  ###
  @NEXT: {ActionResult: "NEXT"}

  ###
  DELETE the `dst[prop]`. Can be done in Action, but why not doit by contract ?
  ###
  @DELETE: {ActionResult: "DELETE"}

  ###
  DELETE_NEXT - Like @DELETE, but also skip to next BlenderBehaviour in line.
  ###
  @DELETE_NEXT: {ActionResult: "DELETE_NEXT"}


  ###
  Actions: Predefined/built in actions.

  You can define you own Acxtions when you create a Blender instance.
  ###

  ### Simply overwrites dst value with src value ###
  overwrite: (prop, src, dst, blender)-> src[prop]



  ### Copy all properties of nested Objects (or Arrays) recursivelly. ###
  deepOverwrite: (prop, src, dst, blender)->
    blender.blend dst[prop], src[prop] # @todo: try _blend ?

  ###
  Append source array to destination.
  All non-undefined items are pushed @ dst
  ###
  arrayAppend: (prop, src, dst, blender)->
    dst[prop].push s for s in src[prop]
    dst[prop] # return the appended array as the result

module.exports = Blender

#### DEBUG ###
YADC = require('YouAreDaChef').YouAreDaChef

YADC(Blender)
  .before /overwriteOrReplace|deepOverwrite|overwrite|print/, (match, prop, src, dst, blender)->
    l.debug """
     YADC:#{match}
     '#{type dst[prop]}'    <--  '#{type src[prop]}'   /#{blender.path.join('/')}
    """, dst[prop],'    <--  ', src[prop]

  .before /getAction/, (match, actionName)->
    l.debug "getAction(actionName = #{actionName})"


