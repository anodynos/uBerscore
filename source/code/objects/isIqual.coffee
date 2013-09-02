###
  shortcut of isEqual with default options = {
                            inherited: true
                            exclude: ['constructor']
                        }
###
isEqual = (require './isEqual')

isIqual = (a, b, callback, ctx, options={})->
  options.inherited = true
  (options.exclude or= []).push 'constructor'
  isEqual a, b, callback, ctx, options

module.exports = isIqual
