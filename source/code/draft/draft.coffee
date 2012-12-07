_ = require 'lodash'

#cs = require 'coffee-script'
#source = "eat food for food ina ['aa', 'bb']"
#console.log cs.compile source, {bare:true}

uBer = require '../../../build/dist/uBerscore-dev'
uBer.go {a:1, b:5}, iter: (v)-> console.log(v)

#uRequire = require 'urequire'
#_fs = require 'fs'
#options = require '../uRequireConfig'
#
#bp = new uRequire.BundleProcessor(options)
#bp.processBundle();
a = [1,2,3]

console.log undefined in a

###!
function double(value) { return value * 2; }

_([42, 43]).chain()
   .first()            // 42
   .take(double)       // Applies double to 42: 84
   .tap(console.log);

take: (obj, interceptor, context) ->
  interceptor.call context, obj
###

#dynamic_tests = (item)->
#  if item.val is 'call'
#    r = read 'call', 'parent'
#    if r.name is 'define'
#      if r .args
#
#  if a > b
#    log 'wow'
#    action = 'dive'
#  else
#    action = 'back'
#
#  action:action
#  dive:
#    awe: ['bla', 'blou']
#    boo: ->
#      log @awe
#      if 'bla' in @awe
#        'bingo'
#
#  back:
#    awe: ['tata', 'lou']
#    boo: ->
#      log @awe
#      if 'lou' in @awe
#        'yes'
#

#### NEW :
#myObj =
#  enabled: true # enabled level 1
#
#  marika:
#    enabled: false # enabled level 2
#    pentagiotisa: if $enabled then 'yes' else 'no' # 'no' - reads 'enabled level 2', cause its closer
#
#  paparies:
#     kaliviotikes: if $enabled then 'wow' else 'no' # 'wow' - reads 'enabled level 1', cause its the only one
####
