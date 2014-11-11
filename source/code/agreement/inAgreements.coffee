arrayize = require '../collections/array/arrayize'
isAgree = require './isAgree'

###
  @param o {Anything} an item to check through filters

  @param filters {Anything} One or more `filter`s to pass on `isAgree`

  @return true if o `isAgree` with any `filter`s, false otherwise
###
module.exports = (o, agreements)->
  agreements = arrayize agreements

  if _.isEmpty agreements
    return false
  else
    for agr in agreements
      if isAgree o, agr
        return true
  false



