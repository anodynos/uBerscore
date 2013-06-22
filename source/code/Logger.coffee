_ = require 'lodash'
inAgreements = require './agreement/inAgreements'
setp = require './objects/setp'
getp = require './objects/getp'
###
  The simplest possible powerfull Logger!

  Use like this
    `var l = new (require('./../Logger'))('MyModule', 0`)
  or in coffee
    `l = new (require './../Logger') 'MyModule', 0`


  @todo: document it! And make specs
  @todo: change the lame names of
    * levelPath
    * get/set DebugLevel
###
class Logger
  constructor: (@levelPath='', @debugLevel=0, @newLine=false)->
    @levelPaths = (path for path in @levelPath.split('/') when path)
    Logger.loggerCount = (Logger.loggerCount or 0) + 1

  prettify:
    if (__isNode? and __isNode) or not __isNode?
      do (inspect = require('util').inspect)-> # 'util' node-only execution via urequire config `bundle.dependencies.node`

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

  @getALog: (baseMsg, color, cons)->
    ->
      args = (@prettify(arg) for arg in Array.prototype.slice.call arguments)
      title = "#{if not @levelPath
                  'Logger' + Logger.loggerCount + ' '
                 else
                  '[' + @levelPath + '] ' #todo: make title smaller than @levelPath, perhaps `@levelPaths[@levelPaths.length-1]` ?
                }#{baseMsg}"
      title = title + ":" if title
      args.unshift title
      args.unshift "#{color}" if not (__isWeb? and __isWeb)
      args.unshift "\n" if @newLine
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

  err:  Logger.getALog "ERROR", '\u001b[31m', console.error #red
  log: Logger.getALog "", '\u001b[0m', console.log          #white
  verbose: Logger.getALog "", '\u001b[35m', console.log     #???
  ok: Logger.getALog "", '\u001b[32m', console.log          #green
  warn: Logger.getALog "WARNING", '\u001b[33m', console.log #yellow

  debug: do ->
    log = Logger.getALog "DEBUG", '\u001b[36m', console.log #blue

    return (level, msgs...)->
      if not _.isNumber(level)
        msgs.unshift level
        level = @lastDebugLevelCheck or 1 # debug unless debugLevel is 0
        msgs.unshift(
          if @lastDebugLevelCheck then "(?#{@lastDebugLevelCheck})" else '(!1)'
        )
      else
        msgs.unshift "(#{level})"

      if level <= @getEffectiveDebugLevel()
        log.apply @, msgs

      @lastDebugLevelCheck = undefined #always reset it

  # How to set debugLevel: #todo: update docs with levelPaths
  #
  # On instance construction, a logger can have a localy-defined debugLevel:
  #     `l = new Logger 'myLoggerName', 10`
  #
  # This local/instance debugLevel is always respected:
  # all l.debug calls with 1st param a 10 (or less) will fire, as long
  # as Logger.debugLevel is undefined or greater than 0
  #
  # if Logger.debugLevel is <= 0, ALL debug calls are disabled.
  #
  # if Logger.debugLevel is > 0, then ALL debug calls that are up to Logger.debugLevel will fire,
  # as well as those with greater as long as their `l.debugLevel` (i.e their local instance variable) allows it.

  #
  #  * First, check if we override globally with Logger.debugLevel
  #    * if zero or negative Logger.debugLevel, its turns debug OFF completely for all loggers.
  #    * otherwise the greater of Logger.debugLevel and @debugLevel is chosen as effective
  #
  #  * Otherwise, we return @debugLevel (and consequently its __proto__, if undefined @ instance)
  getEffectiveDebugLevel: ->
    fedDebLevel = @getFederatedDebugLevel()
    if not _.isUndefined fedDebLevel
      if fedDebLevel <= 0
        -Infinity
      else
        _.max [fedDebLevel, @debugLevel, 0]
    else
      @debugLevel or 0

  getFederatedDebugLevel: ()->
     Logger.getStaticDebugLevel @levelPaths

  # Static method to retrieve the level for given levelPath (eg 'uberscore/objects/isIqual')
  # or one above it in the hierarchy (eg 'uberscore/objects').
  # it looks inside Logger.debugLevels
  @getStaticDebugLevel = (levelPaths=[])->
    levPaths = _.clone levelPaths
    levPaths.unshift 'debugLevels'
    val = getp Logger, levPaths
    lastPath = levPaths.pop() # WHERE IS THE REAL REPEAT/UNTIL CONSTRUCT ?

    while (_.isUndefined val?._value) and lastPath
      val = getp Logger, levPaths
      lastPath = levPaths.pop()

    return val?._value

  # Sets the level for a given Logger levelPath
  # @param String levelPath eg 'uberscore/objects/isIqual'
  # @param Number level eg 30
  @setDebugLevel = (level, levelPath)->
    setp Logger, 'debugLevels/' + levelPath + '/_value', level, create: true

  # a helper to simplify decision to Log or not, whoith having to evaluate huge concatenations,
  # just to decide we arent at debuging level anyway.
  deb: (debugLevel)->
    if debugLevel <= @getEffectiveDebugLevel()
      @lastDebugLevelCheck = debugLevel
      return true
    else
      @lastDebugLevelCheck = undefined
      return false

  # static
  @logger = new Logger 'DefaultLogger'

  # create static class methods for 'log', 'warn', bound with default instance
  for key, val of Logger.prototype
    if _.isFunction(val)
      Logger[key] = _.bind val, Logger.logger
    else
      Logger[key] = val


module.exports = Logger

#todo: specs ?
#Logger.debugLevel = 15
#logger10 = new Logger 'logger10', 10
#logger20 = new Logger 'logger20', 20
#
#logger10.debug 10, 'logger10.debug debugLevel = 10 # fires normally'
#logger10.debug 15, 'logger10.debug debugLevel = 15 # fires because of Logger.debugLevel = 15'
#logger10.debug 20, 'logger10.debug debugLevel = 20 # doesnt fire because logger10 doesnt allow it & Logger.debugLevel = 15'
#
#logger20.debug 10, 'logger20.debug debugLevel = 10 #fires due to logger20'
#logger20.debug 15, 'logger20.debug debugLevel = 15 #fires due to logger20'
#logger20.debug 20, 'logger20.debug debugLevel = 20 #fires due to logger20 having debugLevel = 20, despite Logger.debugLevel = 15'
#
#Logger.debug 10, 'DefaultLogger.debug debugLevel = 10 # fires because of Logger.debugLevel = 15'
#Logger.debug 15, 'DefaultLogger.debug debugLevel = 15 # fires because of Logger.debugLevel = 15'
#Logger.debug 20, 'DefaultLogger.debug debugLevel = 20 # doesnt fire because of Logger.debugLevel = 15'
#
#if logger10.deb(13)
#  logger10.debug 'logger10 using last deb() param as debugLevel'
#
#if logger20.deb(18)
#  logger20.debug 'logger20 using last deb() param as debugLevel'




#Logger.setDebugLevel 40, 'paparia/mentoles'
#
#l = new Logger 'paparia/mentoles/arxidies'
#l2 = new Logger 'paparologies/mentoles/arxidies', 29
#l.log Logger.debugLevels
#
#l.debug 30, 'arxiditses1', l.getFederatedDebugLevel()
#l2.debug 30, 'arxiditses2', l2.getFederatedDebugLevel() # not debuging, cause there's no debugLevel for 'paparologies/***'
#
#console.log l.getDebugLevel is l.__proto__.getDebugLevel
