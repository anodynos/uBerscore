###
  Just like _.isEqual BUT with more options :
    * `inherited` : if true, it checks all properties of inheritance chain (__proto_ chain)
       for both a & b and decides if their root-level properties are also isEqual ,,,options
    * `exclude`: array of exclusions, default is ['constructor']
###
_ = require 'lodash'

isEqual = (a, b, callback, thisArg, options={
    inherited:false
    exclude: ['constructor']
  })->
      if _.isEqual(a, b)
        return true

      if options.inherited
        if (not a or not b)
          return false

        allProps = _.union (p for p of a), (p for p of b)

        for prop in allProps when (_.isArray(options.exclude) and prop not in options.exclude)
          if not isEqual a[prop], b[prop], callback, thisArg, options # 2nd chance: use isEqual instead as last resort!
            return false

        return true

      false

module.exports = isEqual