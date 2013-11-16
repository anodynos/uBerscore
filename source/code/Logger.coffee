inAgreements = require './agreement/inAgreements'
setp = require './objects/setp'
getp = require './objects/getp'
###
  The simplest possible powerfull Logger

  Use like this (coffeescript):
    ```
      l = new _B.Logger 'some/logging/path', 10       # 10 is this instance debugLevel.
                                                      # It can be undefined (look below), in which case its considered a `1`.

      l.log 'Some log message'                        # prints `[title/foo/bar] : Some log message` in white
      l.warn 'Some warn message'                      # prints `[title/foo/bar] WARNING : Some warn message` in yellow.
      l.ok 'Some ok message'                          # prints `[title/foo/bar] : Some ok message` in green.
      l.err 'Some error message'                      # prints `[title/foo/bar] ERROR : Some error message` in red on console.error.
      l.er 'Some soft error message'                  # prints `[title/foo/bar] ERROR : Some soft error message` in red on console.log.

      # debugging with debugLevels

      l.debug 'Some debug message'                    # prints `[title/foo/bar] DEBUG: (!1) Some debug message` in debugish blue
                                                      # since no level is passed for this debug() call, its considered as a `1`.

      # if 1st argument is Number, it questions the debugLevel whether its allowed to be printed.

      l.debug 15, 'Not printing debug message'        # prints nothing, cause debugLevel is larger than this instance

      # leaving instance debugLevel undefined allows debug path levels to come into play

      _B.Logger.addDebugPathLevel 'some/logging', 20  # all logger instances without their own debugLevel, get it from this path

      l = new _B.Logger 'some/logging/long/path'      # dynamically gets from the closest debugPathLevel (20 in this case) @ each debug()
      l.debug 15, 'Printing debug message'            # prints it, cause the closest debugPathLevel found is 20

      # supress ALL debugLevels
      _B.Logger.maxDebugLevel = 12
      l.debug 15, 'Not printing debug message'        # Doesn't prints it, cause there's a global limit of maxDebugLevel = 12

      # using _B.Logger.addDebugPathLevel to define a *minimum* debugLevel
      _B.Logger.addDebugPathLevel '/', 10  # all logger instances without their own debugLevel, get a 10 as minimum

      # check whether you debug at certain level, without constly processing
      if l.deb 23
        l.deb "Some" + ("complicated stuff" + i for i in [1..100000])

      # `l.deb` is actually an alias of `l.debug`.

      l.deb 45              # When passed only a Number, it sets its passed level
      doStuff()             # as the last check, effective on the next l.deb() call without a level.
      l.deb "some stuff"    # level 45 is effective

    ```
  Notes :
    * All calls return the String that is printed. Debug returns undefined if its debugLevel isn't allowed.
      If called with only a level Number, it returns true if its allowed or false otherwise

    * New lines in front of 1st arg are respected & printed before title
###

