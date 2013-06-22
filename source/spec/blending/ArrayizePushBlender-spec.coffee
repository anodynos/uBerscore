assert = chai.assert
expect = chai.expect

describe "ArrayizePushBlender:", ->

  describe "arrayizePusher:", ->
    arrayizePusher = new _B.ArrayizePushBlender

    it "pushes ALL source array items into destination array", ->
      expect(
        arrayizePusher.blend [1, 2, 3], [1,2,   4, 5, 6, '7']
      ).to.deep.equal [1, 2, 3,    1,2,   4, 5, 6, '7']

    it "pushes source array items into non-array destination, arrayize'ing it first", ->
      expect(
        arrayizePusher.blend 123, [4, 5, 6]
      ).to.deep.equal [123, 4, 5, 6]

    it "pushes source non-array (but a String) item into array destination", ->
      expect(
        arrayizePusher.blend ['1', '2', '3'], '456'
      ).to.deep.equal ['1', '2', '3', '456']

    it "pushes non-array (but Strings) items onto each other", ->
      expect(
        arrayizePusher.blend '123', '456'
      ).to.deep.equal ['123', '456']

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


