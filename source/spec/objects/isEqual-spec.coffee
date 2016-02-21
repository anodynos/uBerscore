{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues

  object
  objectShallowClone1, objectShallowClone2
  objectDeepClone1, objectDeepClone2
  inheritedShallowClone
  inheritedDeepClone
} = data


oClone = _.clone objectWithProtoInheritedProps
c3Clone = _.clone c3

l = new _B.Logger 'spec/objects/isEqual'

describe 'isEqual:', ->

  describe "lodash _.isEqual tests on _B.isEqual:", ->

    it "should work with `arguments` objects (test in IE < 9)", ->
        args1 = (-> arguments)(1, 2, 3)
        args2 = (-> arguments)(1, 2, 3)
        args3 = (-> arguments)(1, 2)

        expect(_B.isEqual args1, args2).to.be.true

        if not (window.PHANTOMJS or window.mochaPhantomJS) #todo: why is this failing in PhantomJS ?
          expect(_B.isEqual args1, args3).to.be.false

        #_B test, not lodash
        if _B.isLodash() # false is underscore.isEqual (-> arguments)(1, 2, 3), {'0':1, '1':2, '2':3}
          expect(_B.isEqual args1, {'0':1, '1':2, '2':3}).to.be.true

        if not (window.PHANTOMJS or window.mochaPhantomJS) #todo: why is this failing in PhantomJS ?
          expect(_B.isEqual args1, [1, 2, 3]).to.be.false

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

    if _B.isLodash() then describe "callback (lodash only):", ->

      it "respects returning true", ->
        expect(_B.isEqual 111, '111', (a, b)-> a+'' is b+'').to.be.true

      it "is undecided if callback returns undefined", ->
        a = {a:'a', b:'b', c:'EQUAL', d:4}
        b = {a:'a', b:'b', c:{d:'Not really equal, but assumed as so'}, d:4}

        expect(_B.isEqual a, b, (a, b)->
          if a is 'EQUAL' then true else undefined).to.be.true

      it "options are passed to lodash's _.isEqual (called internally if no options)", ->
        a = {a:'a', b:'b', c:4}
        b = {a:'a', b:'b', c:4}

        expect(_B.isEqual a, b, (a, b, options)->
          return false if not _.isEqual options, _B.isEqual.defaults
        ).to.be.true

      it "options with callback & ctx are passed to _B.isEqual (with options)", ->
        a = {a:'a', b:'b', c:4}
        b = {a:'a', b:'b', c:4}
        ctx = {}
        expect(_B.isEqual a, b, opts={path:[], callback:(a, b, options)->
          return false if (options isnt opts) or (this isnt ctx)}, ctx
        ).to.be.true

      it "should pass the correct arguments (ctx & options) to `callback`", ->
        args = undefined
        cb = ->
        ctx = {}
        expect(_B.isEqual "a", "b", (->
          args = [].slice.call arguments
          return @ is ctx), ctx
        ).to.be.true
        expect(args).to.be.deep.equal ["a", "b", _B.isEqual.defaults]

      it "should correct set the `this` binding", ->
        expect(_B.isEqual "a", "b", ((a, b)-> @[a] is @[b]), {a:1, b: 1}).to.be.true

      it "should handle comparisons if `callback` returns `undefined`", ->
        expect(_B.isEqual("a", "a", ->)).to.be.true
        expect(_B.isEqual("a", "b", ->)).to.be.false

      it "should treat all truthy as true ", ->
        for truthy in [ 'hey', {}, [], 1, true]
          do (truthy)->
            expect(_B.isEqual "a", "b", -> truthy).to.be.true

      it "should treat all falsey (except undefined) as false ", ->
        for falsey in [ '', 0, NaN, null]
          do (falsey)->
            expect(_B.isEqual "a", "a", -> falsey).to.be.false

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
        expect(_B.isEqual [undefined], [undefined]).to.be.true
        expect(_B.isEqual null, null).to.be.true
        expect(_B.isEqual [null], [null]).to.be.true

      it "one undefined, other null", ->
        expect(_B.isEqual null, undefined).to.be.false
        expect(_B.isEqual undefined, null).to.be.false

      it 'Number', ->
        expect(_B.isEqual 111, 111).to.be.true
        expect(_B.isEqual 111.002, 111.002).to.be.true

        expect(_B.isEqual 112, 111).to.be.false
        expect(_B.isEqual 111.002, 111.003).to.be.false

      describe 'String', ->
        it 'as primitive ""', ->
          expect(_B.isEqual 'AAA 111', 'AAA 111').to.be.true
          expect(_B.isEqual 'AAA 112', 'AAA 111').to.be.false

        it 'as String Object', ->
          expect(_B.isEqual new String('AAA 111'), 'AAA 111').to.be.true
          expect(_B.isEqual 'AAA 111', new String('AAA 111')).to.be.true
          expect(_B.isEqual new String('AAA 111'), new String('AAA 111')).to.be.true

          expect(_B.isEqual 'AAA 112', new String('AAA 111')).to.be.false
          expect(_B.isEqual new String('AAA 112'), 'AAA 111').to.be.false
          expect(_B.isEqual new String('AAA 112'), new String('AAA 111')).to.be.false

      it 'Date', ->
        expect(_B.isEqual new Date('2012/12/12'), new Date('2012/12/12')).to.be.true
        expect(_B.isEqual new Date('2012/12/13'), new Date('2012/12/12')).to.be.false

      it 'RegExp', ->
        expect(_B.isEqual /abc/, /abc/).to.be.true
        expect(_B.isEqual /abcd/, /abc/).to.be.false

      describe 'Boolean', ->
        it 'as primitive', ->
          expect(_B.isEqual true, true).to.be.true
          expect(_B.isEqual true, false).to.be.false
        it 'as Boolean Object', ->
          expect(_B.isEqual new Boolean(true), true).to.be.true
          expect(_B.isEqual new Boolean(true), false).to.be.false
          expect(_B.isEqual false, new Boolean(false)).to.be.true

      describe 'Mixed primitives', ->
        it 'boolean truthys', ->
          expect(_B.isEqual true, 1).to.be.false
          expect(_B.isEqual true, 'a string').to.be.false
        it 'boolean falsys', ->
          expect(_B.isEqual false, 0).to.be.false
          expect(_B.isEqual false, '').to.be.false

    describe 'Simple Objects & functions:', ->
      it 'empty objects & arrays', ->
        expect(_B.isEqual [], []).to.be.true
        expect(_B.isEqual {}, {}).to.be.true

      it "empty different `_.isObject`s aren't equal", ->
        expect(_B.isEqual {}, []).to.be.false
        expect(_B.isEqual {}, ->).to.be.false
        expect(_B.isEqual [], ->).to.be.false

      it "present keys are important, even if undefined", ->
        expect(_.isEqual {a:1, b:undefined}, {a:1}).to.be.false
        expect(_.isEqual {a:1}, {a:1, b:undefined}).to.be.false

      it 'functions, with/without props', ->
        f1 = ->
        f2 = ->
        expect(_B.isEqual f1, f2).to.be.false
        expect(_B.isExact f1, f2).to.be.false
        expect(_B.isIqual f1, f2).to.be.false
        f1.p = 'a'
        f2.p = 'a'
        expect(_B.isEqual f1, f2).to.be.false
        expect(_B.isExact f1, f2).to.be.false
        expect(_B.isIqual f1, f2).to.be.false

    describe 'Arrays & lookalikes :', ->
      arr1 = [1, 2, '3', [4], {a:1}]
      arr2 = [1, 2, '3', [4], {a:1}]
      arrLookalike = {'0':1, '1':2, '2':'3', '3':[4], '4':{a:1}}

      it "simple Arrays", ->
        expect(_B.isEqual arr1, arr2).to.be.true

      it "Arrays with missing items", ->
        delete arr2[2]
        expect(_B.isEqual arr1, arr2).to.be.false

      it "Array lookalikes arent equal", ->
        expect(_B.isEqual arr1, arrLookalike).to.be.false

  describe "Argument's `isEqual` function:", ->
    class A
      constructor: (@val)->
      isEqual: (other)-> (other?.val || other) is 'YEAH'

    it 'recognsises & uses isEqual function on either side', ->
      a = new A('whatever')
      b = new A('YEAH')
      expect(_B.isEqual a, b).to.be.true
      expect(_B.isEqual a, 'YEAH').to.be.true
      expect(_B.isEqual b, 'YEAH').to.be.true
      expect(_B.isEqual b, a).to.be.false
      expect(_B.isEqual a, null).to.be.false
      expect(_B.isEqual a, undefined).to.be.false

  describe "options.exclude - excludes properties from test:", ->

    describe "on Arrays:", ->

      it 'excludes index as Number or String', ->
        a = [1, 2, 3, 99, 5]
        b = [1, 2, 3, 44, 5]
        expect(_B.isEqual a, b).to.be.false
        expect(_B.isEqual a, b, exclude:[3]).to.be.true
        expect(_B.isEqual a, b, exclude:['3']).to.be.true

      it 'excludes index & property with options.allProps', ->
        a = [1, 2, 3, 99, 5]
        a.prop = 1
        a.badProp = 13

        b = [1, 2, 3, 44, 5]
        b.prop = 1
        b.badProp = 13

        expect(_B.isEqual a, b).to.be.false
        expect(_B.isEqual a, b, {exclude:[3], allProps:true}).to.be.true

        b.badProp = 1113
        expect(_B.isEqual a, b, {exclude:[3], allProps:true}).to.be.false
        expect(_B.isEqual a, b, {exclude:[3, 'badProp'], allProps:true}).to.be.true
        expect(_B.isEqual a, b, {exclude:['badProp', '3'], allProps:true}).to.be.true

    it 'excludes properties & number-like properties as numbers', ->
      a = {a:1, b:2, '3':99, badProp: 5}
      b = {a:1, b:2, '3':44, badProp: 15}
      expect(_B.isEqual a, b).to.be.false
      expect(_B.isEqual a, b, exclude:[3, 'badProp']).to.be.true
      expect(_B.isEqual a, b, exclude:['badProp', '3']).to.be.true

  describe "options.allProps - considers all properties of Objects (i.e primitive imposters, functions, arrays etc):", ->

    it 'considers properties of primitive as Object:', ->
      a = new Number(111)
      b = new Number(111)
      a.prop = 1
      b.prop = 2
      expect(_B.isEqual a, b).to.be.true
      expect(_B.isEqual a, b, allProps:true).to.be.false
      b.prop = 1
      expect(_B.isEqual a, b, allProps:true).to.be.true

    it "considers properties (not just items) on Arrays", ->
      arr1 = [1, 2, '3', [4], {a:1}]
      arr2 = [1, 2, '3', [4], {a:1}]
      arr1.prop = [1]
      arr2.prop = [2]
      expect(_B.isEqual arr1, arr2).to.be.true
      expect(_B.isEqual arr1, arr2, allProps:true).to.be.false
      arr2.prop = [1]
      expect(_B.isEqual arr1, arr2, allProps:true).to.be.true

  describe "options.onlyProps - ignores value & type of property containers (primitives as Object, functions etc):", ->

    it 'cares only about properties, on equal values', ->
      a = new Number(111)
      b = new Number(111)
      a.prop = 1
      b.prop = 2
      expect(_B.isEqual a, b, onlyProps:true).to.be.false
      b.prop = 1
      expect(_B.isEqual a, b, onlyProps:true).to.be.true

    describe 'cares only about properties, on NON-equal values:', ->

      it "ignores Number Object value, only properties matter", ->
        a = new Number(111)
        b = new Number(112)
        a.prop = 1
        b.prop = 2

        expect(_B.isEqual b, a, onlyProps:true).to.be.false

        b.prop = 1
        expect(_B.isEqual b, a, onlyProps:true).to.be.true

      it "ignores different Functions, only properties matter", ->
        a = -> 'Hello'
        b = -> 'Goodbye'
        a.prop = 1
        b.prop = 2
        expect(_B.isEqual a, b, onlyProps:true).to.be.false

        b.prop = 1
        expect(_B.isEqual a, b, onlyProps:true).to.be.true

      it "DOES NOT ignore String Object 'value', as each char is a property!", ->
        a = new String('111')
        b = new String('112')
        a.prop = 1
        b.prop = 1

        expect(_B.isEqual b, a, onlyProps:true).to.be.false

    describe 'only properties matter, even on NON-equal types:', ->

      it 'ignores type of Objects, along with value', ->
        a = new RegExp(/./)
        b = new Boolean(false)
        a.prop = 1
        b.prop = 2

        expect(_B.isEqual a, b, onlyProps:true).to.be.false

        b.prop = 1
        expect(_B.isEqual a, b, onlyProps:true).to.be.true

      describe "works on different type of property containers like", ->
        hash = {'0':1, '1':2, '2':3}
        arr = [1, 2, 3]
        args = do (a=1, b=2, c=3)-> arguments
        func = -> 'Hi'
        func['0'] = 1
        func['1'] = 2
        func['2'] = 3

        class A
          constructor: ->
            @['0'] = 1
            @['1'] = 2
            @['2'] = 3

        instance = new A

