###
  Takes object o & returns a fn, that returns `o[key] ? 'defaultKey value'`, i.e o[defaultKey]
  defaultKey defaults to '*'


  @param o {Object} The object to query for keys
  @param default {String} The defaults key name to return, "*" if not given
  @return function(key) that returns value for key, or default value (if undefined)
###
certain = (o, defaultKey = "*")->
  (key)-> o[key] ? o[defaultKey]

module.exports = certain