assert = chai.assert
expect = chai.expect

describe "ArrayizePushBlender:", ->

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


    it "resets destination array & then pushes - using signpost `[null]` as 1st src item", ->
      expect(
        arrayizePusher.blend ['items', 'to be', 'removed'], [[null], 11, 22, 33]
      ).to.deep.equal [11, 22, 33]


  describe "arrayizeUniquePusher:", ->
    arrayizeUniquePusher = new _B.ArrayizePushBlender [], unique: true

    it "has unique:true", ->
      expect(arrayizeUniquePusher.unique).to.be.true

    it "pushes only === unique items", ->
      expect(
        arrayizeUniquePusher.blend [1, 4, 2, 3], [1,2,4,     5, 6, '7']
      ).to.deep.equal [1, 4, 2, 3, 5, 6, '7']


