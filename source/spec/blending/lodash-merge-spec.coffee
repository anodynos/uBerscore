assert = chai.assert
expect = chai.expect

describe "lodash's `merge` :", ->
#  require('./deepExtend-examples-SharedSpecs') _.merge #dont work, they are placeholder/replaceRE ${} based!
  require('./shared/lodashMerge-specs') _.merge
  require('./shared/lodashMerge_Blender-specs') _.merge

