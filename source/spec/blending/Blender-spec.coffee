define -> describe 'Blender & DeepCloneBlender:', ->

  describe 'Internals: blender.adjustBlenderBehavior:', ->
  
    describe "corectly transforms nested types of srcDstSpecs to short format", ->
      it "works with simple 'src' and 'dst'", ->
        longTypeNamesBb =
          order: ['src', 'dst']
  
          Array: String:'someAction'
          Object:
            "Array": "doSomeAction"
            "Null": ->
  
          doSomeAction:->
  
        expectedAdjustedBb =
          order: [ 'src', 'dst' ]
          doSomeAction: longTypeNamesBb.doSomeAction # copy function ref
          '[]': "''": 'someAction'
          '{}':
            '[]': 'doSomeAction'
            'null': longTypeNamesBb['Object'].Null
  
        blender = new _B.Blender longTypeNamesBb
        expect(_.isEqual blender.blenderBehaviors[0], expectedAdjustedBb).to.be.true


      it "works with bbOrder specs ['src', 'path', 'dst']", ->
        longTypePathBb =
            order:['src', 'path', 'dst']

            Function:->                              # its an 'src' item, hence it will become "->"
            String:                                  # its an 'src' item, hence it will become "''"
              'bundle:dependencies:depsVars:*': # paths with seperator '/' are expanded eg. `{bundle:dependencies:depsVars}`

                basics : '|':                        # terminator of 'path'

                  # these keys are 'dst' items - they become '{}', '[]' etc
                  Object: -> 'Iam a someObjectAction'
                  Array: 'someArrayAction, found on a preceding blenderBehavior or blender'
                  String: (prop, src, dst, blender)-> B.Blender.SKIP

              'bundle:dependencies:_knownDepsVars':  # expanded to `{bundle:dependencies:_knownDepsVars}`
                                                          # but merged (blended:-) with {bundle:dependencies:...} above

                  String: Array: Function:                # these are still path names, they aren't shortified

                    '|':
                      Function: ->_B.Blender.SKIP
                      Array:'someArrayAction'
            someAction:->

        expectedAdjustededBb =
          order: ["src", "path", "dst"]

          '->': longTypePathBb.Function

          "''":
            bundle:
              dependencies:
                depsVars:
                  "*":
                    basics:
                      "|":
                        "{}": longTypePathBb['String']['bundle:dependencies:depsVars:*'].basics['|']['Object']
                        "[]": longTypePathBb['String']['bundle:dependencies:depsVars:*'].basics['|']['Array']
                        "''": longTypePathBb['String']['bundle:dependencies:depsVars:*'].basics['|']['String']

                _knownDepsVars:
                  String:
                    Array:
                      Function:
                        "|":
                          "->": longTypePathBb['String']['bundle:dependencies:_knownDepsVars'].String.Array.Function['|']['Function']
                          "[]": "someArrayAction"

          someAction: longTypePathBb.someAction

        expect(
          new _B.DeepCloneBlender(longTypePathBb).blenderBehaviors[0]
        ).to.deep.equal expectedAdjustededBb

