#_ = require 'lodash' # not need anymore, we have it as a Bundle Dependency!

###
An extensible, overloaded, anorthodox facade experiment of `_.each`, `_.sortBy`, `_.filter` (and `_.map` and _.ManyMore!) combined.

Unlike _.each,  it always has a return result :
  either a clone of the Object or Array passed (after actions are applied);
  Or a 'grab' object (or object type) that is passed.

*go* allows to enumerate, filter, sort & collect
   - arrays values/index
   - object's values/keys
   - *NOT IMPLEMENTED* backbone collections  #
in one go, similarly to `_.each`.

But you can have a `fltr` and `sort` applied first, similar to _.filter & _.sortBy.
`fltr` and `sort` are an extremely overloaded condition /comprator, with many shortcuts.

  Finally at each of the resulted elements, you can collect (grab) values/keys/calcs in any form & destination you want.


@example :
```_B.go o, fltr: (val, key)-> key not in ['mixin']```

This looks like _.omit, the oposite of _.pick - actually there is a shocrtcut for pick

```_B.go o, fltr:['thisKey', 'thatKey'] #```

@param  {object,array} oa  list (Object or Array) whose properties are to be enumerated (& dangled)

@options actions {object} The actions to perform on this data (along with options}

  @option fltr {function|String}
      A function to fltr by - see [fltr](http://lodash.com/docs#fltr)
          (value, index|key, collection)->
      OR
      A String or []<String>
        *key name(s)* to fltr (allow), when _.isObject oa. Acts as an alias to _.omit
        *values that* are equal when _.isArray oa (pretty usless - use a -> instead).

  @option sort {function}
    A function to compare key names with - see <code>_.sort</code>
        OR
    A key/value to sort with - by default :
      * Arrays are sorted on the 'element' (The value, record)
      * Objects are sorted on the 'key' (tubpleName / fieldName)

    All calls are
      `(element, index, oa)-> `## if oa is array
      `(value, key, oa)-> `## if oa is object

    @example

      ```
      o = {b:4, a:1, c:2}
      _B.go o, sort:(v)->v
      ```
      returns : {a:1, c:2, b:4 }

      while

      ```
      _B.go o, sort:(v,k)->k
      ```
      returns : {a:1, b:4, c:2 }

      Check spec for more examples.

    Note for Objects: [JavaScript doesn't guarantee Object Property Order](http://stackoverflow.com/questions/5525795/does-javascript-guarantee-object-property-order) hence your result object might not be as meaningfull as you'd like. But your each action fn, will be called in a sorted manner!

      @todo: Make all iterators in uBerscore to respect that sorted Object!
          * store information on UOA, about key order - eg ['name', 'surname', 'address']
          * store the `sort` function on on UOA. Should keys change they, re-sort!
          * use backboney collections only.
          * all of the above!

  @option iter {function} The iterator/callback to invoke, *after* AFTER all actions (fltr & sort) are applied.
      (element, index, oa)-> ## if oa is array
      (value, key, oa)-> ## if oa is object
      @todo : return false stops iteration!

  @todo: @option map {function} what to actually put on the UOA - new value is called after iter.
         How is it used - examples ??

  @todo: @option {object} opts =
                deep:
                  type:int
                  descr:"how deep to go into sub-levels"
                  default: 99999
                clone: default: true # if clone is false, what ? might be too hard to suport!
                asynch: default: false

 @context {Object} where to bind this @ on all actions.

 @return {Object}      returns UOA = "Uber Object Array": a _new_ (cloned) Object or Array, after *all* the operations are applied along with some extra Uber meta-information.


###
go = (oa, actions, context) -> #map#
  {fltr, iter, sort, grab} = actions if actions

  isObj = not _.isArray oa # our 'default' collection type
  newOA = -> if isObj then {} else []
  oa = _.clone oa # unless (_.isBoolean(isClone) and isClone is false) #defaults to true - NOT IMPLMEMENTED

  # result handling
  # holds temporary result @todo: convert to class
  result = null # 'declaration'
  resetResult = -> # create a NEW collector, depending on our grab Collection OR oa type
    result =
      if grab is undefined
        newOA()
      else
        if _.isFunction grab    # used to grab from outside go
          newOA() # use oa's type as default collector
        else
          if _.isArray grab
            []
          else
            if _.isObject grab
              {}
            else
              if _.isString grab # string etc - are you kiddning me ?
                if grab in ['[]', 'array', 'Array', 'a', 'A']
                  []
                else
                  if grab in ['{}', 'object', 'Object', 'o', 'O' ]
                    {}
                  else
                    newOA()
              else
                newOA() # use oa's type as default collector


  # our default grab() fn, # either :
  # push a result for Array,
  # OR add/overwritre a key for Object
  resultPush = (val, key)->
#    console.log "PUSHING RESULT ", val, key, "@ #{if not _.isArray result then 'Object' else 'Array'} which is:", result
    if not _.isArray result
      result[key] = val
    else
      result.push val

  # _ functions call object with wrong params

  fixForObj = (val, key)->
    if isObj
      key = val
      val = oa[key]
    [val, key]

  ## Apply fltr:
  if not (fltr is undefined) #
    resetResult()
    _.each oa, (val, key)-> # not needed! [val, key] = fixForObj val, key
      if _.isFunction fltr
        if fltr.call context, val, key, oa
          resultPush val, key
#        else console.log 'Eliminating val, key ', val, key
      else
        if isObj # Object defaults for <String> & [] filters, which act on key : mimicks pick, omit etc for keys
          fltr = [ fltr ] if _.isString fltr
          if _.isArray fltr
            if key in (f.toString() for f in fltr)
              resultPush val, key

    oa = result

  ## Apply sort:
  if not (sort is undefined) #  map and sort needed ONLY if sort is used.
    resetResult()
    keysOrder = [] #todo: store keysOrder
    _(oa).chain()
      .map( (val, key)-> if isObj then key else val) #  a list of *key* for objects or *value* for arrays
      .sortBy(
        if _.isFunction sort
          (val, key)->  #console.log '!!! called sort function(val, key, oa[val]): ', val, key, oa[val]
            sort.apply context, (fixForObj val, key)  # uBer sort always called with val, key
        else
            # @todo : check this part!
            # @ todo : provide shortcuts
            #   ['val', 'v'] = (v)->v
            #   ['key', 'k'] = (v,k)->k
          if _.isString sort #'field' or 'value' # @todo: array of Strings as sort key ?
            (val)-> val       #default sort field is a) the value of an array item and b) the key of an object
          else
            if _.isBoolean sort # todo: this is not working probably - check it!
              if sort then ->true else ->false
            else
              sort
      )
      .each (val, key)-> #store the new sorted result
        # console.log "!!! storing *each* new sorted result (val, key) =", val, key
        resultPush.apply null, (fixForObj val, key)

    oa = result

  # apply iter for each if it exists (and is a a function!)
  if _.isFunction iter
    if sort is undefined
      _.each oa, (val, key)->
        iter.call context, val, key, oa

    else # @todo respect keysOrder via an [] of keys created
      _.each oa, (val, key)->
        iter.call context, val, key, oa

  # grab to our collection
  if grab
    if _.isFunction grab # could've done in in iter, but better keep 'em seperated (even if slower!)
      _.each oa, (val, key)->
        grab.call context, val, key, oa

    else
      if _.isArray grab
        grab.push arrItem for arrItem in oa
      else
        if _.isObject grab
          _.extend grab, oa

  oa # a sorted Array or Object

module.exports = go

# inline dev tests - make them into specs!

#obj = ciba: 4, aaa: 7, b: 2, c: -1
#arrInt = [ 4, 7, 2, -1 ]
#arrStr = ['Pikoulas', 'Anodynos', 'Babylon', 'Agelos']
#
#newArr = [667]
#newObj = {"oldKey": "oldValue"}
##
#result = go obj ,
#          #fltr: ['ciba', 'b']
#          fltr : (val, key)->
#            console.log "#### uBerscore's user fltr: (val, key)->", val, key
#            key in ['ciba', 'b']
#
#          sort: (val, key)->
#            console.log "#### uBerscore's user sort: (val, key)->", val, key
#            val
#
#          grab: (val, key)->
#            console.log "#### go.grab: (val, key)->", val, key
#            newArr.push val

#result = go arrInt,
#          fltr: (val, key)->
##            console.log "#### go.fltr: (val, key)->", val, key
#            val < 5
#
#          sort: (val, key)->
##            console.log "#### go.sort: (val, key)->", val, key
#            val
#          iter: (val, key)->
##            console.log "#### go.iter: (val, key)->", val, key
#
#          grab:newObj
#          grab:newArr
#          grab: (val, key)->
##            console.log "#### go.grab: (val, key)->", val, key
#            newObj[key]=val
#            newArr.push val

#console.log "************RESULTS!*************"
#console.log "result=", result
#console.log "newObj=", newObj
#console.log "newArr=", newArr
#
#console.log go arrInt,
#        sort: (v)-> v #todo: true for value sorting
#        grab: newObj
#
#console.log newObj