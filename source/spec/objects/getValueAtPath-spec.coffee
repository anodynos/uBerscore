assert = chai.assert
expect = chai.expect

describe 'objects/getValueAtPath ', ->

  o =
    '$':
      bundle:
        anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
        dependencies:
          variableNames: "Bingo"


  describe 'retrieving value: ', ->

    it "primitive", ->
      expect(
        _B.getValueAtPath o, '$/bundle/dependencies/variableNames'
      ).to.deep.equal 'Bingo'

    it "object", ->
      expect(
        _B.getValueAtPath o, '$/bundle/dependencies'
      ).to.deep.equal variableNames: 'Bingo'

    it "object, with sep at end", ->
      expect(
        _B.getValueAtPath o, '$/bundle/dependencies/'
      ).to.deep.equal variableNames: 'Bingo'

    it "array item (3rd)", ->
      expect(
        _B.getValueAtPath o, '$/bundle/anArray/2/'
      ).to.deep.equal 'arrayItem3': 3

    it "property of (3rd) array item ", ->
      expect(
        _B.getValueAtPath o, '$/bundle/anArray/2/arrayItem3'
      ).to.deep.equal 3

    it "object, with alternative sep", ->
      expect(
        _B.getValueAtPath o, '$.bundle.dependencies.', '.'
      ).to.deep.equal variableNames: 'Bingo'

    it "undefined, for non existent key", ->
      expect(
        _B.getValueAtPath o, '$/bundle/dependencies/variableNames/notfound'
      ).to.deep.equal undefined

    it "undefined, for path of inexistent keys, with alt sep", ->
      expect(
        _B.getValueAtPath o, '$>bundle>dependencies>variableNames>notfound>stillNotFound>', '>'
      ).to.deep.equal undefined