#        it 'hashe against  instances, ?Arguments?, Functions & Arrays etc:', ->
        it 'hash against array', ->
          fals _B.isEqual hash, arr
          tru _B.isEqual hash, arr, onlyProps:true

        it 'instance against array', ->
          fals _B.isEqual instance, arr
          tru _B.isEqual instance, arr, onlyProps:true

        it.skip 'arguments against array', -> # todo: it is failing in PhantomJS
          if not (window.PHANTOMJS or window.mochaPhantomJS) # todo: this check is failing in travis.ci PhantomJS
            fals _B.isEqual args, arr
            tru _B.isEqual args, arr, onlyProps:true

        it 'hash against function', ->
          fals _B.isEqual hash, func
          tru _B.isEqual hash, func, onlyProps:true

        it 'instance against function', ->
          fals _B.isEqual instance, func
          tru _B.isEqual instance, func, onlyProps:true

    describe "works along with like:", ->

      it '1st args as primitive', ->
        b = new Number(111)
        b.prop = 1
        expect(_B.isEqual 1, b, onlyProps:true).to.be.false
        expect(_B.isEqual 1, b, {onlyProps:true, like:true}).to.be.true
        expect(_B.isEqual b, 1, {onlyProps:true, like:true}).to.be.false

      it 'both as Object imporsters, 2nd has more props', ->
        a = new Number(111)
        b = new Boolean(false)
        a.prop = 1
        b.prop = 1
        b.prop2 = 2
        expect(_B.isEqual a, b, {onlyProps:true, like:true}).to.be.true
        expect(_B.isEqual b, a, {onlyProps:true, like:true}).to.be.false

        a.prop2 = 2
        expect(_B.isEqual b, a, {onlyProps:true, like:true}).to.be.true

  describe "options.inherited - Objects with inherited properties:", ->

    describe "object with inherited properties:", ->

      it "_B.isEqual is true", ->
        expect(_B.isEqual objectWithProtoInheritedProps, expectedPropertyValues, undefined,undefined, inherited:true).to.be.true
        expect(_B.isEqual expectedPropertyValues, objectWithProtoInheritedProps, inherited:true).to.be.true

      it "_.isEqual fails", ->
        expect(_.isEqual objectWithProtoInheritedProps, expectedPropertyValues).to.be.false
        expect(_.isEqual expectedPropertyValues, objectWithProtoInheritedProps).to.be.false

      describe "with _.clone: ", ->
        it "_B.isIqual fails (imperfect _.clone)", ->
          expect(_B.isIqual oClone, expectedPropertyValues).to.be.false
          expect(_B.isIqual expectedPropertyValues, oClone).to.be.false

        it "_.isEqual fails", ->
          expect(_.isEqual oClone, expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, oClone).to.be.false

      describe "with _B.clone proto: ", ->
        oCloneProto = _B.clone objectWithProtoInheritedProps, copyProto:true

        it "_B.isIqual succeeds (a perfect clone:-)", ->
          expect(_B.isIqual oCloneProto, expectedPropertyValues).to.be.true
          expect(_B.isIqual expectedPropertyValues, oCloneProto ).to.be.true

        it "_.isEqual still fails", ->
          expect(_.isEqual oCloneProto, expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, oCloneProto).to.be.false


    describe "coffeescript object with inherited properties:", ->

      it "_B.isEqual is true", ->
        expect(_B.isEqual c3, expectedPropertyValues, {inherited:true, exclude:['constructor']}).to.be.true #alt `options` passing style (in callback's place)
        expect(_B.isIqual expectedPropertyValues, c3).to.be.true

      it "_.isEqual fails", ->
        expect(_.isEqual c3, expectedPropertyValues).to.be.false
        expect(_.isEqual expectedPropertyValues, c3).to.be.false

      describe "with _.clone:", ->
        it "_B.isIqual fails (imperfect _.clone)", ->
          expect(_B.isEqual c3Clone, expectedPropertyValues, undefined, undefined, inherited:true).to.be.false
          expect(_B.isIqual expectedPropertyValues, c3Clone).to.be.false

        it "_.isEqual fails", ->
          expect(_.isEqual c3Clone, expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, c3Clone).to.be.false

      describe "with _B.clone: ", ->
        c3CloneProto = _B.clone c3, copyProto:true

        it "_B.isIqual is true", ->
          expect(_B.isEqual c3CloneProto, expectedPropertyValues, {inherited:true, exclude:['constructor']}).to.be.true
          expect(_B.isIqual [expectedPropertyValues], [c3CloneProto]).to.be.true

        it "_.isEqual fails", ->
          expect(_.isEqual c3CloneProto , expectedPropertyValues).to.be.false
          expect(_.isEqual expectedPropertyValues, c3CloneProto).to.be.false


  describe "options.exact (Objects need to have exact refs) :", ->

    describe "shallow cloned objects :", ->

      it "_B.isExact(object, objectShallowClone1) is true", ->
        expect(_B.isEqual object, objectShallowClone1, undefined, undefined, exact:true).to.be.true
        expect(_B.isExact objectShallowClone1, object).to.be.true

      it "_B.isExact(object, objectShallowClone2) with _.clone(object) is true", ->
        expect(_B.isEqual object, objectShallowClone2, exact:true).to.be.true #alt `options` passing style (in callback's place)
        expect(_B.isExact objectShallowClone2, object).to.be.true

      it "_.isEqual(object, shallowClone1 & 2) gives true", ->
        expect(_.isEqual object, objectShallowClone1).to.be.true
        expect(_.isEqual object, objectShallowClone2).to.be.true

    describe "deeply cloned objects:", ->

      describe "objectDeepClone1 with copied proto:", ->

        it "_B.isExact is false", ->
          expect(_B.isEqual object, objectDeepClone1, exact:true).to.be.false #alt `options` passing style (in callback's place)
          expect(_B.isExact objectDeepClone1, object).to.be.false

        it "_B.isEqual is true", ->
          expect(_B.isEqual object, objectDeepClone1).to.be.true
          expect(_B.isEqual objectDeepClone1, object).to.be.true

      describe "objectDeepClone2 = _.clone(object):", ->

        it "_B.isExact is false", ->
          expect(_B.isEqual object, objectDeepClone2, undefined, undefined, exact:true).to.be.false
          expect(_B.isExact objectDeepClone2, object).to.be.false

        it "_B.isEqual is true", ->
          expect(_B.isEqual object, objectDeepClone2).to.be.true
          expect(_B.isEqual objectDeepClone2, object).to.be.true

      it "_.isEqual(object, objectDeepClone1 & 2) gives true", ->
        expect(_.isEqual object, objectDeepClone1).to.be.true
        expect(_.isEqual object, objectDeepClone2).to.be.true

    describe "isIxact : isEqual with inherited & exact :", ->

      describe "shallow inherited clone: inheritedShallowClone:", ->

        it 'isIxact is true:',->
          expect(_B.isIxact inheritedShallowClone, object).to.be.true

        it 'isIqual is true:', ->
          expect(_B.isIqual object, inheritedShallowClone).to.be.true

      describe "deep inherited clone : inheritedDeepClone:", ->

        it 'isIxact is true:',->
          expect(_B.isIxact inheritedDeepClone, object).to.be.false

        it 'isIqual is true:', ->
          expect(_B.isIqual object, inheritedDeepClone).to.be.true

  describe "options.path:", ->
    a1 = {a:{a1:a2:1}, b:{b1:1, b2:     {b3:3}       } }
    a2 = {a:{a1:a2:1}, b:{b1:1, b2:     {b3:3333}      } }

    it "contains the keys as they are processed, 1st obj misses props", ->
      expect(_B.isEqual a1, a2, options={path:[]}).to.be.false
      expect(options.path).to.be.deep.equal ['b', 'b2', 'b3']

    it "contains the keys as they are processed, 2nd obj misses props", ->
      expect(_B.isEqual a2, a1, null, null, options={path:[]}).to.be.false
      expect(options.path).to.be.deep.equal ['b', 'b2', 'b3']

  describe "_B.isLike : _B.isEqual with like:true (1st arg can be a partial of 2nd arg)", ->
    a1 ={a:1, b:{b1:1}}
    b1 ={a:1, b:{b1:1, b2:2}, c:3}

    a2 =
      a:1
      b:
        bb:2
      c: [1, {p2:2}, 4 ]

    b2 =
      a:1
      b:
        bb:2
        missingFrom: a: "a"
      missingFrom: "a"
      c: [1, {p2:2, p3:3}, 4, {p:5}, 6]

    it "is true if 1st args's properties are _B.isLike to 2nd arg's", ->
      expect(_B.isLike a1, b1).to.be.true
      expect(_B.isEqual a1, b1).to.be.false

      expect(_B.isLike a2, b2).to.be.true
      expect(_B.isEqual a2, b2).to.be.false

    it "is false if 1st args's properties are not _B.isLike to 2nd arg's", ->
      expect(_B.isLike b1, a1).to.be.false
      expect(_B.isEqual b1, a1).to.be.false

      expect(_B.isLike b2, a2).to.be.false
      expect(_B.isEqual b2, a2).to.be.false

  describe "aliases like _B.isLike : ", ->
    a1 ={a:1, b:{b1:1}}
    b1 ={a:1, b:_b={b1:1, b2:2}, c:3}

    it "pass options in place of the constructor", ->
      expect(_B.isLike b1, a1, path:path=[]).to.be.false
      expect(path).to.be.deep.equal ['b', 'b2']

    it "pass options in its proper place", ->
      expect(_B.isLike b1, a1, undefined, undefined, path:path=[]).to.be.false
      expect(path).to.be.deep.equal ['b', 'b2']

    it "passes callback & options in its proper place & as an option", ->
      callback = (val1, val2)->
        if (val1 is _b) or path[0] is 'c' #or (val1 is 3)
          true
        #else undefined, which is ignored as a decision

      expect(_B.isLike b1, a1, callback, undefined, {path:path=[]}).to.be.true
      expect(_B.isLike b1, a1, null, undefined, {path:path=[], callback:callback}).to.be.true

    it "options in its proper place DOESN NOT has precedence over callback's place", ->
      expect(_B.isLike b1, a1, path:path1=[], undefined, path:path2=[]).to.be.false
      expect(path1).to.be.deep.equal ['b', 'b2']
      expect(path2).to.be.empty
