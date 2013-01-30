assert = chai.assert
expect = chai.expect

describe 'Blender / blend :', ->
  require('./deepExtend-examples-SharedSpecs') _B.Blender()
  require('./lodashMerge-tests-SharedSpecs') _B.Blender()
  require('./common-SharedSpecs') _B.Blender()
