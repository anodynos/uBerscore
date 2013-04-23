assert = chai.assert
expect = chai.expect

describe 'objects/getValueAtPath ', ->

  o =
    '$':
      bundle:
        anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
        '*': IamA: "defaultValue"
        dependencies:
          variableNames: "Bingo"
        someOtherKey:
          '*': notReached: "defaultValue"
          '#': terminal: "Value"

  describe 'basic tests - retrieving value: ', ->

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
        _B.getValueAtPath o, '$.bundle.dependencies.', separator: '.'
      ).to.deep.equal variableNames: 'Bingo'

    it "undefined, for non existent key", ->
      expect(
        _B.getValueAtPath o, '$/bundle/dependencies/variableNames/notfound'
      ).to.deep.equal undefined

    it "undefined, for path of inexistent keys, with alt sep", ->
      expect(
        _B.getValueAtPath o, '$>bundle>dependencies>variableNames>notfound>stillNotFound>', separator: '>'
      ).to.deep.equal undefined

  describe 'retrieving value using default:', ->

    it "non existent key, but a default in its place", ->
      expect(
        _B.getValueAtPath o, '$/bundle/someNonFoundKey/'
      ).to.deep.equal IamA: "defaultValue"

    it "non existent key, but a default in its place, goin on", ->
      expect(
        _B.getValueAtPath o, '$/bundle/someNonFoundKey/IamA'
      ).to.deep.equal "defaultValue"

    it "non existent key, but a default in its palce, went too far", ->
      expect(
        _B.getValueAtPath o, '$/bundle/someNonFoundKey/tooFar'
      ).to.deep.equal undefined

  describe 'retrieving value using terminal:', ->
    it "non existent key, but a terminal in its palce - default is ignored", ->
      expect(
        _B.getValueAtPath o, '$/bundle/someOtherKey/someNonFoundKey/'
      ).to.deep.equal terminal: "Value"

    it "non existent key, a terminal in its palce, going on dosn't matter", ->
      expect(
        _B.getValueAtPath o, '$/bundle/someOtherKey/someNonFoundKey/terminal'
      ).to.deep.equal terminal: "Value"

    it "non existent key, a terminal in its palce, going too far dosn't matter", ->
      expect(
        _B.getValueAtPath o, '$/bundle/someOtherKey/someNonFoundKey/goingTooFar/IsIgnored/'
      ).to.deep.equal terminal: "Value"
