assert = chai.assert
expect = chai.expect

describe 'objects/setValueAtPath:', ->
  o =
    '$':
      bundle:
        anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
        dependencies:
          variableNames: "Bingo"

  describe 'existent paths', ->

    it "primitive", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/variableNames', 'just_a_String'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
          anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
          dependencies:
            variableNames: 'just_a_String'
      expect(isSet).to.equal true

    it "object, with sep at end & alt sep", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$.bundle.dependencies.variableNames.', {property: 'just_a_String'}, undefined, '.'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
            anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
            dependencies: variableNames: property: 'just_a_String'
      expect(isSet).to.equal true

    it "object, overwriting object property", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$.bundle.dependencies.', {property: 'just_a_String'}, undefined, '.'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
          anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
          dependencies: property: 'just_a_String'
      expect(isSet).to.equal true

    it "array item, overwriting object property", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$.bundle.anArray.2.arrayItem3', {'3_is_now': 33}, undefined, '.'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
          anArray: ['arrayItem1', 2, 'arrayItem3': {'3_is_now': 33} ]
          dependencies: variableNames: "Bingo"
      expect(isSet).to.equal true

  describe 'inexistent key paths:', ->

    it "not setting by default", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/variableNames/hi', {joke: {joke2:'JOKER'}}
      expect(oClone).to.deep.equal o
      expect(isSet).to.equal false

    describe 'forceCreate:', ->

      it "create new objects for inexistent paths, adding object properties", ->
        oClone = _.clone o, true
        isSet = _B.setValueAtPath oClone, '$.bundle.dependencies.moreDeps.evenMoreDeps.', {property: 'just_a_String'}, true, '.'
        expect(
          oClone
        ).to.deep.equal
          '$': bundle:
            anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
            dependencies:
              variableNames: "Bingo"
              moreDeps: evenMoreDeps: {property: 'just_a_String'}
        expect(isSet).to.equal true

      it "create new objects, overwritting primitives", ->
        oClone = _.clone o, true
        isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/variableNames/newKey', {joke: {joke2:'JOKER'}}, true
        expect(
          oClone
        ).to.deep.equal
          '$':
            bundle:
              anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
              dependencies: variableNames: newKey: {joke: {joke2:'JOKER'}}

        expect(isSet).to.equal true

      it "create new objects, preserving `oldValue`", ->
        oClone = _.clone o, true
        isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/variableNames/newKey/anotherNewKey', {joke: {joke2:'JOKER'}}, '_oldValue'
        expect(
          oClone
        ).to.deep.equal
          '$':
            bundle:
              anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
              dependencies: variableNames:
                _oldValue: 'Bingo'
                newKey: anotherNewKey: {joke: {joke2:'JOKER'}}

        expect(isSet).to.equal true
