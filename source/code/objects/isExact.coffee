###
  Shortcut of isEqual with default options = { exact: true }
###
isEqual = (require './isEqual')

isExact = (a, b, callback, ctx, options={})->
  options.exact = true
  isEqual a, b, callback, ctx, options

module.exports = isExact