class Logger
  constructor: (debugPath=[], @debugLevel)->
    @setDebugPath debugPath
    Logger.loggerCount = (Logger.loggerCount or 0) + 1

  getALog = (baseMsg, color, cons)->
    (args...)->
      # count & trim new lines in fornt of first arg - add them on the whole print
      if _.isString args[0]
        newLines = countNewLines args[0]
        args[0] = args[0][newLines..]

      args = (Logger.prettify(arg) for arg in args)

      title = "#{if _.isEmpty this?.debugPath
                  'Logger' + Logger.loggerCount + ' '
                 else
                  '[' + @debugPath.join('/') + '] '
                }#{baseMsg}"
      title = title + ":" if title
      args.unshift title
      args.unshift "#{color}" if not (__isWeb? and __isWeb)
      args.unshift ("\n" for i in [1..newLines] by 1).join('')
      args.push '\u001b[0m' if not (__isWeb? and __isWeb) #reset color
      cons.apply console, args #console context needed for chrome http://stackoverflow.com/questions/8159233/typeerror-illegal-invocation-on-console-log-apply

      # return printable args
      try
        return args.join('')
      catch err # something wrong casting to string
        retString = ""
        for arg in args
          retString += Object.prototype.toString arg
        return retString

  countNewLines = (str)->
    newLines = 0
    newLines++ while str[newLines] is '\n'
    newLines

  arrayizeDebugPath = (debugPath)->
    if _.isString debugPath
      (path for path in debugPath.split('/') when path)
    else if _.isUndefined debugPath
      []
    else if _.isArray debugPath
      debugPath
    else [debugPath]

  # Sets the debug path for this instance, split ito an array of subpaths
  # @param debugPath String|Array eg 'uberscore/objects/isIqual' or ['uberscore', 'objects', 'isIqual']
  setDebugPath: (debugPath)-> @debugPath = arrayizeDebugPath debugPath

  @addDebugPathLevel: (debugPath, debugLevel)->
    if not _.isNaN(debugLevel * 1)
      debugPath = _.clone arrayizeDebugPath debugPath
      debugPath.unshift 'debugPathsLevels'
      debugPath.push '_level'
      setp Logger, debugPath, debugLevel * 1, create: true
    else
      throw new Error "debugLevel '#{debugLevel}' isNaN (Not a Number or not Number parsable)"

  # retrieve `_level` for given levelPath (eg ['uberscore', 'objects', 'isIqual'])
  # or one above it in the hierarchy (eg ['uberscore', 'objects']).
  # from `Logger.debugPathsLevels` that holds these global _levels
  getDebugPathLevel: (levelPath=@debugPath)->
    levPaths = _.clone levelPath
    val = getp Logger.debugPathsLevels, levPaths
    lastPath = levPaths.pop() # WHERE IS THE REAL REPEAT/UNTIL CONSTRUCT ?

    while (_.isUndefined val?._level) and lastPath
      val = getp Logger.debugPathsLevels, levPaths
      lastPath = levPaths.pop()

    val?._level

  isDebug: (level)->
    # check if global Logger.maxDebugLevel allows level
    if _.isNumber Logger.maxDebugLevel
      return false if level > Logger.maxDebugLevel

    # check if instance @debugLevel allows level
    if _.isNumber @debugLevel
      return false if level > @debugLevel
    else
      # check if _level in a global debugPath (or one above it) allows this level
      if _.isNumber pathLevel = @getDebugPathLevel()
        return false if level > pathLevel
      else
        return false if level > 1 # default @debugLevel is 1, but we dont store it

    true

  deb: do ->
    debugLog = getALog "DEBUG", '\u001b[35m', console.log #blue

    (level, msgs...)->
      if _.isEmpty(msgs) and _.isNumber(level) # just level check, stored for next call
        return @isDebug @lastDebugLevelCheck = level

      if not _.isNumber(level)
        msgs.unshift level # no level set in this deb()
        level = @lastDebugLevelCheck ? 1 # level default is 1, if we dont have a @lastDebugLevelCheck
        msgs.unshift(if @lastDebugLevelCheck then "(?#{@lastDebugLevelCheck})" else '(!1)')
      else
        msgs.unshift "(#{level})"

      #msgs[0] now contains "(level)" - remove new lines from msg[1] and add 'em to it
      if _.isString msgs[1]
        newLines = countNewLines msgs[1]
        msgs[1]  = msgs[1][newLines..]
        msgs[0] = ("\n" for i in [1..newLines] by 1).join('') + msgs[0]

      delete @lastDebugLevelCheck #always reset it
      if @isDebug level
        debugLog.apply @, msgs # apply & return the printable string

  debug: @::deb #alias

  @prettify:
    if (__isNode? and __isNode) or not __isNode?
      do (inspect = (require 'util').inspect)-> # 'util' node-only execution via urequire config `bundle.dependencies.node`. ALternative is `require(node!util)`

        nodeVerLE_092 = do -> #check if nodejs version is <=0.9.2
          v = []; v[i] = x*1 for x,i in process.version[1..].split '.'
          if v[0]>0 or v[1]>9
            false
          else
            if v[1] is 9
              if v[2] <= 2 then true
              else false
            else true

        return (o)-> # our prettify function
          pretty =
            if nodeVerLE_092 # diff .inspect call for "node": ">=0.9.3"
              "\u001b[0m#{inspect o, false, null, true}"
            else
              "\u001b[0m#{inspect o, {showHidden:false, depth:null, colors:true}}"

          if _.isArray o
            pretty.replace /\n/g, ''
          if inAgreements o, [_.isObject, _.isRegExp] #_.isObject matches for _.isFunction/Array
            pretty
          else # _.isString, etc
            o
    else
      (o)->o #todo: check for "can't convert to primitive type"' cases, and convert to string representation. http://docstore.mik.ua/orelly/webprog/jscript/ch03_12.htm
  prettify: Logger.prettify # available on each instance

  err:  getALog "ERROR", '\u001b[31m', console.error #red
  er:  getALog "ERRor", '\u001b[31m', console.log    #red
  warn: getALog "WARNING", '\u001b[33m', console.log #yellow
  verbose: getALog "", '\u001b[36m', console.log     #purple
  ver: @::verbose                                    # alias
  ok: getALog "", '\u001b[32m', console.log          #green
  log: getALog "", '\u001b[0m', console.log          #white


  # create a `default` instance and add static class methods for 'log', 'warn' etc,
  # bound with this default instance
  @logger = new Logger 'DefaultLogger'
  for key, val of Logger.prototype
    if _.isFunction(val)
      Logger[key] = _.bind val, Logger.logger
    else
      Logger[key] = val

module.exports = Logger
