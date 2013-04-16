assert = chai.assert
expect = chai.expect

{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues

  object
  objectShallowClone1, objectShallowClone2
  objectDeepClone1, objectDeepClone2
  inheritedShallowClone
  inheritedDeepClone
} = data



oClone = _.clone objectWithProtoInheritedProps
c3Clone = _.clone c3

describe 'isEqual:', ->

  describe "lodash _.isEqual tests on _B.isEqual:", ->

    it "should work with `arguments` objects (test in IE < 9)", ->
        args1 = (-> arguments)(1, 2, 3)
        args2 = (-> arguments)(1, 2, 3)
        args3 = (-> arguments)(1, 2)
        expect(_B.isEqual args1, args2).to.be.true
        expect(_B.isEqual args1, args3).to.be.false

    it "should return `false` when comparing values with circular references to unlike values", ->
      array1 = ["a", null, "c"]
      array2 = ["a", [], "c"]
      object1 =
        a: 1
        b: null
        c: 3

      object2 =
        a: 1
        b: {}
        c: 3

      array1[1] = array1
      expect(_B.isEqual array1, array2).to.be.false

      object1.b = object1
      expect(_B.isEqual object1, object2).to.be.false

    it "should pass the correct `callback` arguments", ->
      args = undefined
      _B.isEqual("a", "b", ->
        args or (args = [].slice.call(arguments))
      )

      expect(args).to.be.deep.equal ["a", "b"]

    it "should correct set the `this` binding", ->
      actual = _B.isEqual("a", "b", (a, b) ->
        this[a] is this[b]
      ,
        a: 1
        b: 1
      )
      expect(actual).to.be.true

    it "should handle comparisons if `callback` returns `undefined`", ->
      actual = _B.isEqual("a", "a", ->)
      expect(actual).to.be.true

    it "should return a boolean value even if `callback` does not", ->
      actual = _B.isEqual("a", "a", -> "a")
      expect(actual).to.be.true
      _.each [ # falsey value
          ''
          0
          false
          NaN
          null
          undefined
        ], (value) ->
              actual = _B.isEqual("a", "b", -> value)
              expect(actual).to.be.false

  describe "rudimentary checks:", ->
    describe "primitives:", ->
      it "one undefined", ->
        expect(_B.isEqual undefined, objectWithProtoInheritedProps).to.be.false
        expect(_B.isEqual objectWithProtoInheritedProps, undefined).to.be.false

      it "one null", ->
        expect(_B.isEqual null, objectWithProtoInheritedProps).to.be.false
        expect(_B.isEqual objectWithProtoInheritedProps, null).to.be.false

      it "both undefined/null", ->
        expect(_B.isEqual undefined, undefined).to.be.true
        expect(_B.isEqual null, null).to.be.true

      it "one undefined, other null", ->
        expect(_B.isEqual null, undefined).to.be.false
        expect(_B.isEqual undefined, null).to.be.false

      it 'Number', ->
        expect(_B.isEqual 111, 111).to.be.true
        expect(_B.isEqual 111.002, 111.002).to.be.true

        expect(_B.isEqual 112, 111).to.be.false
        expect(_B.isEqual 111.002, 111.003).to.be.false

      it 'String', ->
        expect(_B.isEqual '111', '111').to.be.true
        expect(_B.isEqual '112', '111').to.be.false

      it 'Date', ->
        expect(_B.isEqual new Date('2012-12-12'), new Date('2012-12-12')).to.be.true
        expect(_B.isEqual new Date('2012-12-13'), new Date('2012-12-12')).to.be.false

      it 'RegExp', ->
        expect(_B.isEqual /abc/, /abc/).to.be.true
        expect(_B.isEqual /abcd/, /abc/).to.be.false

      it 'Boolean', ->
        expect(_B.isEqual true, true).to.be.true
        expect(_B.isEqual true, false).to.be.false
        expect(_B.isEqual new Boolean(true), true).to.be.true
        expect(_B.isEqual new Boolean(true), false).to.be.false
        expect(_B.isEqual false, new Boolean(false)).to.be.true

    describe "callback", ->
      expect(_B.isEqual 111, '111', (a, b)-> a+'' is b+'').to.be.true


  describe "options.inherited - Objects with inherited properties:", ->

    describe "object with __proro__ inherited properties:", ->

      it "_B.isEqual is true", ->
        expect(_B.isEqual objectWithProtoInheritedProps, expectedPropertyValues, undefined,undefined, inherited:true).to.be.true
        expect(_B.isEqual expectedPropertyValues, objectWithProtoInheritedProps, undefined, undefined,  inherited:true).to.be.true

      it "_.isEqual fails", ->
        expect(_.isEqual objectWithProtoInheritedProps, expectedPropertyValues).to.be.false
        expect(_.isEqual expectedPropertyValues, objectWithProtoInheritedProps).to.be.false

      describe "with _.clone: ", ->

        it "_B.isEqualInherited fails (imperfect _.clone)", ->
          expect(_B.isEqualInherited oClone, expectedPropertyValues).to.be.false
          expect(_B.isEqualInherited expectedPropertyValues, oClone).to.be.false

        it "_.isEqual fails", ->
          expect(_.isEqual oClone, expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, oClone).to.be.false

      describe "with _B.clone proto: ", ->
        oCloneProto = _.clone objectWithProtoInheritedProps
        oCloneProto.__proto__ = objectWithProtoInheritedProps.__proto__

        it "_B.isEqualInherited succeeds (a perfect clone:-)", ->
          expect(_B.isEqualInherited oCloneProto, expectedPropertyValues).to.be.true
          expect(_B.isEqualInherited expectedPropertyValues, oCloneProto ).to.be.true

        it "_.isEqual fails", ->
          expect(_.isEqual oCloneProto, expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, oCloneProto).to.be.false


    describe "coffeescript object with inherited properties:", ->

      it "_B.isEqual is true", ->
        expect(_B.isEqual c3, expectedPropertyValues, inherited:true).to.be.true #alt `options` passing style (in callback's place)
        expect(_B.isEqualInherited expectedPropertyValues, c3).to.be.true

      it "_.isEqual fails", ->
        expect(_.isEqual c3, expectedPropertyValues).to.be.false
        expect(_.isEqual expectedPropertyValues, c3).to.be.false

      describe "with _.clone:", ->
        it "_B.isEqualInherited fails (imperfect _.clone)", ->
          expect(_B.isEqual c3Clone, expectedPropertyValues, undefined, undefined, inherited:true).to.be.false
          expect(_B.isEqualInherited expectedPropertyValues, c3Clone).to.be.false

        it "_.isEqual fails", ->
          expect(_.isEqual c3Clone, expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, c3Clone).to.be.false

      describe "with _.clone proto: ", ->
        c3CloneProto = _.clone c3
        c3CloneProto.__proto__ = c3.__proto__
        it "_B.isEqualInherited is true", ->
          expect(_B.isEqual c3CloneProto, expectedPropertyValues, undefined, undefined, inherited:true).to.be.true
          expect(_B.isEqualInherited expectedPropertyValues, c3CloneProto).to.be.true

        it "_.isEqual fails", ->
          expect(_.isEqual c3CloneProto , expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, c3CloneProto).to.be.false


  describe "options.exact (Objects need to have exact refs) :", ->

    describe "shallow cloned objects :", ->

      it "_B.isEqualExact(object, objectShallowClone1) is true", ->
        expect(_B.isEqual object, objectShallowClone1, undefined, undefined, exact:true).to.be.true
        expect(_B.isEqualExact objectShallowClone1, object).to.be.true

      it "_B.isEqualExact(object, objectShallowClone2) with _.clone(object) is true", ->
        expect(_B.isEqual object, objectShallowClone2, exact:true).to.be.true #alt `options` passing style (in callback's place)
        expect(_B.isEqualExact objectShallowClone2, object).to.be.true

      it "_.isEqual(object, shallowClone1 & 2) gives true", ->
        expect(_.isEqual object, objectShallowClone1).to.be.true
        expect(_.isEqual object, objectShallowClone2).to.be.true

    describe "deeply cloned objects:", ->

      describe "objectDeepClone1 with hand configured __proto__:", ->

        it "_B.isEqualExact is false", ->
          expect(_B.isEqual object, objectDeepClone1, exact:true).to.be.false #alt `options` passing style (in callback's place)
          expect(_B.isEqualExact objectDeepClone1, object).to.be.false

        it "_B.isEqual is true", ->
          expect(_B.isEqual object, objectDeepClone1).to.be.true
          expect(_B.isEqual objectDeepClone1, object).to.be.true

      describe "objectDeepClone2 = _.clone(object):", ->

        it "_B.isEqualExact is false", ->
          expect(_B.isEqual object, objectDeepClone2, undefined, undefined, exact:true).to.be.false
          expect(_B.isEqualExact objectDeepClone2, object).to.be.false

        it "_B.isEqual is true", ->
          expect(_B.isEqual object, objectDeepClone2).to.be.true
          expect(_B.isEqual objectDeepClone2, object).to.be.true

      it "_.isEqual(object, objectDeepClone1 & 2) gives true", ->
        expect(_.isEqual object, objectDeepClone1).to.be.true
        expect(_.isEqual object, objectDeepClone2).to.be.true


    describe "isEqualInheritedExact : isEqual with inherited & exact :", ->

      isEqualInheritedExact = (a, b, callback, thisArg, options={})->
        options.exact = true
        _B.isEqualInherited.apply undefined, [a, b, callback, thisArg, options]

      describe "shallow inherited clone: inheritedShallowClone:", ->

        it 'isEqualInheritedExact is true:',->
          expect(isEqualInheritedExact inheritedShallowClone, object).to.be.true

        it 'isEqualInherited is true:', ->
          expect(_B.isEqualInherited object, inheritedShallowClone).to.be.true

      describe "deep inherited clone : inheritedDeepClone:", ->

        it 'isEqualInheritedExact is true:',->
          expect(isEqualInheritedExact inheritedDeepClone, object).to.be.false

        it 'isEqualInherited is true:', ->
          expect(_B.isEqualInherited object, inheritedDeepClone).to.be.true

