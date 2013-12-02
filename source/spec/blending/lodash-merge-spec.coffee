define ->
  if _B.isLodash()
    describe "lodash's `merge` :", ->
    #  require('./deepExtend-examples-SharedSpecs') _.merge #dont work, they are placeholder/replaceRE ${} based!
      require('./shared/lodashMerge-specs') _.merge
      require('./shared/lodashMerge_Blender-specs') _.merge

  describe 'lodash.merge-like blender', ->
    # default Blender should behave like lodash.merge,
    # with the exception of ignoring undefined:
    lodashMerge_like_blender = new _B.Blender {
      order: ['src']
      'Undefined':-> _B.Blender.SKIP
        #'Null':-> @SKIP _.merge changed this - it overwrites normally.
    }
    require('./shared/lodashMerge-specs') lodashMerge_like_blender.blend
    require('./shared/lodashMerge_Blender-specs') lodashMerge_like_blender.blend

    #todo: require require('./jQueryExtend-SharedSpecs') jQueryExtendBlender.blend
