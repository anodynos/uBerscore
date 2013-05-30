assert = chai.assert
expect = chai.expect

describe 'objects/setValueAtPath:', ->
  o =
    '$':
      bundle:
        anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
        dependencies:
          depsVars: "Bingo"

  describe 'existent paths', ->

    it "primitive", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/depsVars', 'just_a_String'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
          anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
          dependencies:
            depsVars: 'just_a_String'
      expect(isSet).to.be.true

    it "object, with sep at end & alt sep", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$.bundle.dependencies.depsVars.', {property: 'just_a_String'}, undefined, '.'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
            anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
            dependencies: depsVars: property: 'just_a_String'
      expect(isSet).to.be.true

    it "object, overwriting object property", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$.bundle.dependencies.', {property: 'just_a_String'}, undefined, '.'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
          anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
          dependencies: property: 'just_a_String'
      expect(isSet).to.be.true

    it "array item, overwriting object property", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$.bundle.anArray.2.arrayItem3', {'3_is_now': 33}, undefined, '.'
      expect(
        oClone
      ).to.deep.equal
        '$': bundle:
          anArray: ['arrayItem1', 2, 'arrayItem3': {'3_is_now': 33} ]
          dependencies: depsVars: "Bingo"
      expect(isSet).to.be.true

  describe 'inexistent key paths:', ->

    it "not setting by default", ->
      oClone = _.clone o, true
      isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/depsVars/hi', {joke: {joke2:'JOKER'}}
      expect(oClone).to.deep.equal o
      expect(isSet).to.be.false

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
              depsVars: "Bingo"
              moreDeps: evenMoreDeps: {property: 'just_a_String'}
        expect(isSet).to.be.true

      it "create new objects, overwritting primitives", ->
        oClone = _.clone o, true
        isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/depsVars/newKey', {joke: {joke2:'JOKER'}}, true
        expect(
          oClone
        ).to.deep.equal
          '$':
            bundle:
              anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
              dependencies: depsVars: newKey: {joke: {joke2:'JOKER'}}

        expect(isSet).to.be.true

      it "create new objects, preserving `oldValue`", ->
        oClone = _.clone o, true
        isSet = _B.setValueAtPath oClone, '$/bundle/dependencies/depsVars/newKey/anotherNewKey', {joke: {joke2:'JOKER'}}, '_oldValue'
        expect(
          oClone
        ).to.deep.equal
          '$':
            bundle:
              anArray: ['arrayItem1', 2, 'arrayItem3':3 ]
              dependencies: depsVars:
                _oldValue: 'Bingo'
                newKey: anotherNewKey: {joke: {joke2:'JOKER'}}

        expect(isSet).to.be.true
