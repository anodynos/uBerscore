# grabbed from github.com/dominictarr/inspect

# Coffeescript translation by github.com/anodynos, using js2coffee
# #todo:(2 2 1) clone dominictarr/inspect, PR, make npm-package
#
#  currently this just does what util.inspect does
#  (although with refs)
#
#  i will change this from inspect, to 'render'
#
#  and add ways to control, say, white space,
#  and how individual items are written out,
#  add support for styling, and even HTML generation.
#
#  I also need something which colour codes assertion messages.
#  i.e. colour matching items green, and mismatching items red,
#  uncompared items yellow..
#
#  and for a while I've thought that colour coding levels of indentation would be interesting.
#

inspect = (x) ->
  complex = (x) ->
    x and ("object" is typeof x or "function" is typeof x)
  repeats = (x) ->
    for i of x
      index = values.indexOf(x[i])  if complex(x[i])
      if index is -1
        values.push x[i]
        repeats x[i]
      else
        uses[index] = true
  #else { return JSON.stringify(x) }
  varName = (x, assign) ->
    index = newValues.indexOf(x)
    (if index isnt -1 then ("REF" + index + ((if assign then " = " else ""))) else "")
  isFunction = (f) ->
    return ""  if "function" isnt typeof f
    name = /function (\w*\(\w*\))/.exec("" + f)
    "function" + ((if name then (" " + name[1]) else ""))
  len = (x) ->
    l = 0
    x.forEach (e) ->
      l = l + ((if e then e.length else 0)) + 2

    l
  spaces = (indent) ->
    s = ""
    s += " "  while s.length < indent
    s
  format = (pre, func, ary, indent, array) ->
    open = undefined
    close = undefined
    if array or "function" is typeof func
      open = "["
      close = "]"
    else
      open = "{"
      close = "}"
    f = isFunction(func)
    l = pre.length + f.length + len(ary) + indent
    return pre + open + f + close  if ary.length is 0 and f isnt ""
    if l > 80
      f = f + "\n"  unless f is ""
      pre = pre + "\n  "  unless pre is ""
      open = open + " "
      close = " " + close
      pre + open + f + ary.join("\n" + spaces(indent) + ", ") + close
    else
      f = f + " "  unless f is ""
      pre + open + f + ary.join(", ") + close
  formatString = (x, spaces) ->
    return JSON.stringify(x)  if x.indexOf("\n") is -1
    list = x.split("\n")
    last = list.pop()
    list = list.map((i) ->
      i + "\n"
    )
    list.push last
    s = "" + JSON.stringify(list.shift())
    list.forEach (e) ->
      s += "\n+ " + JSON.stringify(e)

    s
  stringify = (x, spaces) ->
    if wrote.indexOf(x) is -1
      if x instanceof Array
        wrote.push x
        ary = x.map((v, k) ->
          stringify v, spaces + 2
        )
        pre = varName(x, true)
        format pre, null, ary, spaces, true
      else if complex(x)
        wrote.push x
        obj = []
        pre = varName(x, true)
        for i of x
          obj.push i + ": " + stringify(x[i], spaces + 2)
        format pre, x, obj, spaces, false

      #
      #        return varName(x,true) + checkFunction(x, obj)
      #
      else if "string" is typeof x
        formatString x, spaces
      else
        JSON.stringify x
    else
      varName x
  values = []
  uses = {}
  repeats x  if complex(x)
  newValues = []
  for i of values
    newValues.push values[i]  if uses[i]
  wrote = []
  stringify x, 0

module.exports = {} #inspect


#x = "123456767891011121314151617181920"
#expected = [x, x, x, x, x, x, x]
#expected2 = [1, 2, x, 5, 6, 7, 8, 9,
#  a: x
#, 12, expected, 14, 15, 16, expected, 30]
#expected3 =
#  a: x
#  b: x
#  c: x
#  d: x
#  e: x
#  f: x
#
#expected4 = expected
#expected4[4] = expected3
#console.log inspect(expected)
#console.log inspect(expected2)
#console.log inspect(expected3)



