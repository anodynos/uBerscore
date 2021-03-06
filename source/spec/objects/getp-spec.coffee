describe 'objects/getp ', ->
  o =
    '$':
      bundle:
        anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
        '*': IamA: "defaultValue"
        dependencies:
          depsVars: "Bingo"
        someOtherKey:
          '*': notReached: "defaultValue"
          '#': IamA: Stop: "Value"
        leadingToTerminate:
          '|': terminated: 'terminated value'
          someKey: someOtherKey: 'someValue'

  describe 'basic tests - retrieving value: ', ->

    it "primitive", ->
      expect(
        _B.getp o, '$/bundle/dependencies/depsVars'
      ).to.deep.equal 'Bingo'

    it "object", ->
      expect(
        _B.getp o, '$/bundle/dependencies'
      ).to.deep.equal depsVars: 'Bingo'

    it "object, with sep at end", ->
      expect(
        _B.getp o, '$/bundle/dependencies/'
      ).to.deep.equal depsVars: 'Bingo'

    it "array item (3rd)", ->
      expect(
        _B.getp o, '$/bundle/anArray/2/'
      ).to.deep.equal 'arrayItem3': 3

    it "property of (3rd) array item ", ->
      expect(
        _B.getp o, '$/bundle/anArray/2/arrayItem3'
      ).to.deep.equal 3

    it "object, with alternative sep", ->
      expect(
        _B.getp o, '$.bundle.dependencies.', separator: '.'
      ).to.deep.equal depsVars: 'Bingo'

    it "undefined, for non existent key", ->
      expect(
        _B.getp o, '$/bundle/dependencies/depsVars/notfound'
      ).to.deep.equal undefined

    it "undefined, for path of inexistent keys, with alt sep", ->
      expect(
        _B.getp o, '$>bundle>dependencies>depsVars>notfound>stillNotFound>', separator: '>'
      ).to.deep.equal undefined

  describe 'retrieving value using *defaultKey*:', ->

    it "non existent key, but a defaultKey in its place", ->
      expect(
        _B.getp o, '$/bundle/someNonFoundKey/'
      ).to.deep.equal IamA: "defaultValue"

    it "non existent key, but a defaultKey in its place, goin on", ->
      expect(
        _B.getp o, '$/bundle/someNonFoundKey/IamA'
      ).to.deep.equal "defaultValue"

    it "non existent key, but a defaultKey in its palce, went too far", ->
      expect(
        _B.getp o, '$/bundle/someNonFoundKey/tooFar'
      ).to.deep.equal undefined

  describe 'retrieving value using *stopKey*:', ->
    it "non existent key, but a stopKey key in its place - defaultKey is ignored", ->
      expect(
        _B.getp o, '$/bundle/someOtherKey/someNonFoundKey/'
      ).to.deep.equal IamA: Stop: "Value"

    it "non existent key, a terminal in its place, going on dosn't matter", ->
      expect(
        _B.getp o, '$/bundle/someOtherKey/someNonFoundKey/notReached'
      ).to.deep.equal IamA: Stop: "Value"

    it "non existent key, a stopKey key in its place, going too far dosn't matter", ->
      expect(
        _B.getp o, '$/bundle/someOtherKey/someNonFoundKey/goingTooFar/IsIgnored/'
      ).to.deep.equal IamA: Stop: "Value"

  describe 'retrieving value using *terminateKey*:', ->
    it "non existent key, but a terminateKey in its place, returns {terminateKey:value}", ->
      expect(
        _B.getp o, '$/bundle/leadingToTerminate/someNonFoundKey/', terminateKey:'|'
      ).to.deep.equal '|': terminated: 'terminated value'

    it "existent key path, but found a terminateKey while walking, returns {terminateKey:value}", ->
      expect(
        _B.getp o, '$/bundle/leadingToTerminate/someKey/someOtherKey', terminateKey:'|'
      ).to.deep.equal '|': terminated: 'terminated value'

  describe 'retrieving value using *isReturnLast*, returns last value found:', ->
    it "non existent key, returns last value", ->
      expect(
        _B.getp o, '$/bundle/dependencies/someNonFoundKey/', isReturnLast: true
      ).to.deep.equal depsVars:'Bingo'

