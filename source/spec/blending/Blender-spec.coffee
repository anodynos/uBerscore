assert = chai.assert
expect = chai.expect

l = new _B.Logger 'Blender-spec', 0

describe 'Blender / blend :', ->

  deepExtendLike_blender = new _B.DeepExtendBlender

  require('./shared/deepExtendExamples-specs') deepExtendLike_blender.blend

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

  # Blender - only specs!
#  {
#    order: ['dst','src'],
#    Array: Array: (prop, src, dst)-> @printIt(prop, src, dst); @NEXT
#    String:
#      Array: (prop, src, dst)->
#        l.debug 'An [] landed on a String!'
#        @print(prop, src, dst)
#        @overwrite(prop, src, dst)
#
#        ["""
#          '#{dst[prop]}' - the following Array landed on preceding String!
#                           #{(i for i in src[prop]).join '|'}
#        """]
#  }


describe 'Blender.shortifyTypeNames : ', ->

  it "corectly transforms nested types of srcDstSpecs to short format", ->
    long = {
      order: ['src', 'dst']
      Array: String:'someAction'
      Object:
        "Array": "doSomeAction"
        "Null": ->

      doSomeAction:->
    }

    expectedShortified = {
      order: [ 'src', 'dst' ]
      doSomeAction: long.doSomeAction # copy function ref
      '[]': "''": 'someAction'
      '{}':
        '[]': 'doSomeAction'
        'null': long.Object.Null
    }

    expect(
      _B.Blender.shortifyTypeNames long
    ).to.deep.equal expectedShortified