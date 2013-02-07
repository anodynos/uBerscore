assert = chai.assert
expect = chai.expect

describe 'deepExtend :', ->
  require('./shared/deepExtendExamples-specs') _B.deepExtend
  require('./shared/lodashMerge-specs') _B.deepExtend # shadowed properties are supported in deepExtend's coffeescript adaptation
  #require('./shared/lodashMerge_Blender-specs') _B.deepExtend # Does it work ?

