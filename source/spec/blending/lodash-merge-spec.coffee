assert = chai.assert
expect = chai.expect

describe "lodash's `merge` :", ->
#  require('./deepExtend-examples-SharedSpecs') _.merge #dont work, they are placeholder/parentRE #{} based!
  require('./lodashMerge-tests-SharedSpecs') _.merge
  require('./common-SharedSpecs') _.merge

