assert = chai.assert
expect = chai.expect

describe 'deepExtend :', ->
  require('./deepExtend-examples-SharedSpecs') _B.deepExtend
  require('./lodashMerge-tests-SharedSpecs') _B.deepExtend # shadowed properties are supported in coffeescript adaptation
  require('./common-SharedSpecs') _B.deepExtend

