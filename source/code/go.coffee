_ = require 'lodash'

###
An extensible, overloaded, anorthodox facade of `_.each`, `_.sort`, `_.filter` and `_.map` combined.

Unlike _.each,  it also has an interesting returned, result : a clone of the Object or Array passed, after actions are applied;

Allows to enumerate, filter & sort in one go.
   - arrays values/index
   - object's values/keys
   - *NOT IMPLEMENTED* backbone collections  #
just like in _.each but first a filter and sort are applied, by using a comparator / filter function, just like _.sort & _.filter

Examples :
_B.go myObject,
   filter: (val, key)-> key not in ['mixin'] #omit - could have a shortcut for omit/pick

@see _.sort(list, iterator, [context])

@param  {object,array} oa      list (Object or Array) whose properties are to be enumerated (& dangled)

@options actions {object} The actions to perform on this data (along with options}

  @option filter {function|String}
      A function to filter by - see [filter](http://lodash.com/docs#filter)
          (value, index|key, collection)->
      OR
      A String or []<String>
        *key name(s)* to filter (allow), when _.isObject oa. Acts as an alias to _.omit
        *values that* are equal when _.isArray oa (pretty usless - use a ->).

  @option sort {function}
    A function to compare key names with - see <code>_.sort</code>
        OR
    A key/value to sort with - by default :
      * Arrays are sorted on the 'element' (The value, record)
      * Objects are sorted on the 'key' (tubpleName / fieldName)
    Calls are
    `(element, index, oa)-> `## if oa is array
    `(value, key, oa)-> `## if oa is object

    Note for Objects: [JavaScript doesn't guarantee Object Property Order](http://stackoverflow.com/questions/5525795/does-javascript-guarantee-object-property-order) hence your result object might not be as meaningfull as you'd like. But your each action fn, will be called in a sorted manner!

      @todo: Make all iterators in uBerscore to respect that sorted Object!
          * store information on UOA, about key order - eg ['name', 'surname', 'address']
          * store the `sort` function on on UOA. Should keys change they, re-sort!
          * use backboney collections only.
          * all of the above!

  @option iter {function} The iterator/callback to invoke, *after* AFTER all actions (filter & sort) are applied.
      (element, index, oa)-> ## if oa is array
      (value, key, oa)-> ## if oa is object
      @todo : return false stops iteration!

  @todo: @option map {function} what to actually put on the UOA - new value is called after iter.

  @todo @option {object} opts =
                deep:
                  type:int
                  descr:"how deep to go into sub-levels"
                  default: 99999
                clone: default: true
                asynch:default: false

  @context {Object} where to bind this @ on all actions.

 @return {Object}      returns UOA = "Uber Object Array": a _new_ (cloned) Object or Array, after *all* the operations are applied along with some extra Uber meta-information.

@todo isClone : if isClone is false, always work with oa - might be too hard to suport!
@todo: add map ?? Is it needed ?

###
go = (oa, actions, context) -> #map#
  {filter, iter, sort, grub} = actions if actions

  isObj = not _.isArray oa # our 'default' collection type
  newOA = -> if isObj then {} else []
  oa = _.clone oa # unless (_.isBoolean(isClone) and isClone is false) #defaults to true - NOT IMPLMEMENTED

  # result handling
  # holds temporary result @todo: convert to class
  result = null # 'declaration'
  resetResult = -> # create a NEW collector, depending on our grub Collection OR oa type
    result =
      if grub is undefined
        newOA()
      else
        if _.isFunction grub    # used to grub from outside go
          newOA() # use oa's type as default collector
        else
          if _.isArray grub
            []
          else
            if _.isObject grub
              {}
            else
              if _.isString grub # string etc - are you kiddning me ?
                if grub in ['[]', 'array', 'Array', 'a', 'A']
                  []
                else
                  if grub in ['{}', 'object', 'Object', 'o', 'O' ]
                    {}
                  else
                    newOA()
              else
                newOA() # use oa's type as default collector


  # our default grub() fn, # either :
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

  ## Apply filter:
  if not (filter is undefined) #
    resetResult()
    _.each oa, (val, key)-> # not needed! [val, key] = fixForObj val, key
      if _.isFunction filter
        if filter.call context, val, key, oa
          resultPush val, key
#        else console.log 'Eliminating val, key ', val, key
      else
        if isObj # Object defaults for <String> & [] filters, which act on key : mimicks pick, omit etc for keys
          filter = [ filter ] if _.isString filter
          if _.isArray filter
            if key in (f.toString() for f in filter)
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
          if _.isString sort #'field' or 'value' # @todo: array of Strings as sort key ?
            (val)-> val #default sort field is a) the value of an array item and b) the key of an object
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

  # grub to our collection
  if grub
    if _.isFunction grub # could've done in in iter, but better keep 'em seperated (even if slower!)
      _.each oa, (val, key)->
        grub.call context, val, key, oa

    else
      if _.isArray grub
        grub.push arrItem for arrItem in oa
      else
        if _.isObject grub
          _.extend grub, oa




  oa # a sorted Array or Object

module.exports = go

# inline dev tests - make them into specs!
obj = ciba: 4, aaa: 7, b: 2, c: -1
arrInt = [ 4, 7, 2, -1 ]
arrStr = ['Pikoulas', 'Anodynos', 'Babylon', 'Agelos']

newArr = [667]
newObj = {"oldKey": "oldValue"}
#
#result = go obj ,
#          #filter: ['ciba', 'b']
#          filter : (val, key)->
#            console.log "#### uBerscore's user filter: (val, key)->", val, key
#            key in ['ciba', 'b']
#
#          sort: (val, key)->
#            console.log "#### uBerscore's user sort: (val, key)->", val, key
#            val
#
#          grub: (val, key)->
#            console.log "#### go.grub: (val, key)->", val, key
#            newArr.push val

#result = go arrInt,
#          filter: (val, key)->
##            console.log "#### go.filter: (val, key)->", val, key
#            val < 5
#
#          sort: (val, key)->
##            console.log "#### go.sort: (val, key)->", val, key
#            val
#          iter: (val, key)->
##            console.log "#### go.iter: (val, key)->", val, key
#
#          grub:newObj
#          grub:newArr
#          grub: (val, key)->
##            console.log "#### go.grub: (val, key)->", val, key
#            newObj[key]=val
#            newArr.push val

#console.log "************RESULTS!*************"
#console.log "result=", result
#console.log "newObj=", newObj
#console.log "newArr=", newArr

console.log go arrInt,
        sort: (v)-> v #todo: true for value sorting
        grub: newObj

console.log newObj