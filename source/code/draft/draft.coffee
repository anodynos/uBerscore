_fs = require 'fs'
copyFileSync = (srcFile, destFile) ->
  BUF_LENGTH = 64*1024
  buff = new Buffer(BUF_LENGTH)
  fdr = _fs.openSync(srcFile, 'r')
  fdw = _fs.openSync(destFile, 'w')
  bytesRead = 1
  pos = 0
  while bytesRead > 0
    bytesRead = _fs.readSync(fdr, buff, 0, BUF_LENGTH, pos)
    _fs.writeSync(fdw,buff,0,bytesRead)
    pos += bytesRead
  _fs.closeSync(fdr)
  _fs.closeSync(fdw)

copyFileSync 'draft.coffee', 'draft2.coffee'


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
