define -> describe "ArrayizeBlender:", ->

  describe "arrayizeBlender:", ->
    arrayizeBlender = new _B.ArrayizeBlender

    it "pushes ALL source array items into destination array", ->
      deepEqual arrayizeBlender.blend([1, 2, 3], [1,2,   4, 5, 6, '7']),
                                      [1, 2, 3,   1,2,   4, 5, 6, '7']

    describe "pushes source array items into non-array destination, arrayize'ing it first", ->
      it "Number", ->
        deepEqual arrayizeBlender.blend(123, [4, 5, 6]), [123, 4, 5, 6]

      it "String", ->
        deepEqual arrayizeBlender.blend('123', [4, 5, undefined, 6]),
                                       ['123', 4, 5, undefined, 6]

      it "RegExp", ->
        deepEqual arrayizeBlender.blend(/./, [4, 5, null, 6]),
                                        [/./, 4, 5, null, 6]

      it "`undefined` pushes nothing", ->
        deepEqual arrayizeBlender.blend(undefined, ['1', '2', '3']),
                                                   ['1', '2', '3']

      it "`null` pushes nothing", ->
        deepEqual arrayizeBlender.blend(null, ['1', '2', '3']),
                                              ['1', '2', '3']

    describe "pushes source non-array item into array destination:", ->
      it "String", ->
        deepEqual arrayizeBlender.blend(['1', '2', '3'], '456'),
                                        ['1', '2', '3', '456']

      it "RegExp", ->
        regExp = /./
        deepEqual arrayizeBlender.blend(['1', '2', '3'], regExp),
                                        ['1', '2', '3', regExp]

      it "Source of `undefined` or `null` push nothing", ->
        deepEqual arrayizeBlender.blend(['1', '2', '3'], undefined),
                                        ['1', '2', '3']

        deepEqual arrayizeBlender.blend(['1', '2', '3'], null),
                                        ['1', '2', '3']

    describe "pushes non-array items onto each other", ->
      it "String->String", ->
        deepEqual arrayizeBlender.blend('123', '456'),
                                        ['123', '456']

      it "String->RegExp", ->
        regExp = /./
        deepEqual arrayizeBlender.blend('123', regExp),
                                       ['123', regExp]

      it "RegExp->String", ->
        deepEqual arrayizeBlender.blend(/./, '123'),
                                       [/./, '123']

    describe "Reseting the destination array with signpost `[null]` as 1st src item", ->
      dstArray = ['items', 'to be', 'removed']
      result = arrayizeBlender.blend dstArray, [[null], 11, 22, 33]

      it "resets destination array to a new one ", ->
        notEqual result, dstArray

      it "resets destination array & then pushes - ", ->
        deepEqual result, [11, 22, 33]

    describe "Arrays with reference values:", ->
      dstArray = [{a:1}, {b:2}, {c:3}]
      srcArray = [{d:4}, {e:5}, {f:6}]
      result = arrayizeBlender.blend dstArray, srcArray

      it "All refs are pushed to destination & result is dstArray", ->
        deepEqual result, dstArray
        deepEqual result, [dstArray[0], dstArray[1], dstArray[2],
                                      srcArray[0], srcArray[1], srcArray[2]]

      it "leaves dst items untouched", ->
        for i in [0..2]
          equal result[i], dstArray[i]

      it "leaves source items untouched, pushed as exact refs to destination", ->
        for i in [0..2]
          equal result[i+3], srcArray[i]

  describe "arrayizeUniqueBlender:", ->
    arrayizeUniqueBlender = new _B.ArrayizeBlender [], unique: true

    it "has unique:true", ->
      tru arrayizeUniqueBlender.unique

    it "pushes only === unique items", ->
      deepEqual arrayizeUniqueBlender.blend(
          [1, 4, 2, 3], [1,2,4,     5, 6, '7']
      ),  [1, 4, 2, 3,              5, 6, '7']

  describe "arrayizeUnshiftingBlender:", ->
    arrayizeUnshiftingBlender = new _B.ArrayizeBlender [], addMethod: 'unshift'

    it "has addMethod:unshift", ->
      equal arrayizeUnshiftingBlender.addMethod, 'unshift'

    it "unshifts (instead of pushing) items", ->
      deepEqual arrayizeUnshiftingBlender.blend(
         [1, 2, 3, 4], [5, 6, '7', 8], 9, [10, 11], 12
      ), [12,    11, 10,    9,    8, '7', 6, 5,     1, 2, 3, 4]

  describe "arrayizeUnshiftingReverseBlender:", ->
    arrayizeUnshiftingBlender = new _B.ArrayizeBlender [], {addMethod: 'unshift', reverse: true}

    it "has right flags", ->
      equal arrayizeUnshiftingBlender.addMethod, 'unshift'
      equal arrayizeUnshiftingBlender.reverse, true

    it "unshifts (instead of pushing) items, in reverse order (hence source arrays remain in right order)", ->
      deepEqual arrayizeUnshiftingBlender.blend(
         [1, 2, 3, 4],     [5, 6, '7', 8],    9,    [10, 11], 12
      ), [12,    10, 11,    9,    5, 6, '7', 8,     1, 2, 3, 4]

