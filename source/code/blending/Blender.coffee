define ['types/type', 'objects/getp', 'types/isHash', 'utils/CoffeeUtils'],
  (type, getp, isHash, CoffeeUtils)->

    isHash = require 'types/isHash'

    class ActionResult
      constructor: (@name)->

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
    class Blender extends CoffeeUtils

      @subclass: require 'utils/subclass'

      #@defaultOptions:
      inherited: false

      # A hint to BlenderBehaviors to attempt and copy
      # the protope chain of source items over to destination.
      #
      # Warning: current (default) implementation of `deepOverwrite`, is:
      # when __proto__ is not available (i.e IE), the __proto__ copying
      # is siumlated by replacing dst[prop] with a new `Object.create`d that copies the proto
      # and then copying properties from the discarded dst[prop]
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

                      - You can accidentally overwrite one that is used by all BlenderBehaviors (eg. `overwrite`).

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
        @l = new (require './../Logger') 'uberscore/Blender', @debugLevel

        # check if we have options: 1st param is blenderBehavior [], 2nd is options {}
        if _.isArray @blenderBehaviors[0]
          @l.deb("We might have options:", @blenderBehaviors) if @l.deb 20
          _.extend @, @blenderBehaviors[1] if isHash @blenderBehaviors[1] # user/param @options override all others
          @blenderBehaviors = @blenderBehaviors[0]

        for aClass in @getClasses() by -1 when aClass.behavior
          @blenderBehaviors.push aClass.behavior

        # add defaultAction to all destinations for the last BB
        lastDBB = _.last @blenderBehaviors
        for typeName, dbb of lastDBB # when type.isType(typeName) # assumed
          if (_.isUndefined dbb["*"])
            dbb["*"] or= lastDBB['*']['*'] # Anything placed at '*':'*' of lastDBB is default

        # adjust blenderBehaviors: shortify all type names & expand all paths
        for bb, bbi in @blenderBehaviors # when isHash bb
          @blenderBehaviors[bbi] = @adjustBlenderBehavior bb

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

      its a masked call to _adjustBbSrcDstPathSpec
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
                if isHash val #recurse
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

                if isHash val                         # recurse but keep 'path' as 1st order item
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

              if isHash val                             # recurse, but for next order item
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
            return _.bind bb[actionName], @

        # last resort, check this blender instance
        if _.isFunction @[actionName]
          return _.bind @[actionName], @
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

        for bbOrder in blenderBehavior.order # bbOrder is either 'src', 'dst' or 'path'

          if (currentBBSrcDstSpec is undefined ) or # is nextBBSrcDstSpec terminal ?
             _.isString(currentBBSrcDstSpec ) or
             _.isFunction(currentBBSrcDstSpec) or
             (currentBBSrcDstSpec instanceof ActionResult)
                break # skip all other bbOrder, if it was terminal or found.

          @l.deb("At bbOrder='#{bbOrder}'",
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
                getp currentBBSrcDstSpec, @path[1..], {
                               terminateKey: if @isExactPath then undefined else @pathTerminator} #default is '|'

              if _.isObject nextBBSrcDstSpec
                nextBBSrcDstSpec = nextBBSrcDstSpec['|']

            else
              # eg `bb = bb['[]']` to give us the bb descr for '[]', if any. Otherwise use default '*'
              nextBBSrcDstSpec = currentBBSrcDstSpec[bbOrderValues[bbOrder]] or currentBBSrcDstSpec['*']

            @l.deb(
              if nextBBSrcDstSpec is undefined
                "Found NO nextBBSrcDstSpec - NEXT BlenderBehavior"
              else
                if bbOrder is 'path'
                  "Got out of the path, having something!"
                else if nextBBSrcDstSpec is currentBBSrcDstSpec[bbOrderValues[bbOrder]]
                  "Found "
                else if nextBBSrcDstSpec is currentBBSrcDstSpec['*']
                  "Found NOT exact nextBBSrcDstSpec, but a '*'"
                else if _.isString nextBBSrcDstSpec
                  "Found a String "
                else if _.isFunction nextBBSrcDstSpec
                  "Found a Function "
                else if (nextBBSrcDstSpec instanceof ActionResult)
                  "Found an ActionResult"
                else throw "Unknown nextBBSrcDstSpec = " + @l.prettify nextBBSrcDstSpec
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

        At each Action (which act on a current source's key/value) we have enough information like passed:

          prop: the name of the property, eg 'name' or 0 (passed as 1st argument)

          dst: the destination Object that contains this key. dst[prop] gives the value of 'name' on the destination (passed as 2nd argument)

          src: the source Object that contains this key. src[prop] gives the value of 'name' on the source. (passed as 3rd argument)

          blender: the `blender` instance is passed as context (this). It contains lots of info, the most usefull of them are:

            * path : an Array of the current path key names, starting with '$' as root.
                            eg ['$', 'customer', 'person', 'name']

            * srcRoot: The original source object, as called with the 1st blend call (object at '$')

            * dstRoot: The original destination object, as called with the 1st blend call (object at '$')

            but also some internals

            * blenderBehaviors All `BlenderBehavior`s, in the order added (most precedent is 1st etc)

            * currentBlenderBehaviorIndex so that `blender.blenderBehaviors[blender.currentBlenderBehaviorIndex]`
                                                  gives us the currently selected `BlenderBehavior`
            * currentBlenderBehavior

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
            dst = @createAs dst

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
          props = @properties src

          for prop in props # props for {} is ['prop1', 'prop2', ...], for [] its [1,2,3,...]
            @path.push prop

            @l.deb("""
                @path = /#{@path.join('/')}
                '#{type @read dst, prop}'    <--  '#{type @read src, prop}'\n
              """, @read(dst, prop), '    <--  ', @read(src,prop)) if @l.deb 50

            # go through @blenderBehaviors, until an 'action' match is found.
            visitNextBB = true
            for bb, bbi in @blenderBehaviors when visitNextBB
              @l.deb("Currently at @blenderBehaviors[#{bbi}] =\n", bb) if @l.deb 60

              @currentBlenderBehaviorIndex = bbi # @todo: why do we need these ?
              @currentBlenderBehavior = @blenderBehaviors[bbi]

              nextBBSrcDstSpec = @getNextAction bb, bbi,
                  # last argument is bbOrderValues, eg : `{scr:'[]', dst: '{}', path:['a','property']}`
                  dst: type(@read(dst,prop), true) # get short type, always handle it as short internally
                  src: type(@read(src,prop), true)
                  path: @path # just ref the path

              if (nextBBSrcDstSpec) is undefined
                continue # go to next BlenderBehavior

              else # found an `action` candidate - Should be either String or Function (i.e a terminal value)
                action = nextBBSrcDstSpec
                if not _.isFunction action
                  if _.isString action # try to find the actionName (String) as an existing Function.
                    action = @getAction action, bbi # throws error if none is found, hence no other check needed
                  else
                    if (action instanceof ActionResult)
                      result = action
                    else
                      throw @l.err  "_B.Blender.blend: Invalid `action` (neither 'Function' nor 'String'): ", action

              # we should have an _.isFunction(action) or ActionResult
              # execute the action and retrieve the ActionResult or value
              if not (action instanceof ActionResult)
                result = action.call @, prop, src, dst, @ # `this` as context & last param (for already bound functions)

              # Action() result handling
              visitNextBB = false # Optimistic - it always assumes we're finished with this value!
              if not (result instanceof ActionResult)
                # we have a real value and a possible assignment
                if _.isArray(result) and (result[0] is @NEXT) # [@NEXT value] Action result format
                  result = result[1]
                  visitNextBB = true

                @l.deb("Result handling: @path =", @path.join('/'),
                         "\n value =", @l.prettify result) if @l.deb 20

                @resultHandler dst, prop, result

              else # we have some special ActionResult:
                @l.deb("ActionResult = ", result) if @l.deb 30
                if result in [@DELETE, @DELETE_NEXT]
                  @delete dst, prop

                if result in [@NEXT, @DELETE_NEXT]
                  visitNextBB = true

            @path.pop()
        dst

      # Basic functionality of Blender
      ###
        create and return an (empty) object, that resembles as much the obj passed
        @todo: proper creation with matching type/class of obj
               Should attempt to use constructor
      ###
      createAs: (obj)->
        if _.isArray(obj)
          []
        else
          if @copyProto
            Object.create Object.getPrototypeOf(obj)
          else
            {}

      ## Read (get) a property from an Object -
      #   eg `obj.get(prop)` for Backbone model
      read: (obj, prop)->
        # It could return:
        # * a promise, of when property was read, resolved with read value
        throw "Read without a prop" if _.isUndefined prop #@todo: proper error handling
        obj[prop] # default read of object property

      # Write (set) a value a property of an Object
      #   eg `obj.set(prop, val)` for a Backbone model
      # It could return:
      # * a promise, of when property was saved, resolved with saved value
      # * saved value
      write: (obj, prop, val)=>
        throw "Write without a prop" if _.isUndefined prop #@todo: proper error handling
        # console.log @read obj, prop # @todo: must be bound for this work
        obj[prop] = val # default write to object property
        val

      # Delete (eg. Backbone `unset`) a property of an Object
      delete: (obj, prop)->
        throw "Delete without a prop" if _.isUndefined prop #@todo: proper error handling
        delete obj[prop]

      # read the properties/keys/attributes of an Object
      # eg. Backbone `_.keys model.attributes`
      # it should obey inherited
      properties: (obj)->
        if _.isArray obj
          (p for v, p in obj)
        else
          if @inherited
            (p for p of obj)
          else
            (p for own p of obj)

      # copy all values of src to dst - similar tp _.extend
      copy: (dst, src)->
        for prop in @properties src
          @write dst, prop, @read(src, prop)
        dst

      resultHandler: @::write

      ###
      Actions: Predefined/built in actions.

      You can define you own Acxtions when you create a Blender instance.
      ###

      ### Simply overwrites dst value with src value ###
      overwrite: (prop, src)-> @read src, prop

      ###
        Copy all properties of nested Objects (or Arrays) recursivelly.

        It (vaguely) assumes that dst[prop] is already an Object type ({}, [], ->)
        than really endorses keys (not merely accepts them eg. String accepts keys, but aren't really visible)
      ###
      deepOverwrite: (prop, src, dst)->
        if @copyProto
          if {}.__proto__ is Object.prototype
            # @read of `dst[prop].__proto__ = src[prop].__proto__`
            @read(dst, prop).__proto__ = @read(src, prop).__proto__
          else
            # __proto__ not supported - simulate it, by discarding dst[prop]
            # with a new one that has the right proto + copied own props

            # create a new object (! @todo: DANGEROUS - WHEN ?)
            copiedObjWithProto = Object.create Object.getPrototypeOf @read src, prop
            # extend copiedObjWithProto with original's object properties
            # eg dst[prop] = _.extend copiedObjWithProto, dst[prop]
            @copy copiedObjWithProto, @read(dst, prop)

            # replace original dst object, with the new that has __proto__ copied
            @write dst, prop, copiedObjWithProto

        # this reads as `@blend dst[prop], src[prop]`
        @blend @read(dst, prop), @read(src, prop) # @todo: try _blend for faster ?

      ###
      Append source array to destination.
      All non-undefined items are pushed @ dst
      ###
      arrayAppend: (prop, src, dst)->
        [srcArr, dstArr] = [@read(src, prop), @read(dst, prop)]
        dstArr.push s for s in srcArr
        dstArr # return the appended array as the result

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
        '[]':
          '[]': 'deepOverwrite'
          '{}': 'deepOverwrite'
          '->': 'deepOverwrite'

        '{}':
          '{}': 'deepOverwrite'
          '[]': 'deepOverwrite'
          '->': 'deepOverwrite'

        '->':
          '{}': 'deepOverwrite'
          '[]': 'deepOverwrite'
          '->': 'deepOverwrite'

      ###
      **Action() result handling**: How to process the decision (result) of an Action() call.

      An Action call returns either a _real value_ OR a special `ActionResult` singleton.

       - If its a "value",
        - its assigned to `dst[prop]`, by default. But this can change.
        - The property is considered as processed/finished.

       - If its an `ActionResult` its processed as follows:

      ###

      ###
      SKIP variable assignement resulted from Action call .
      Handling of this property is considered finished.
      ###
      @SKIP: new ActionResult "SKIP"
      SKIP: Blender.SKIP # copied to prototype (i.e all instances have it)
      ###
      Go to NEXT BlenderBehavior in line, this one did (or didnt) do its work.
      The next BB in line must now take Action.

      - If its used alone, it also SKIPs assignment, cause NEXT is not a value!

      - If you also want to assign, use the as return [@NEXT, value]
        It assigns `value` to `dst[prop]` and then goes to the NEXT BlenderBehavior in line
      ###
      @NEXT: new ActionResult "NEXT"
      NEXT: Blender.NEXT

      ###
        DELETE the `dst[prop]`. Can be done in Action, but why not doit by contract ?
      ###
      @DELETE: new ActionResult "DELETE"
      DELETE: Blender.DELETE

      ###
        DELETE_NEXT - Like @DELETE, but also skip to next BlenderBehavior in line.
      ###
      @DELETE_NEXT: new ActionResult "DELETE_NEXT"
      DELETE_NEXT: Blender.DELETE_NEXT

    ###
    @todo: (3 5 4) Make XxxBlender constructors return a reference to `.blend` function instead of a blender
    that is an just {} (with the .blend function among others).

    For everything else to be available, `blend.__proto__` has to be the `blender` it self.
    ###


    ###
     @todo: Allow for
        'Something': anything but 'undefined' or 'null')
        'Nothing': opposite of 'Something'
        'Nested': {} or -> or []
    ###

    ###
      @todo: subclasses:
      - find a better pattern for constructors & @behavior/options adding
      - rename @behavior to @behaviors and recognise if its one behavior or many
    ###
