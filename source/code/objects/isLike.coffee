###
  Shortcut of isEqual with default options = { like: true }
###
isEqual = (require './isEqual')

isLike = (a, b, callback, ctx, options={})->
  options.like = true
  isEqual a, b, callback, ctx, options

module.exports = isLike
