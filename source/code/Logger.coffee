# a `var VERSION = "x.x.x"` is placed here by grant:concat
_ = require 'lodash'
inAgreements = require './agreement/inAgreements'


###
  The simplest possible Logger!

  Use like this
    `var l = new (require('./../Logger'))('MyModule', 0`)
  or in coffee
    `l = new (require './../Logger') 'MyModule', 0`
###
class Logger
  # default Logger::debugLevel
  @debugLevel = 0
  VERSION: if VERSION? then VERSION else '{NO_VERSION}' # 'VERSION' variable is added by grant:concat

  constructor:->@_constructor.apply @, arguments
  _constructor: (@title, @debugLevel = 0, @newLine = true)->
    _.bindAll @

  @getALog: (baseMsg, color, cons)->
    ->
      args = (@prettify(arg) for arg in Array.prototype.slice.call arguments)
      title = "#{if @title is undefined
                        'undefinedTitleogger'
                      else
                        if @title is ''
                          ''
                        else '[' + @title + '] '
                }#{baseMsg}"
      title = title + ":" if title
      args.unshift title
      args.unshift "#{color}" if not (__isWeb? and __isWeb)
      args.unshift "\n" if @newLine
      args.push '\u001b[0m' if not (__isWeb? and __isWeb) #reset color
      cons.apply null, args

      args.join('')

  err:  Logger.getALog "ERROR", '\u001b[31m', console.error #red
  log: Logger.getALog "", '\u001b[0m', console.log          #white
  verbose: Logger.getALog "", '\u001b[32m', console.log     #green
  warn: Logger.getALog "WARNING", '\u001b[33m', console.log #yellow

  debug: do ->
    log = Logger.getALog "DEBUG", '\u001b[36m', console.log #blue


    return (level, msgs...)->
      if _.isString level
        msgs.unshift level
        msgs.unshift '(-)'
        level = 1 # debug unless debugLevel is 0
      else
        msgs.unshift "(#{level})"

      # check @debugLevel if its an instance call (and @debugLevel is defined), else check Logger.debugLevel
      if ( (Logger.debugLevel >= 0) and # negative debugLevel on the static turns debug OFF completely!
           (level <= (if (@ is Logger.logger) or (@debugLevel is undefined) then Logger.debugLevel else @debugLevel))
      ) or (Logger.debugLevel >= 999) # debugLevel that large on the static, prints all debug messages!
            log.apply @, msgs

  prettify:
# @todo: fix this to run on all cases!
    if (__isNode? and __isNode) or not __isNode?
      utilDependency = 'util' # force NOT not to be added by uRequire,
                              # Could have used 'node!util' fake-plugin notation,
                              # that would work fine when converted to UMD.
                              # But what about running it as non-converted (ASIS) on nodejs?
                              # @todo: converted to 'combined' is also a problem - rjs/almond fails...
                              # This way we allow it to run as plain js script, usefull for dev/debuging it!
                              # @todo:(3 5 2) uRequire workaround ?
      do (inspect = require('util').inspect)->
        (o)->
          pretty = "\u001b[0m#{(inspect o, false, null, true)}"
          if _.isArray o
            pretty.replace /\n/g, ''
          if inAgreements o, [_.isObject]
            pretty
          else # _.isString, etc
            o
    else
      (o)->o #todo: check for "can't convert to primitive type"' cases, and convert to string representation.

  # static
  @logger = new Logger 'DefaultLogger'

  # create static class methods for 'log', 'warn', bound with default instance
  for key, val of Logger.prototype
    if _.isFunction(val)
      Logger[key] = _.bind val, Logger.logger
    else
      Logger[key] = val

module.exports = Logger
#
##inline tests
#Logger.debugLevel = -1
#Logger.log 'Static call to .log'
#Logger.warn 'Static call to .warn'
#Logger.debug 'Static call to .debug - NOT PRINTING cause too small DebugLevel'
#
#Logger.debug 0, 'Static call to .debug, debugLevel 0'
#
#Logger.debugLevel = 10
#Logger.debug 'Static call to .debug - PRINTING cause static debugLevel is 10'
#
## Object based
#l = new Logger "MyLogger", 5
#l.log 'My logger logs...', (if o? and o then 'go' else 'dont go'), [{a:"b"}], [1,2,3]
#l.err 'My logger errs...', (if o? and o then 'go' else 'dont go'), [{a:"b"}], [1,2,3]
##l.warn 'My logger logs...', (if o? and o then 'go' else 'dont go'), [{a:"b"}], [1,2,3]
#l.debug 10, 'Instance debug - NOT PRINTING, cause I am configured too high', 10, '\n', [{a:["b", "a"], b:[11,22,33]}], [1,2,3]
#l.debug 5, 'Instance debug - PRINTING, cause I am configured low', 5, '\n', [{a:["b", "a"], b:[11,22,33]}], [1,2,3]
