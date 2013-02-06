assert = chai.assert
expect = chai.expect

describe 'Blender / blend :', ->

  deepExtendLike_blender = new _B.Blender [{
    order: ['src', 'dst']
    '[]': '[]': (prop, src, dst)-> _.reject @deepOverwrite(prop, src, dst), (v)-> v is null
  }]

  require('./deepExtend-examples-SharedSpecs') deepExtendLike_blender.blend

  blender = new _B.Blender()
  require('./lodashMerge-tests-SharedSpecs') blender.blend

  require('./common-SharedSpecs') blender.blend
