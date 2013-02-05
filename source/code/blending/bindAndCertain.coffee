_ = require 'lodash'
certain = require('../certain')
Logger = require './../Logger'
l = new Logger 'Blending/bindAndCertain', 0

###
  Traverses and mutates a BlenderBehavior Object as follows:

  a) converts all its 'non-terminal' Objects to 'certain' functions
    (that given a key, if key is found they return the value, else default value {keyed as '*'} )

  b) Converts all Strings, that are function names in 'bindTo', to these Functions.

  c) Binds all final 'action' Functions with 'bindTo'.

  @param {Object} o The BlenderBehavior Object to traverse
  @param bindTo where to bind all terminal Functions in o
  @param path is used only for debugging

  # @todo:(5 6 1) Test spec it!
###
bindAndCertain = (o, bindTo, path=['$'])->
  for key, val of o when not _.isArray(val) # blendFlavour array - ignore
    path.push key

    if _.isPlainObject(val) #recurse
      bindAndCertain(val, bindTo, path)
      o[key] = certain val
      o[key].isCertain = bindTo # just a note, used to identify it as a 'certain' function

    else #we have a function (or a String functionName)
      if _.isFunction(val) or _.isString(val) #final
        if _.isString val
          if _.isFunction bindTo[val] #
            action = bindTo[val] #get the action-function by that name!
          else
            throw """
              Error initializing blendBehaviour at '#{path.join('/')}'.
              No action '#{l.prettify val}' was found either on Blender or your passed actions {}.
            """

        else # _.isFunction
          action = val

        o[key] = _.bind action, bindTo
        o[key].isAction = bindTo # just a note, used to identify it as a 'final' action

      else # 'final' but not valid
        throw """
          Error: _.Blender: initializing blendBehaviour at '#{path.join('/')}'.
          Final action '#{l.prettify val}' is neither a Function, nor a String as functionName.
        """

    path.pop()

  certain o

module.exports = bindAndCertain


#ba = {
#    'blend': ['src', 'dst'] # @todo: rename to ""flavor" ? "aroma"
#
#    'Null': ->'MarkForRejection'
#    'Object': ->"All Objects go here"
#    'Array':
#      "Array": (prop, src, dst)-> _.reject @deepOverwrite(prop, src, dst), (v)->v is 'MarkForRejection'
#}
#console.log ba
#baa = bindAndCertain ba, {}
#
#console.log "Finalle:\n", baa

