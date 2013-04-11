assert = chai.assert
expect = chai.expect

l = new _B.Logger 'Blender-spec', 0

describe 'Blender / blend :', ->

  deepExtendblender = new _B.DeepExtendBlender

  require('./shared/deepExtendExamples-specs') deepExtendblender.blend

  # default Blender should behave like lodash.merge,
  # with the exception of ignoring undefined:
  lodashMergeLike_blender = new _B.Blender(
    order: ['src']
    '|':
      'Undefined':-> _B.Blender.SKIP
      #'Null':-> @SKIP _.merge changed this - it overwrites normally.
  )
  require('./shared/lodashMerge-specs') lodashMergeLike_blender.blend

  require('./shared/lodashMerge_Blender-specs') lodashMergeLike_blender.blend

  #todo: require require('./jQueryExtend-SharedSpecs') jQueryExtendBlender.blend

describe 'Blender.shortifyTypeNames : ', ->

  it "corectly transforms nested types of srcDstSpecs to short format", ->
    longTypeNames = {
      order: ['src', 'dst']
      Array: String:'someAction'
      Object:
        "Array": "doSomeAction"
        "Null": ->

      doSomeAction:->
    }

    expectedShortified = {
      order: [ 'src', 'dst' ]
      doSomeAction: longTypeNames.doSomeAction # copy function ref
      '[]': "''": 'someAction'
      '{}':
        '[]': 'doSomeAction'
        'null': longTypeNames.Object.Null
    }

    expect(
      _B.Blender.shortifyTypeNames longTypeNames
    ).to.deep.equal expectedShortified