#function inspect(x){
#
#  var values = []
#    , uses = {}
#
#    function complex(x){
#      return (x && ('object' === typeof x || 'function' === typeof x))
#    }
#    function repeats (x){
#      for(i in x){
#        if(complex(x[i]))
#          var index = values.indexOf(x[i])
#          if(index == -1) {
#            values.push(x[i])
#            repeats(x[i])
#          } else {
#            uses[index] = true
#          }
#      }
#    }
#
#  if (complex(x)) { repeats(x) } //else { return JSON.stringify(x) }
#
#  var newValues = []
#  for(i in values){
#    if(uses[i]){
#      newValues.push(values[i])
#    }
#  }
#  function varName(x,assign){
#    var index = newValues.indexOf(x)
#    return index !== -1 ? ("REF" + index + (assign ? " = " : "")) : ""
#  }
#
#  wrote = []
#
#  function isFunction(f){
#    if('function' !== typeof f)
#      return ''
#    name = /function (\w*\(\w*\))/.exec("" + f)
#    return "function" + (name ? (' ' + name[1] ) : "")
#  }
#
#  function len (x){
#    var l = 0
#    x.forEach(function (e){
#      l = l + (e ? e.length : 0)  + 2
#    })
#    return l
#  }
#  function spaces(indent){
#    var s = ""
#    while (s.length < indent){
#      s += " "
#    }
#    return  s
#  }
#  function format(pre,func,ary,indent,array){
#    var open,close;
#    if (array || 'function' == typeof func) { open = '['; close = ']' }
#    else       { open = '{'; close = '}' }
#    var f = isFunction(func)
#    var l = pre.length + f.length + len (ary) + indent
#
#    if(ary.length == 0 && f != ''){
#      return pre + open + f + close
#      }
#    if (l > 80){
#      if(f != '') f = f + '\n'
#      if(pre != '') pre = pre + '\n  '
#      open = open + ' '
#      close = ' ' + close
#      return pre + open + f + ary.join("\n" + spaces(indent) + ", ") + close
#    } else {
#      if(f != '') f = f + ' '
#      return pre + open + f + ary.join(", ") + close
#    }
#  }
#  function formatString(x,spaces){
#    if(x.indexOf('\n') == -1){
#      return JSON.stringify(x)
#      }
#    var list = x.split('\n')
#      , last = list.pop()
#
#    list = list.map(function(i){return i + '\n'})
#    list.push(last)
#    var s = '' + JSON.stringify(list.shift())
#
#      list.forEach(function (e){
#        s += '\n+ ' + JSON.stringify(e)
#      })
#      return s
#  }
#
#  function stringify (x,spaces){
#    if(wrote.indexOf(x) === -1) {
#      if (x instanceof Array){
#        wrote.push(x)
#        var ary = x.map(function(v,k){return stringify(v,spaces + 2)})
#          , pre = varName(x,true)
#        return format(pre,null,ary,spaces,true)
#
#      } else if (complex(x)) {
#        wrote.push(x)
#        var obj = []
#        var pre = varName(x,true)
#        for(i in x){
#          obj.push(i  + ": " +  stringify(x[i],spaces + 2))
#        }
#        return format(pre,x,obj,spaces,false)
#        /*
#        return varName(x,true) + checkFunction(x, obj)
#        */
#      } else if ('string' == typeof x){
#        return formatString(x,spaces)
#      } else  {
#        return JSON.stringify(x)
#      }
#    } else {
#      return varName(x)
#    }
#  }
#
#  return stringify(x,0)
#}
#
#
#module.exports = inspect;

# examples.js
# var x = "123456767891011121314151617181920"
#   , expected = [x,x,x,x,x,x,x]
#   , expected2 = [1,2,x,5,6,7,8,9,{a:x},12,expected,14,15,16,expected,30]
#   , expected3 =
#    { a: x
#    , b: x
#    , c: x
#    , d: x
#    , e: x
#    , f: x }
#    , expected4 = expected
#      expected4[4] = expected3
#
#    console.log(inspect(expected))
#    console.log(inspect(expected2))
#    console.log(inspect(expected3))
#    console.log(inspect(require))
