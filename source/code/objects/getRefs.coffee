###
  Deflattens ALL references of Array or Objects, returns them as an array.
  @param oa <Object|Array> The Object or Array to get all references
  @param options <Object>
     * deep boolean If deep is true, all references in nested Objects/Arrays are retrieved
     * inherited boolean If inherited is true, all keys are considered, not just own
###

getRefsDefaults =
    deep: false
    inherited: false

getRefs = (oa, options=getRefsDefaults, refsArray = [])->
  _.defaults(options, getRefsDefaults) if options isnt getRefsDefaults

#  _.each oa, (v)-> # each get only own
#    if not isPlain v
  keys = if options.inherited
            (key for key of oa)
         else
            (key for own key of oa)

  for key in keys
    v = oa[key]
    if _.isObject v
      refsArray.push v
      if options.deep
        getRefs v, options, refsArray

  refsArray

module.exports = getRefs