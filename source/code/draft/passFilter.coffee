_ = require 'lodash'
arrayize = require '../arrayize'
inFilters = require '../agreement/inFilters'


###
  return a function that returns true or false for a given String:
         * must match/exist in include [] (or include is null/empty)
         * must NOT match/exist in exclude [] (or exclude is null/empty)
###

makeFilter = (include, exclude)->
      inFilters(o, include) and
        ( _.isEmpty(exclude) or not inFilters(o, exclude) )


compiledFiles = /.*\.(coffee|iced|coco)$/i
jsFiles = /.*\.(js|javascript)$/i

include = [jsFiles, compiledFiles, 'papari.txt', (o)->o is 'loulou.gif' ]
exclude = [/.*lalakis.*/, /.*\.coffee$/i]

libs = [
  'file.coffee'
  'lalakis.coffee'
  'superlalakis.js'
  'papari.txt'
  'loulou.gif'
  'bla.js'
]


console.log fl,":", fltr fl for fl in libs