define ->
  _lodash_dummy_var = require 'lodash'

  if _B.deepExtend # removed in 'uberscore-min.js'
    describe 'deepExtend :', ->
      require('./shared/deepExtendExamples-specs') _B.deepExtend
      require('./shared/lodashMerge-specs') _B.deepExtend # shadowed properties are supported in deepExtend's coffeescript adaptation
      #require('./shared/lodashMerge_Blender-specs') _B.deepExtend # Does it work ?

  describe 'DeepExtendBlender', ->
    deepExtendblender = new _B.DeepExtendBlender
    require('./shared/deepExtendExamples-specs') deepExtendblender.blend