#      it "ignores PROBLEMATIC specs with 'src' and 'dst' & 'path'", ->
#
#        longTypeNamesBb =
#          order: ['src', 'dst', 'path']
#          Array: String:'someAction'
#          Object:
#            "Array": 'this/is/path/to/action':'|': "doSomeAction"
#            "Null": ->
#          doSomeAction:->
#
#        expectedAdjustedBb = '???'
#
#        blender = new _B.Blender longTypeNamesBb
#        expect(_.isEqual blender.blenderBehaviors[0], expectedAdjustedBb)

        
  describe 'Handles primitives:', ->

    blender = new _B.Blender

    it "overwrites undefined / null:", ->
      expect(blender.blend undefined, 6, 18).to.equal 18
      expect(blender.blend undefined, 'a string').to.equal 'a string'
      expect(blender.blend null, 16.7).to.equal 16.7
      expect(blender.blend null, 'a string').to.equal 'a string'
      expect(blender.blend undefined, 18, {prop:'someValue'}).to.deep.equal {prop:'someValue'}

    it "overwrites primitives", ->
      expect(blender.blend 6, 18).to.equal 18
      expect(blender.blend 'a string', 18, 'another string').to.equal 'another string'
      expect(blender.blend 'a string', 18, {prop:'someValue'}).to.deep.equal {prop:'someValue'}

  describe 'Options passing:', ->

    it "deepCloneBlender.anOption is someOptions.anOption", ->
      someOptions = {anOption:->'I am a function'}
      deepCloneBlender = new _B.DeepCloneBlender [], someOptions
      expect(deepCloneBlender.anOption).to.equal someOptions.anOption

    it "real options: ", ->
      deepCloneBlender = new _B.DeepCloneBlender
      expect(deepCloneBlender.inherited).to.be.false
      expect(deepCloneBlender.copyProto).to.be.false

      myCopyProto = (->); myInherited = (->)
      deepCloneBlender = new _B.DeepCloneBlender [], {inherited: myInherited, copyProto: myCopyProto }
      expect(deepCloneBlender.inherited).to.equal myInherited
      expect(deepCloneBlender.copyProto).to.equal myCopyProto

    describe "Options go up the inheritance:", ->
      class SomeBlender extends _B.Blender
        someOption: "someOptionValue"

      class SomeOtherBlender extends _B.Blender
        someOtherOption: "someOtherOptionValue"
        someOption: "someOptionValue of SomeOtherBlender"

      it "respecting subclassed options #1", ->
        someBlender = new SomeBlender
        expect(someBlender.someOption).to.equal "someOptionValue"

        someBlender = new SomeBlender [], someOption: "someRedefinedOptionValue"
        expect(someBlender.someOption).to.equal "someRedefinedOptionValue"

      it "respecting subclassed options #2", ->
        someOtherBlender = new SomeOtherBlender
        expect(someOtherBlender.someOption).to.equal "someOptionValue of SomeOtherBlender"

        someOtherBlender = new SomeOtherBlender [], someOption: "someRedefinedOptionValue"
        expect(someOtherBlender.someOption).to.equal "someRedefinedOptionValue"
        expect(someOtherBlender.someOtherOption).to.equal is "someOtherOptionValue"

  describe 'Blender behaviors:', ->
    describe 'Simple examples:', ->
      o1 =
        p1:5
        p2:
          p21:'A String'
          p22: [5, 6, 'String in array']
        p3: 'Some string'

      o2 =
        p1:10
        p2:
          p21:'Another String'
          p22: [20, 40]

      it "Numbers dont just overwrite each other: the source is doubled and then added up to destination", ->
        deepCloneBlenderAddingNumbers =
          new _B.DeepCloneBlender 'Number': 'Number': (prop, src, dst)-> dst[prop] + src[prop] * 2

        expect(deepCloneBlenderAddingNumbers.blend {}, o1, o2).to.deep.equal
          p1:25
          p2:
            p21:'Another String'
            p22: [45, 86, 'String in array']
          p3: 'Some string'

      it "src Array items dont just overwrite the destination Array ones: they are doubled (if numbers) & then pushed to dst.", ->
        deepCloneBlenderAddingNumbers =
          new _B.DeepCloneBlender(
            'Array': 'Array': (prop, src, dst, bldr)->
                for item in src[prop]
                  item = bldr.blend({}, {hack:item}).hack
                  dst[prop].push if _.isNumber(item) then item * 2  else item

                _B.Blender.SKIP
          )

        expect(deepCloneBlenderAddingNumbers.blend {}, o1, o2).to.deep.equal
          p1:10
          p2:
            p21:'Another String'
            p22: [5, 6, 'String in array', 40, 80]
          p3: 'Some string'

      it "filters objects - Strings are banned:", ->
        deepCloneBlenderOmmitingStrings =
          new _B.DeepCloneBlender(
            order: ['src']
            'String': (prop, src, dst, bldr)-> _B.Blender.SKIP
          )
        result =
        expect(deepCloneBlenderOmmitingStrings.blend {}, o1, o2).to.deep.equal
          p1:10
          p2:
            p22: [20, 40]

    describe 'Advanced examples:', -> # @todo
      o1 =
        p1: 5
        p2:
          p21: (num)-> num * 4
          p22: [5, 'String']
        p3: 'Some string'

      o2 =
        p1: 10
        p2:
          p21: 128
          p22: [20, 40]

      describe 'Chained BlenderBehaviors & Subclassed Blenders (are the same stuff): ', ->
          addingNumbersAndConcatEmToStringBlender =
            new _B.DeepCloneBlender(                  # We useDeepCloneBlender, cause that's the bottom-line behavior we want.

              funcOverwrite = 'Function': 'overwrite'  # But we overide the behavior of a 'Function' arriving as source:
                                                       # we simply overwrite (i.e copy its reference).
              weirdBB =
                'order': ['dst', 'src']

                # When a Number arrives (source) going onto a Function (destination),
                # we overwrite the function (at dst[prop])
                # with the result of applying src[prop] to that function.
                'Function': 'Number': (prop, src, dst)-> dst[prop] src[prop]

                # When a (Number or String) lands on a (Number or String), we have some special treatment
                'Number':
                  'Number': (prop, src, dst)-> dst[prop] + src[prop] * 2
                  'String': (prop, src, dst)-> dst[prop] + '--got a String-->:' + src[prop]
                'String': 'Number': (prop, src, dst)-> dst[prop] + '--got a Numba * 3-->:' + src[prop] * 3
            )

          ## lets create the exact Blender, using coffee class, so we can *new* or subclass them.
          class FunctionOverWriterBlender extends _B.DeepCloneBlender
            @behavior: funcOverwrite

          class UselessBlender extends FunctionOverWriterBlender

          class WeirdBlender extends UselessBlender
            @behavior: weirdBB

          weirdBlender = new WeirdBlender

          for blender, bi in [addingNumbersAndConcatEmToStringBlender, weirdBlender] #both should behave the same
            it "works {}<--o1<--o2 with blender ##{bi}", ->

              expect(blender.blend {}, o1, o2).to.deep.equal
                p1: 25
                p2:
                  p21: 128 * 4
                  p22: [45, 'String--got a Numba * 3-->:120']
                p3: 'Some string'


            it "works {}<--o2<--o1 with blender ##{bi}", ->
              result =
              expect(blender.blend {}, o2, o1).to.deep.equal
                p1: 20
                p2:
                  p21: o1.p2.p21 # Function is copied by reference
                  p22: [30, '40--got a String-->:String']
                p3: 'Some string'

      # @todo
      #describe 'Cloning whole hierarchies: cloning protos (and their protos etc):', ->
