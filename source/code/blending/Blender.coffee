###DEV ONLY ###
_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
#__isNode = true
debugLevel = 0
###DEV ONLY ###

l = new (require './../Logger') 'Blender', if debugLevel? then debugLevel else 0
type = require '../type'
getValueAtPath = require '../objects/getValueAtPath'

###
  A highly configurable variant of deepExtend / jQuery.extend / lodash.merge
  @todo: docs!
###
class Blender

  @defaultOptions: {inherited: false, copyProto: false}

  defaultBBOrder: ['src', 'dst'] # `action` is stored in {dst:src} objects

  ###
  @param benderBehaviors {Array<BlenderBehavior>}

         The blender behaviors with which to perform the blending.

         Precedence is left to right.

         If benderBehaviors arg is not [], then all args are assumed to be BBs.

  @param options {Object} A hash of named options (or Actions) that ultimatelly extend this Blender instance.

              They can be used by your benderBehaviors (`blender` instance is passed as the 4rth argument on `Action`s)

              `options` are inherited: each option passed in a subclass, overwrites the ones in the ancestor hierarchy (`_.extend` is used).
              For example in `new MySuperAdvancedBlender [], {someOption:true}`, the value of `someOption` will overwrite/redefine all
              `someOption` values found is super classes (eg. `Blender`).

              The can be simple booleans, or functions (that are considered `Actions`).

              You can simply use them or call them on `blender` instance.

              Note: On action/Functions `@`/`this` is NOT bound to the Blender instance - its unbound.

              Note: `Action` Functions can be (and perhaps should better be) defined on a `BlenderBehavior`.

                    On a BlenderBehavior an Action is either defined :
                      - as a named key of XXXBlender, eg
                        ```
                          class XXXBlender extends Blender
                            doSomething: (prop, src, dst, blender)->
                      - OR directly on an `SrcDstSpec` eg `Array:Object:(prop, src, dst, blender)->`.

                    If you pass them as `options`, you loose somehow:

                      - Only one version can exist, the one copied on the `blender` instance it self.

                      - You can accintentally overwrite one that is used by all BlenderBehaviors (eg. `overwrite`).

                      - You loose dymanism: when they are defined in a `BlenderBehavior`, they are local to it.
                        When a string (name of an) Action is on a BlenderBehavior's type specification (eg `Array:Object:'overwrite'`)
                        then `'overwrite'` is searched on current BlenderBehavior and to all following ones, up until to `blender`
                        to find a function called `'overwrite'`.

                        Within an action, you can use `blender.getAction('overwrite')` to trigger the above dynamic search
                        and retrieve an action.

                        This hierarchical dynamism can actually be very usefull ;-)

              Note: If benderBehaviors arg is not [], then all args are assumed to be BBs, hence no `options`!

              Note: DONT overwrite `blend` or `_blend` (or `overwrite`, `deepOverwrite` etc)!
  ###
  constructor: (@blenderBehaviors...)->
    # add base Blender defaults
    (@_optionsList or= []).unshift Blender.defaultOptions

    # check if we have options: 1st param is blenderBehavior [], 2nd is options {}
    if _.isArray @blenderBehaviors[0]

      l.debug(20, "We might have options:", @blenderBehaviors[1], "@_optionsList (defaults):", @_optionsList) if l.debugLevel >= 20
      @_optionsList.push @blenderBehaviors[1] # user/param @options override all others
      @blenderBehaviors = @blenderBehaviors[0]

    # Store options: each option passed in a subclass, overwrites the ones in the ancestor hierarchy (`_.extend` is used).
    @_optionsList.unshift options = {}      # store all under local 'options'
    _.extend.apply undefined, @_optionsList # options are overwritten by subclass/construction values
    l.debug(10, "Final blender options:", options) if l.debugLevel >= 10

    # copy all to this, the blender instance of XXXBlender
    _.extend @, options
    delete @_optionsList  # no longer needed

    # Setup the default BlenderBehavior
    (@defaultBlenderBehaviors or= []).push Blender.behavior
    lastDBB = _.last @defaultBlenderBehaviors
    # add defaultAction to all destinations for the last BB
    for typeName, dbb of lastDBB['|'] # when type.isType(typeName) # assumed
      if (_.isUndefined dbb["*"])
        dbb["*"] or= lastDBB['|']['*']['*'] # Anything placed at '|':'*':'*' of lastDBB is default

    # treat defaulBBs as normal blenderBehaviors:
    # they just go at the end, being the last resort
    @blenderBehaviors.push bb for bb in @defaultBlenderBehaviors
    # shortify 'em all
    @blenderBehaviors[bbi]['|'] = Blender.shortifyTypeNames bb['|'] for bb, bbi in @blenderBehaviors
    @path = []

  # Recursivelly convert all isType(keys) to `type.short` format
  # i.e it changes all nested keys named 'Array', 'Object' etc to '[]', '{}' etc
  # Blender always use short format internally
  # @todo: 9 2 2 - dont shortify the PATH names!
  @shortifyTypeNames: (bbSrcDstSpec={})->
    for key, val of bbSrcDstSpec
      if type.isType key # ignore non-types (shouldn't be under '|', but just in case)
        short = type.toShort key
        if short and (key isnt short)
          bbSrcDstSpec[short] = bbSrcDstSpec[key]
          delete bbSrcDstSpec[key]

      if _.isPlainObject(val) #recurse
        Blender.shortifyTypeNames val

    bbSrcDstSpec

  # Find the actionName as Function and return it.
  # Starts looking in BlenderBehaviors preceding currentBlenderBehavior, and Blender it self as last resort
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
      throw l.err "_B.Blender.blend: Error: Invalid BlenderBehavior `actionName` = ", actionName,
                " - no Function by that name is found in a preceding BlenderBehavior or Blender it self.",
                " belowBlenderBehaviorIndex=#{belowBlenderBehaviorIndex}",
                " @currentBlenderBehaviorIndex=#{@currentBlenderBehaviorIndex}",
                " @blenderBehaviors=", @blenderBehaviors

  ###
    Read from blenderBehavior : {
      order:['src', 'path', 'dst']

      "|":
        Array:
          path: to:
              other: "|"
                String: ()->
              current: is: "|":
                String: ()->
    }
  
    @param blenderBehavior {blenderBehavior} The blenderBehavior to search for action
    @param bbi blenderBehavior index (just for debug)
    @param bbOrderValues Object keyd with 'src', 'dst', 'path' having a) current src/dst valye type and b) current @path contents

  ###
  getNextAction: (blenderBehavior, bbi, bbOrderValues)=>

    currentBBSrcDstSpec = blenderBehavior['|']

    for bbOrder in (blenderBehavior.order or @defaultBBOrder)
      # bbOrder is either 'src', 'dst' or 'path'

      if (currentBBSrcDstSpec  is undefined ) or # is nextBBSrcDstSpec terminal ?
         _.isString(currentBBSrcDstSpec ) or
         _.isFunction(currentBBSrcDstSpec) # or (not _.isObject nextBBSrcDstSpec ) #todo: need this ?
            break # skip all other bbOrder, if it was terminal.

      l.debug(80, "At bbOrder='#{bbOrder}'",
            (if bbOrder is 'path'
              " @path=#{l.prettify @path}"
            else
              " bbOrderValues[bbOrder]='#{bbOrderValues[bbOrder]}'"),
            " currentBBSrcDstSpec =\n", currentBBSrcDstSpec ) if l.debugLevel >= 80

      if _.isUndefined bbOrderValues[bbOrder]
        throw l.err  """
          _.Blender.blend: Error: Invalid BlenderBehavior `order` '#{bbOrder}',
          while reading BlenderBehavior ##{bbi} :\n""", @blenderBehaviors[bbi],
          "\n\nDefault BlenderBehavior order is ", @defaultBBOrder
          # Invlaid type is excluded as a case

      else # nextBBSrcDstSpec is used mainly for debuging
        if bbOrder is 'path'
          nextBBSrcDstSpec = getValueAtPath currentBBSrcDstSpec, @path[1..@path.length], {terminatorKey:"|"}
          if _.isObject nextBBSrcDstSpec
            nextBBSrcDstSpec = nextBBSrcDstSpec['|']
        else
          nextBBSrcDstSpec = currentBBSrcDstSpec[bbOrderValues[bbOrder]] or currentBBSrcDstSpec['*'] # eg `bb = bb['[]']` to give us the bb descr for '[]', if any. Otherwise use default '*'

        l.debug(70,
          if nextBBSrcDstSpec is undefined
            "Found NO nextBBSrcDstSpec at all - go to NEXT BlenderBehavior"
          else
            if bbOrder is 'path'
              "Got out of the path, having something!"
            else
              if nextBBSrcDstSpec is currentBBSrcDstSpec[bbOrderValues[bbOrder]]
                "Found "
              else
                if nextBBSrcDstSpec is currentBBSrcDstSpec['*']
                  "Found NOT exact nextBBSrcDstSpec, but a '*'"
                else
                  if _.isString nextBBSrcDstSpec
                    "Found a String "
                  else
                    if _.isFunction nextBBSrcDstSpec
                      "Found a Function "
                    else
                      throw "Unknown nextBBSrcDstSpec = " + l.prettify nextBBSrcDstSpec
        ,
          " \nbbOrder='#{bbOrder}'",
          " \nbbOrderValues[bbOrder]='#{bbOrderValues[bbOrder]}'",
          " \nnextBBSrcDstSpec=\n", nextBBSrcDstSpec
#          " \ncurrentBBSrcDstSpec=\n", currentBBSrcDstSpec
        ) if l.debugLevel >= 70

        currentBBSrcDstSpec = nextBBSrcDstSpec

    currentBBSrcDstSpec

  # A cover to the "real" _blend, that takes the root objects into blendingBehavior.
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
      props = if _.isArray src
                (p for v, p in src)
              else
                if @inherited then (p for p of src) else (p for own p of src)

      for prop in props # props for {} is ['prop1', 'prop2', ...], for [] its [1,2,3,...]
        @path.push prop

        l.debug(50, """
            @path = /#{@path.join('/')}
            '#{type dst[prop]}'    <--  '#{type src[prop]}'\n
          """, dst[prop], '    <--  ', src[prop]) if l.debugLevel >= 50

        # go through @certainBlenderBehaviors, until an 'action' match is found.
        visitNextBB = true
        for bb, bbi in @blenderBehaviors when visitNextBB
          l.debug(60, "Currently at @blenderBehaviors[#{bbi}] =\n", bb) if l.debugLevel >= 60

          nextBBSrcDstSpec = @getNextAction bb, bbi,
              # last argument is bbOrderValues, eg : `{scr:'[]', dst: '{}', path:['a','property']}`
              dst: type(dst[prop], true) # get short type, always handle it as short internally
              src: type(src[prop], true)
              path: @path # just ref the path

          if (nextBBSrcDstSpec) is undefined
            continue # go to next BlenderBehavior

          else # found an `action` candidate - Should be either String or Function (i.e a terminal value)
            action = nextBBSrcDstSpec

            if not _.isFunction action
              if not _.isString action
                throw l.err  """
                  _B.Blender.blend: Error: Invalid BlenderBehavior `action` (neither 'Function' nor 'String') : """, action
              else # try to find the actionName (String) as an existing Function.
                action = @getAction action, bbi # throws error if none is found, hence no other check needed

          # should have an _.isFunction(action) by now.
          @currentBlenderBehaviorIndex = bbi # @todo: why do we need this ?

          # execute the action and retrieve the ActionResult (value or otherwise)
          result = action prop, src, dst, @  # assume _.isFunction action

          # Action() result handling
          visitNextBB = false # Optimistic - it always assumes we're finished with this value!
          if not (result in [Blender.SKIP, Blender.NEXT, Blender.DELETE, Blender.DELETE_NEXT])

            # we have a real value and a possible assignment

            if _.isArray(result) and (result[0] is Blender.NEXT) # [@NEXT value] Action result format
              result = result[1]
              visitNextBB = true

            l.debug(20, """
              Action Called - Value assigning:  @path =""", @path.join('/'), """
              \n  value =""", l.prettify result) if l.debugLevel >= 20

            dst[prop] = result # actually assign, by default all values

          else # we have some special ActionResult:
            l.debug(30, "Action Called - ActionResult = ", result) if l.debugLevel >= 30
            if result in [Blender.DELETE, Blender.DELETE_NEXT]
              delete dst[prop]
#              l.debug 70, "DELETEd prop = #{l.prettify prop}"

            if result in [Blender.NEXT, Blender.DELETE_NEXT]
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
    DELETE_NEXT - Like @DELETE, but also skip to next BlenderBehavior in line.
  ###
  @DELETE_NEXT: {ActionResult: "DELETE_NEXT"}


  ###
  Actions: Predefined/built in actions.

  You can define you own Acxtions when you create a Blender instance.
  ###

  ### Simply overwrites dst value with src value ###
  overwrite: (prop, src, dst, blender)-> src[prop]

  ###
    Copy all properties of nested Objects (or Arrays) recursivelly.

    It (vaguely) assumes that dst[prop] is already an Object type ({}, [], ->)
    than really endorses keys (not merely accepts them eg. String accepts keys, but aren't really visible)

  ###
  deepOverwrite: (prop, src, dst, blender)->
    if blender.copyProto # http://stackoverflow.com/questions/9959727/what-is-the-difference-between-proto-and-prototype-in-java-script
      dst[prop].__proto__ = src[prop].__proto__

    blender.blend dst[prop], src[prop] # @todo: try _blend ?

  ###
  Append source array to destination.
  All non-undefined items are pushed @ dst
  ###
  arrayAppend: (prop, src, dst, blender)->
    dst[prop].push s for s in src[prop]
    dst[prop] # return the appended array as the result


  ###
   The default behavior is to overwrite all keys of destination
   with the respective value of source.

   When destination is a `Primitive` or `Undefined`, we simply overwrite it
   with either the (primitive) value or reference (for Object types)

   When destination is an Object (reference type, with nested keys),
   and source also happens to be an Object as well, then we 'merge',
   i.e we deepOverwrite.

   Note that we deepOvewrite or 'merge' with Array <-- Object and vise versa.
   This simply copies properties which is javascript valid and perhaps usefull.

   Redefined `BlenderBehavior`s can change this default behavior.
  ###
  @behavior: #static

    order: ['dst', 'src']

    '|': # our 'dst <-- src' spec

      # When destination is a `Primitive` or `Undefined`, we simply overwrite it
      # with either the (primitive) value or reference (for Object types)
      "*": "*": 'overwrite' # this is the default case

      # When destination is an Object (reference type, with nested keys),
      # and source also happens to be an Object as well, then we 'merge',
      # i.e we deepOverwrite.
      Array:
        Array: 'deepOverwrite' # 'A' is short for 'Array' (as also is '[]').
        Object: 'deepOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')
        Function: 'deepOverwrite'

      Object:
        Object: 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
        Array: 'deepOverwrite'
        Function: 'deepOverwrite'

      Function:
        Object: 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
        Array: 'deepOverwrite'
        Function: 'deepOverwrite'


module.exports = Blender

#### DEBUG ###
if l.debugLevel > 40
  YADC = require('YouAreDaChef').YouAreDaChef

  YADC(Blender)
    .before /overwriteOrReplace|deepOverwrite|overwrite|print/, (match, prop, src, dst, blender)->
      l.debug 40, """
       YADC:#{match} @path = /#{blender.path.join('/')}
       '#{type dst[prop]}'    <--  '#{type src[prop]}'\n
      """, dst[prop],'    <--  ', src[prop]

    .before /getAction/, (match, actionName)->
      l.debug 50, "getAction(actionName = #{actionName})"


