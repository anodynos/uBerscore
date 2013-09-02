#todo: use defaultOptions = {options.create: false, separator: '.'}
#todo rename to set
###
  Sets a *value* to an *object*, to a given path that's either:
  - a texctual description
  - an Array<String> of path names
  
  There are some twists while walking the path - see @options
  
  @param o {Object} in which to set value to
  
  @param path @param path {String|Array<String>} Either a path as a String (separated by separator)
  or an array of path key names.
  
  @param val Anything The value to set
  
  @param options {Object}
   @option create {Truthy} if truthy, it creates {} for missing paths.
     If there is a non `_.isObject` while expanding the path,
     it doens't create a new {} and it doesnt set the value.

   @option overwrite {Truthy|String}
     If truthy, Objects paths that dont exist are created, just like `create: true`
     But also, non `_.isObject` values are replaced by a new {} that will 'hold' this new path.
     If its a String, then a key by that name is created on the new {}, holding the old value.

###
defaultOptions =
  separator: '/'
  create: true
  overwrite: false

setp = (o, path, val, options=defaultOptions)-> #
  _.defaults options, defaultOptions if options isnt defaultOptions

  if not _.isArray path
    if _.isString path
      path = path.split options.separator
      path = (p for p in path when p) # clean up any empty paths
    else
      throw """_B.setp Error: invalid path: #{path}.
                Use either an Array, eg ['path1', 'path2']
                or `separator`-ed String, eg 'path1.path2'"""

  if not _.isObject o
    throw "_B.setp Error: invalid object: #{o}"

  for p, pi in path
    if not _.isObject o[p]
      if options.create or options.overwrite # either true or a string will do
        newObj = null

        # if there is no value
        if _.isUndefined(o[p])
          newObj = {} #use this
        else
          if options.overwrite
            newObj = {} #use this
            if _.isString(options.overwrite)    # preserve current value of `o[p]`
              newObj[options.overwrite] = o[p]  # under `options.overwrite` key (eg 'oldValue')

        if newObj then o[p] = newObj

      else
        if _.isUndefined(o[p])
          return false # wont set value on inexistent path

    o = o[p] if pi < path.length-1 #the last one is our {} to mutate

  if _.isObject o
    o[p] = val
    return true
  else
    return false

module.exports = setp

#inline tests
#
#l = new (require '../Logger') 'uberscore/setp'

#
#o=
#  '$':
#    bundle:
#      anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
#      dependencies:
#        depsVars: "Bingo"
#
#oClone = _.clone o, true
#
#l.log setp oClone, '$/bundle/dependencies/new/', 'just_a_String', overwrite:'oldVal'
#
#l.log oClone
#