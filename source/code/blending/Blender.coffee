###DEV ONLY ###
_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
#__isNode = true
###DEV ONLY ###

type = require '../type'
getValueAtPath = require '../objects/getValueAtPath'

###
  Blender: a highly configurable object blender :-)

  Blending is the process of mixing one or more objects, using some predefined rules.

  The most known blending functions are the likes of `_.extend, _.defaults, _.clone`
  or `jQuery.extend`, `lodash.merge` or Kurt Milam's `deepExtend` etc

  However, these functions have many deficiencies and their behavior is highly static.

  In overall they have the following shortcomings:

    * They ususally dont go deep - eg `_.extend` and `_.defaults` is only dealing with root-level keys.
      `lodash.merge` does better, but still there is no further control on
       other copying/overwriting/merging/deep linking semantics.
       There are no callbacks or infrastructure to easily adjust its behavior.

    * There is little or no control of which branches or data types to
      visit/avoid/overwrite/merge/trasform/delete etc.

      We can't easily decide what happens at each point, for example
        * which data type overwrites/merges/ignores another type
        * what happens at which point/path in the object etc.
        * which exact action to take at each point

  Consider the simplest example: a destination object with a key 'myKey' holding an [] and the corresponding
  source key holding a String. We might wish for a rule that our source 'String' at 'myKey' is just pushed
  in the corresponding 'Array'. Or be pushed only if it aint there. Or any other crazy rule.

  In general its not possible to have fine-grain control on object transformations
  using these predefined simple _.xxx or similar functions.

  You can attempt to provide handwritten functions that solve a specific case, but its hard and error prone
  without a precise and extensible rule-based callback enabled framework.

  If we attempt to write the recursive function with these rules, we'll be reinventing the wheel each time.

  uBerscore Blender provides the common structure for this, allowing rules even more complex than this
  to be defined in an easy way.

  See the specs for more info!

  @todo: more docs!
