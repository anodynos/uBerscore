define -> describe "ArrayizePushBlender:", ->

  describe "arrayizePusher:", ->
    arrayizePusher = new _B.ArrayizePushBlender

    it "pushes ALL source array items into destination array", ->
      expect(
        arrayizePusher.blend [1, 2, 3], [1,2,   4, 5, 6, '7']
      ).to.deep.equal [1, 2, 3,    1,2,   4, 5, 6, '7']

    describe "pushes source array items into non-array destination, arrayize'ing it first", ->
      it "Number", ->
        expect(
          arrayizePusher.blend 123, [4, 5, 6]
        ).to.deep.equal [123, 4, 5, 6]

      it "String", ->
        expect(
          arrayizePusher.blend '123', [4, 5, undefined, 6]
        ).to.deep.equal ['123', 4, 5, undefined, 6]

      it "RegExp", ->
        expect(
          arrayizePusher.blend /./, [4, 5, null, 6]
        ).to.deep.equal [/./, 4, 5, null, 6]


      it "`undefined` pushes nothing", ->
        expect(
          arrayizePusher.blend undefined, ['1', '2', '3']
        ).to.deep.equal ['1', '2', '3']

      it "`null` pushes nothing", ->
        expect(
          arrayizePusher.blend null, ['1', '2', '3']
        ).to.deep.equal ['1', '2', '3']

    describe "pushes source non-array item into array destination:", ->
      it "String", ->
        expect(
          arrayizePusher.blend ['1', '2', '3'], '456'
        ).to.deep.equal ['1', '2', '3', '456']

      it "RegExp", ->
        regExp = /./
        expect(
          arrayizePusher.blend ['1', '2', '3'], regExp
        ).to.deep.equal ['1', '2', '3', regExp]

      it "Source of `undefined` or `null` push nothing", ->
        expect(
          arrayizePusher.blend ['1', '2', '3'], undefined
        ).to.deep.equal ['1', '2', '3']

        expect(
          arrayizePusher.blend ['1', '2', '3'], null
        ).to.deep.equal ['1', '2', '3']

    describe "pushes non-array items onto each other", ->
      it "String->String", ->
        expect(
          arrayizePusher.blend '123', '456'
        ).to.deep.equal ['123', '456']

      it "String->RegExp", ->
        regExp = /./
        expect(
          arrayizePusher.blend '123', regExp
        ).to.deep.equal ['123', regExp]

      it "RegExp->String", ->
        expect(
          arrayizePusher.blend /./, '123'
        ).to.deep.equal [/./, '123']

    describe "Reseting the destination array with signpost `[null]` as 1st src item", ->
      dstArray = ['items', 'to be', 'removed']
      result = arrayizePusher.blend dstArray, [[null], 11, 22, 33]

      it "resets destination array to a new one ", ->
        expect(result).to.not.equal dstArray

      it "resets destination array & then pushes - ", ->
        expect(result).to.deep.equal [11, 22, 33]

    describe "Arrays with reference values:", ->
      dstArray = [{a:1}, {b:2}, {c:3}]
      srcArray = [{d:4}, {e:5}, {f:6}]
      result = arrayizePusher.blend dstArray, srcArray

      it "All refs are pushed to destination & result is dstArray", ->
        expect(result).to.equal dstArray
        expect(result).to.deep.equal [dstArray[0], dstArray[1], dstArray[2],
                                      srcArray[0], srcArray[1], srcArray[2]]

      it "leaves dst items untouched", ->
        for i in [0..2]
          expect(result[i]).to.equal dstArray[i]

      it "leaves source items untouched, pushed as exact refs to destination", ->
        for i in [0..2]
          expect(result[i+3]).to.equal srcArray[i]


  describe "arrayizeUniquePusher:", ->
    arrayizeUniquePusher = new _B.ArrayizePushBlender [], unique: true

    it "has unique:true", ->
      expect(arrayizeUniquePusher.unique).to.be.true

    it "pushes only === unique items", ->
      expect(
        arrayizeUniquePusher.blend [1, 4, 2, 3], [1,2,4,     5, 6, '7']
      ).to.deep.equal [1, 4, 2, 3, 5, 6, '7']


