###
  shortcut of isEqual with default options = {
                            inherited: true
                            exclude: ['constructor']

                            exact: true
                        }
###
isIqual = (require './isIqual')

isIxact = (a, b, callback, ctx, options={})->
  options.exact = true
  isIqual a, b, callback, ctx, options

module.exports = isIxact