###
class Blender

  @defaultOptions:
    inherited: false
    copyProto: false

    # @todo: allow BlenderBehavior cases, configurable PER BlenderBehavior, with defaults on blender
    #
    # Then meet these specs

    # a) match exact path              (@todo )

    # b) match everything nested below (@done: pathTerminator default '|')

    # c) compination of a) & b) : anything exact have one behavior, everything found below another behavior.

    # e) like c, but also allow specific number of path keys or specific named keys to have specific behavior

    ###
      Terminates a path in a blenderBehavior spec - better not touch for now!
      @todo: rethink it, allow terminator-like syntax in bbSrcDstPathSpec
    ###
    pathTerminator: '|'

    ###
      @todo: only has partial implementation - no specs
    ###
    isExactPath: true


    ###
      allow paths to be expressed as '/path/to/stuff' instead of nested object keys
      @todo: (2 2 2): allow it to change per BB
    ###
    pathSeparator: ':'

    debugLevel: 0

    # @todo: investigate those notions
    #actionResultHandler:   'alwaysAssign'
    #actionCallbackAdapter: 'standardCallbackAdapter'


  defaultBBOrder: ['src', 'dst'] # `action` is stored in {src:dst} objects

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

          Notes:
            * On action/Functions `@`/`this` is NOT bound to the Blender instance - its unbound.

            * `Action` Functions can be (and perhaps should better be) defined on a `BlenderBehavior`.

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

          * If benderBehaviors arg is not [], then all args are assumed to be BBs, hence no `options`!

          * DONT overwrite `blend` or `_blend` (or `overwrite`, `deepOverwrite` etc)!
  ###
  constructor: (@blenderBehaviors...)->
    # add base Blender defaults @todo: (4 4 3) Devise a new pattern for options uDerive :-)
    (@_optionsList or= []).unshift Blender.defaultOptions

    @l = new (require './../Logger') 'uberscore/Blender'

    # check if we have options: 1st param is blenderBehavior [], 2nd is options {}
    if _.isArray @blenderBehaviors[0]

      @l.debug("We might have options:", @blenderBehaviors[1], "@_optionsList (defaults):", @_optionsList) if @l.deb 20
      @_optionsList.push @blenderBehaviors[1] # user/param @options override all others
      @blenderBehaviors = @blenderBehaviors[0]

    # Store options: each option passed in a subclass, overwrites the ones in the ancestor hierarchy (`_.extend` is used).
    @_optionsList.unshift options = {}      # store all under local 'options'
    _.extend.apply undefined, @_optionsList # options are overwritten by subclass/construction values

    @l.debugLevel = options.debugLevel
    @l.debug("Final blender options:", options) if @l.deb 10

    # copy all to this, the blender instance of XXXBlender
    _.extend @, options
    delete @_optionsList  # no longer needed

    # Setup the default BlenderBehavior
    (@defaultBlenderBehaviors or= []).push Blender.behavior
    # add defaultAction to all destinations for the last BB
    lastDBB = _.last @defaultBlenderBehaviors
    for typeName, dbb of lastDBB # when type.isType(typeName) # assumed
      if (_.isUndefined dbb["*"])
        dbb["*"] or= lastDBB['*']['*'] # Anything placed at '*':'*' of lastDBB is default

    # treat defaulBBs as normal blenderBehaviors:
    # they just go at the end, being the last resort
    @blenderBehaviors.push bb for bb in @defaultBlenderBehaviors

    # adjust blenderBehaviors: shortify all type names & expand all paths
    @blenderBehaviors[bbi] = @adjustBlenderBehavior bb for bb, bbi in @blenderBehaviors
    @path = []

  ###
  adjustBlenderBehavior takes a user defined blenderBehavior and converts it
  to a suitable internal format that easier to work internally with Blender.

  It does 2 basic things:

  * it shortifies all 'dst' and 'src' type names - ie
    'Array' becomes '[]' and 'Object' becomes '{}' etc

  * it 'expands' path names, i.e it converts from
       {'/my/path/to/there':{'|':'something'}}
    to {my:{path:{to:{there:{'|':'something'}}}}

  its a maksed call to _adjustBbSrcDstPathSpec

  @done: 9 2 2 - dont shortify the PATH names!
  ###
  adjustBlenderBehavior : (blenderBehavior)->
    blenderBehavior.order or= @defaultBBOrder
    @_adjustBbSrcDstPathSpec blenderBehavior, blenderBehavior.order

  #@done: doc it & spec it!
  _adjustBbSrcDstPathSpec: (bbSrcDstPathSpec, orderRemaining)->

    if orderRemaining.length > 0
      bbOrder = orderRemaining[0]

      if bbOrder is 'path'

        for key, val of bbSrcDstPathSpec

          if key is @pathTerminator
            #consume terminator & throw 'path' from order
            if _.isPlainObject(val) #recurse
              @_adjustBbSrcDstPathSpec val, orderRemaining[1..]

          else
            # adjust a path key (with separator)
            # from {'/my/path/to/there':{'|':'something'}}
            # to   {my:{path:{to:{there:{'|':'something'}}}}
            # blending in :) with existing bbSpec
            pathItems =
                if @pathSeparator
                  (path.trim() for path in key.split(@pathSeparator) when path)
                else
                  []

              if pathItems.length > 1
                newV = bbSrcDstPathSpec
                for p, i in pathItems
                  newV[p] or= {} # blend in :-)
                  if i < pathItems.length-1
                    newV = newV[p]
                  else
                    newV[p] = val
                delete bbSrcDstPathSpec[key]
              else
                # fix '/somepath/' to 'somepath'
                if pathItems[0] and key isnt pathItems[0]
                  bbSrcDstPathSpec[pathItems[0]] = val
                  delete bbSrcDstPathSpec[key]

            if _.isPlainObject val                         # recurse but keep 'path' as 1st order item
              @_adjustBbSrcDstPathSpec val, orderRemaining # until a pathTerminator '|' arrives


      else
        # Shortify all type names
        # Recursivelly convert all isType(keys) to `type.short` format
        # i.e it changes all nested keys named 'Array', 'Object' etc to '[]', '{}' etc
        # It changes ONLY those responding to 'src' & 'dst', NOT inside paths (it makes no sense to do)!
        for key, val of bbSrcDstPathSpec
          if type.isType key              # ignore non-types
            short = type.toShort key
            if short and (key isnt short)
              bbSrcDstPathSpec[short] = bbSrcDstPathSpec[key]
              delete bbSrcDstPathSpec[key]

          if _.isPlainObject(val)                             # recurse, but for next order item
            @_adjustBbSrcDstPathSpec val, orderRemaining[1..] # consume this order item

    bbSrcDstPathSpec

  # Find the actionName as Function and return it.
  #
  # Starts looking in BlenderBehaviors preceding currentBlenderBehavior and Blender it self as last resort
  # throws error if no action Function is found in any of those
  #
  # @param {String} actionName name of the action, eg 'deepOverwrite'
  # @return {Function} The first action Function found by that actionName
  getAction: (actionName, belowBlenderBehaviorIndex = @currentBlenderBehaviorIndex)=>
    for bb, bbi in @blenderBehaviors when bbi >= belowBlenderBehaviorIndex
      if _.isFunction bb[actionName]
        return bb[actionName]

    # last resort, check this blender instance
    if _.isFunction @[actionName]
      return @[actionName]
    else
      throw @l.err "_B.Blender.blend: Error: Invalid BlenderBehavior `actionName` = ", actionName,
                " - no Function by that name is found in a preceding BlenderBehavior or Blender it self.",
                " belowBlenderBehaviorIndex=#{belowBlenderBehaviorIndex}",
                " @currentBlenderBehaviorIndex=#{@currentBlenderBehaviorIndex}",
                " @blenderBehaviors=", @blenderBehaviors

  ###
    Read from blenderBehavior : {
      order:['src', 'path', 'dst']

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

    currentBBSrcDstSpec = blenderBehavior

    for bbOrder in blenderBehavior.order
      # bbOrder is either 'src', 'dst' or 'path'

      if (currentBBSrcDstSpec is undefined ) or # is nextBBSrcDstSpec terminal ?
         _.isString(currentBBSrcDstSpec ) or
         _.isFunction(currentBBSrcDstSpec) # or (not _.isObject nextBBSrcDstSpec ) #todo: need this ?
            break # skip all other bbOrder, if it was terminal.

      @l.debug("At bbOrder='#{bbOrder}'",
            (if bbOrder is 'path'
              " @path=#{@l.prettify @path}"
            else
              " bbOrderValues[bbOrder]='#{bbOrderValues[bbOrder]}'"),
            " currentBBSrcDstSpec =\n", currentBBSrcDstSpec ) if @l.deb 80

      if _.isUndefined bbOrderValues[bbOrder]
        throw @l.err  """
          _.Blender.blend: Error: Invalid BlenderBehavior `order` '#{bbOrder}',
          while reading BlenderBehavior ##{bbi} :\n""", @blenderBehaviors[bbi],
          "\n\nDefault BlenderBehavior order is ", @defaultBBOrder
          # Invlaid type is excluded as a case

      else # nextBBSrcDstSpec is used mainly for debuging
        if bbOrder is 'path'
          nextBBSrcDstSpec = 
            getValueAtPath currentBBSrcDstSpec, @path[1..], {
                           terminateKey: if @isExactPath then undefined else @pathTerminator} #default is '|'

          nextBBSrcDstSpec = nextBBSrcDstSpec['|'] if _.isObject nextBBSrcDstSpec

        else
          nextBBSrcDstSpec = currentBBSrcDstSpec[bbOrderValues[bbOrder]] or currentBBSrcDstSpec['*'] # eg `bb = bb['[]']` to give us the bb descr for '[]', if any. Otherwise use default '*'

        @l.debug(70,
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
                      throw "Unknown nextBBSrcDstSpec = " + @l.prettify nextBBSrcDstSpec
        ,
          " \nbbOrder='#{bbOrder}'",
          " \nbbOrderValues[bbOrder]='#{bbOrderValues[bbOrder]}'",
          " \nnextBBSrcDstSpec=\n", nextBBSrcDstSpec
#          " \ncurrentBBSrcDstSpec=\n", currentBBSrcDstSpec
        ) if @l.deb 70

        currentBBSrcDstSpec = nextBBSrcDstSpec

    currentBBSrcDstSpec
  ###
    blend is where the actual blending happens.
    We have a destination (*dst*) object and one or more sources (*src*) that we examine their each and every key/value.

    At each key/value we examine we have enough information and power to manipulate and populate dst.

    The general case is that `destination` is populated with values from `source`.

    Ultimatelly destination will :
      * eventually 'receive' values
      * possibly coming from sources values
      * perhaps manipulated by an Action
      * if these are found in a BlenderBehavior of our blender.

    At each Action (which act on a current source's key/value) we have enough information like passed at params:

      prop: the name of the property, eg 'name'

      dst: the destination Object that contains this key. dst[prop] gives the value of 'name' on the destination

      src: the source Object that contains this key. src[prop] gives the value of 'name' on the source.

      blender: the `blender` instance that contains lots of info, the most usefull of them are:

        * blender.path : an Array of the current path key names, starting with '$' as root.
                        eg ['$', 'customer', 'person', 'name']

        * blender.srcRoot: The original source object, as called with the 1st blend call (object at '$')

        * blender.dstRoot: The original destination object, as called with the 1st blend call (object at '$')

        but also some internals

        * blender.blenderBehaviors All `BlenderBehavior`s, in the order added (most precedent is 1st etc)

        * blender.currentBlenderBehaviorIndex so that `blender.blenderBehaviors[blender.currentBlenderBehaviorIndex]`
                                              gives us the currently selected `BlenderBehavior`
        * blender.currentBlenderBehavior



    Notes:
      * blend() is a cover to the "real" _blend, that takes the root objects into blendingBehavior.
        It recurses recurses root '$' path, to apply rules even on root objects (eg blend({}, [])
        A waste of isEmpty otherwise, only used for root! @todo: (2 3 1) optimize it

      * if there are no sources, then 1st param becames one source and dst becomes {}

    @param dst {Anything} our desination Object (which can also be a primitive)

    @param sources {Array<Anything>} Our source objects
  ###
  blend: (dst, sources...)=>
    if _.isEmpty @path #todo: (2 3 1) optimize with a @isRoot = true ?

      # if there are no sources, 1st param becames a source
      # and dst = {} || [] || ??? @todo: proper match of src type
      if _.isUndefined(sources) or _.isEmpty(sources)
        sources = [dst]
        dst = if _.isArray(dst) then [] else {} # @todo: proper match of src type

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

    # if there are no sources, 1st param becames a source
    # and dst = {} || [] || ??? @todo: proper match of src type
    if _.isUndefined(sources) or _.isEmpty(sources)
      sources = [dst]
      dst = if _.isArray(dst) then [] else {}

    for src in sources
      props = if _.isArray src
                (p for v, p in src)
              else
                if @inherited then (p for p of src) else (p for own p of src)

      for prop in props # props for {} is ['prop1', 'prop2', ...], for [] its [1,2,3,...]
        @path.push prop

        @l.debug("""
            @path = /#{@path.join('/')}
            '#{type dst[prop]}'    <--  '#{type src[prop]}'\n
          """, dst[prop], '    <--  ', src[prop]) if @l.deb 50

        # go through @certainBlenderBehaviors, until an 'action' match is found.
        visitNextBB = true
        for bb, bbi in @blenderBehaviors when visitNextBB
          @l.debug("Currently at @blenderBehaviors[#{bbi}] =\n", bb) if @l.deb 60

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
                throw @l.err  """
                  _B.Blender.blend: Error: Invalid BlenderBehavior `action` (neither 'Function' nor 'String') : """, action
              else # try to find the actionName (String) as an existing Function.
                action = @getAction action, bbi # throws error if none is found, hence no other check needed

          # should have an _.isFunction(action) by now.
          @currentBlenderBehaviorIndex = bbi # @todo: why do we need these ?
          @currentBlenderBehavior = @blenderBehaviors[bbi]

          # execute the action and retrieve the ActionResult (value or otherwise)
          result = action prop, src, dst, @  # assume _.isFunction action

          # Action() result handling
          visitNextBB = false # Optimistic - it always assumes we're finished with this value!
          if not (result in [Blender.SKIP, Blender.NEXT, Blender.DELETE, Blender.DELETE_NEXT])

            # we have a real value and a possible assignment

            if _.isArray(result) and (result[0] is Blender.NEXT) # [@NEXT value] Action result format
              result = result[1]
              visitNextBB = true

            @l.debug("""
              Action Called - Value assigning:  @path =""", @path.join('/'), """
              \n  value =""", @l.prettify result) if @l.deb 20

            dst[prop] = result # actually assign, by default all values

          else # we have some special ActionResult:
            @l.debug("Action Called - ActionResult = ", result) if @l.deb 30
            if result in [Blender.DELETE, Blender.DELETE_NEXT]
              delete dst[prop]
#              @l.debug 70, "DELETEd prop = #{l.prettify prop}"

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
   with the respective value of source - like _.extend, but deep.

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

    # When destination is a `Primitive` or `Undefined`, we simply overwrite it
    # with either the (primitive) value or reference (for Object types)
    "*": "*": 'overwrite' # this is the default case

    # When destination is an Object (reference type, with nested keys),
    # and source also happens to be an Object as well, then we 'merge',
    # i.e we deepOverwrite.
    Array:
      '[]': 'deepOverwrite' # 'A' is short for 'Array' (as also is '[]').
      '{}': 'deepOverwrite' # '{}' is type.toShort('Object')
      '->': 'deepOverwrite'

    '{}':
      'O': 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
      Array: 'deepOverwrite'
      Function: 'deepOverwrite'

    '->':
      '{}': 'deepOverwrite'
      '[]': 'deepOverwrite'
      '->': 'deepOverwrite'


module.exports = Blender

# @todo: for DEBUGing make it work for instance methods & per instance ###
# @todo:
#if @l.deb 40
#  YADC = require('YouAreDaChef').YouAreDaChef
#
#  YADC(Blender)
#    .before /overwriteOrReplace|deepOverwrite|overwrite|print/, (match, prop, src, dst, blender)->
#      @l.debug 40, """
#       YADC:#{match} @path = /#{blender.path.join('/')}
#       '#{type dst[prop]}'    <--  '#{type src[prop]}'\n
#      """, dst[prop],'    <--  ', src[prop]
#
#    .before /getAction/, (match, actionName)->
#      @l.debug 50, "getAction(actionName = #{actionName})"

###
@todo: (3 5 4) Make XxxBlender constructors return a reference to `.blend` function instead of a blender
that is an just {} (with the .blend function among others).

For everything else to be available, `blend.__proto__` has to be the `blender` it self.

Use the following pattern or find a new one
class A
  constructor:(@a='a')->
    @say.__proto__ = @
    return @say

  say:(msg)->"A Hello, #{msg}"

class B extends A
  constructor:(@b='b')->
    return super

class C extends B
  constructor:(@c='c')->
    return super

  say:(msg)->"C Hello, #{msg}"

#a = new A
#l.log a

c = new C
l.log c.say
l.log c.a, c.b, c.c

l.log c.say("goodmorning")
l.log c("Its working!")
###


###
 @todo: Allow for
    'Something': anything by 'undefined' or 'null')
    'Nothing': opposite of 'Something'
    'Nested': {} or -> or []
###

###
  @todo:
  rename class @behavior to @behaviors and recognise if its one behavior or many
###

###
 @todo: Allow for `'Number': _B.Blender.SKIP` (or perhaps even `'Number': 'Blender.SKIP'` )
 instead of `'Number': -> _B.Blender.SKIP`. It'll be quite painfull in vanilla Javascript.
###
