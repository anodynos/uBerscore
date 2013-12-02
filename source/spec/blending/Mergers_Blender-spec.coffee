{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = data

describe "Mergers_Blender-spec", ->

  describe "'Blender.blend' Default settings: {inherited:false, copyProto:false}", ->
    defaultBlender = new _B.Blender

    describe "clones POJSO Object (no inheritance)", ->

      describe "(shallowClone = defaultBlender.blend {}, expectedPropertyValues)", ->
        #shallowClone = defaultBlender.blend {}, expectedPropertyValues
        shallowClone = defaultBlender.blend expectedPropertyValues #same as above

        describe "is a shallow clone and compared to source: ", ->
          it "is not RefDisjoint - (there is at least one common reference))", ->
            expect(
              _B.isRefDisjoint(shallowClone, expectedPropertyValues, {deep:true, inherited:true})
            ).to.be.false

          it "has common references of all nested objects", ->
            sRefs = _B.getRefs expectedPropertyValues, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowClone, {deep:true, inherited:true}
            equalSet sRefs, cRefs

          it "has a nested object copied by reference", ->
            equal shallowClone.aProp1, expectedPropertyValues.aProp1
            expect(shallowClone.aProp1).to.not.be.an 'undefined'

          it "_.isEqual true (soft equality, same values/JSON)", ->
            expect(_.isEqual shallowClone, expectedPropertyValues).to.be.true

          it "_B.isEqual true (soft equality, same values/JSON)", ->
            deepEqual shallowClone, expectedPropertyValues

          it "_B.isExact true (strict references equality)", ->
            exact shallowClone, expectedPropertyValues

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(shallowClone = defaultBlender.blend {}, objectWithProtoInheritedProps)", ->
        shallowIncompleteClone = defaultBlender.blend {}, objectWithProtoInheritedProps

        describe "is an incomplete shallow clone, not copied inherited props: ", ->

          it "has NOT common references of all nested objects", ->
            sRefs = _B.getRefs objectWithProtoInheritedProps, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowIncompleteClone, {deep:true, inherited:true}
            expect(_B.isDisjoint(sRefs, cRefs)).to.be.true

          it "has NOT copied inherited nested object", ->
            expect(shallowIncompleteClone.aProp1 is undefined).to.be.true

          it "_.isEqual true (soft equality, same values/JSON)", ->
            expect(_.isEqual shallowIncompleteClone, objectWithProtoInheritedProps).to.be.true

          it "_B.isEqual true (soft equality, same values/JSON)", ->
            deepEqual shallowIncompleteClone, objectWithProtoInheritedProps

          it "_B.isExact true (strict references equality, no inherited props)", ->
            exact shallowIncompleteClone, objectWithProtoInheritedProps

          it "_B.isIqual false (inherited props, soft object equality)", ->
            notIqual shallowIncompleteClone, objectWithProtoInheritedProps

          it "_B.isIxact false (inherited props equality + strict references equality)", ->
            notIxact shallowIncompleteClone, objectWithProtoInheritedProps

  describe "Default 'Blender.blend' with inherited:true", ->
    defaultBlenderInheritedCopier = new _B.Blender [], inherited:true

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend {}, objectWithProtoInheritedProps)", ->
#        shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend {}, objectWithProtoInheritedProps
        shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend objectWithProtoInheritedProps # same as above

        describe "is a complete shallow clone, having shallow copied all inherited props: ", ->

          it "has common references of all nested objects", ->
            sRefs = _B.getRefs objectWithProtoInheritedProps, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowCloneInheritedCopied, {deep:true, inherited:true}
            equalSet sRefs, cRefs

          it "has copied inherited nested object", ->
            equal shallowCloneInheritedCopied.aProp1, objectWithProtoInheritedProps.aProp1
            expect(shallowCloneInheritedCopied.aProp1).to.not.be.an 'undefined'

          it "_.isEqual is false (soft equality, not looking at inherited props of source)", ->
            expect(_.isEqual shallowCloneInheritedCopied, objectWithProtoInheritedProps).to.be.false

          it "_B.isEqual is false (soft equality, not looking at inherited props of source)", ->
            notDeepEqual shallowCloneInheritedCopied, objectWithProtoInheritedProps

          it "_B.isExact is false (strict references equality, no inherited props of source)", ->
            notExact shallowCloneInheritedCopied, objectWithProtoInheritedProps

          it "_B.isIqual is true (inherited props, soft object equality)", ->
            iqual shallowCloneInheritedCopied, objectWithProtoInheritedProps

          it "_B.isIxact true (inherited props, strict references equality)", ->
            ixact shallowCloneInheritedCopied, objectWithProtoInheritedProps

  describe "Default 'Blender.blend' with copyProto:true", ->
    defaultBlenderProtoCopier = new _B.Blender [], copyProto:true

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(shallowClone = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps)", ->
        shallowCloneProtoCopied = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps

        describe "is a complete shallow clone, having shallow copied only own props & __proto__: ", ->

          it "has ALL common references of all nested objects", ->
            sRefs = _B.getRefs objectWithProtoInheritedProps, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowCloneProtoCopied, {deep:true, inherited:true}
            equalSet sRefs, cRefs

          it "has not copied inherited nested object, but can access it through __proto__ inheritance", ->
            equal shallowCloneProtoCopied.aProp1, objectWithProtoInheritedProps.aProp1
            expect(shallowCloneProtoCopied.aProp1).to.not.be.an 'undefined'
            expect(objectWithProtoInheritedProps.hasOwnProperty 'aProp1').to.be.false
            expect(shallowCloneProtoCopied.hasOwnProperty 'aProp1').to.be.false

           it "_.isEqual is true (soft equality, not looking at inherited props of either)", ->
            expect(_.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps)).to.be.true

          it "_B.isEqual is true (soft equality, not looking at inherited props of either)", ->
            deepEqual shallowCloneProtoCopied, objectWithProtoInheritedProps

          it "_B.isExact is true (strict references equality, no inherited props of either)", ->
            exact shallowCloneProtoCopied, objectWithProtoInheritedProps

          it "_B.isIqual is true (inherited props, soft object equality)", ->
            iqual shallowCloneProtoCopied, objectWithProtoInheritedProps

          it "_B.isIxact true (inherited props, strict references equality)", ->
            ixact shallowCloneProtoCopied, objectWithProtoInheritedProps

describe "DeepCloneBlender .blend:", ->

  describe "Default settings: with inherited:false, copyProto:false", ->

    deepCloneBlender = new _B.DeepCloneBlender # [] , {copyProto: true}

    describe "clones POJSO Object (no inheritance)", ->

      describe "(deepClone = deepCloneBlender.blend {}, expectedPropertyValues)", ->
#        deepClone  = deepCloneBlender.blend {}, expectedPropertyValues
        deepClone  = deepCloneBlender.blend expectedPropertyValues # same as above

        describe "is a deep clone", ->
          it "_B.isDisjoint true, NO common references in objects", ->
            expect(
              _B.isRefDisjoint(deepClone, expectedPropertyValues, {deep:true, inherited:true})
            ).to.be.true

          it "nested object is a clone it self - NOT the same reference", ->
            notEqual deepClone.aProp1, expectedPropertyValues.aProp1

          it "_.isEqual true (soft equality, same values/JSON)", ->
            expect(_.isEqual deepClone, expectedPropertyValues).to.be.true

          it "_B.isEqual true (soft equality, same values/JSON)", ->
            deepEqual deepClone, expectedPropertyValues

          it "_B.isExact is false (strict references equality)", ->
            notExact deepClone, expectedPropertyValues


    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(deepIncompleteClone = deepCloneBlender.blend {}, objectWithProtoInheritedProps)", ->
        deepIncompleteClone = deepCloneBlender.blend {}, objectWithProtoInheritedProps

        describe "is an incomplete deep clone, not copied inherited props: ", ->

          it "_B.isDisjoint true, has NO common references of all nested objects", ->
            expect(
              _B.isRefDisjoint(objectWithProtoInheritedProps, deepIncompleteClone, {deep:true, inherited:true})
            ).to.be.true

          it "has NOT copied inherited nested object", ->
            expect(deepIncompleteClone.aProp1 is undefined).to.be.true

          describe "equality of deepIncompleteClone, objectWithProtoInheritedProps", ->

            it "_.isEqual true (soft equality, same values/JSON)", ->
              expect(_.isEqual deepIncompleteClone, objectWithProtoInheritedProps).to.be.true

            it "_B.isEqual true (soft equality, same values/JSON)", ->
              deepEqual deepIncompleteClone, objectWithProtoInheritedProps

            it "_B.isIqual false (inherited props)", ->
              notIqual deepIncompleteClone, objectWithProtoInheritedProps

            it "_B.isExact true (strict references equality)", ->
              exact deepIncompleteClone, objectWithProtoInheritedProps

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              notIxact deepIncompleteClone, objectWithProtoInheritedProps

          describe "equality of deepInheritedClone, expectedPropertyValues", ->

            it "_.isEqual false (soft equality, same values/JSON)", ->
              expect(_.isEqual deepIncompleteClone, expectedPropertyValues).to.be.false

            it "_B.isEqual false (soft equality, same values/JSON)", ->
              notDeepEqual deepIncompleteClone, expectedPropertyValues

            it "_B.isIqual false (inherited props)", ->
              notIqual deepIncompleteClone, expectedPropertyValues

            it "_B.isExact false (strict references equality)", ->
              notExact deepIncompleteClone, expectedPropertyValues

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              notIxact deepIncompleteClone, expectedPropertyValues

  describe "with inherited:true :", ->

    deepCloneInheritedBlender = new _B.DeepCloneBlender [], {inherited:true}

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(deepInheritedClone = deepCloneInheritedBlender .blend {}, objectWithProtoInheritedProps)", ->
        deepInheritedClone = deepCloneInheritedBlender.blend objectWithProtoInheritedProps

        describe "is a complete deep clone, having deep cloned all inherited props as its own: ", ->

          it "_B.isDisjoint true, has NO common references of all nested objects", ->
            expect(
              _B.isRefDisjoint(objectWithProtoInheritedProps, deepInheritedClone, {deep:true, inherited:true})
            ).to.be.true

          describe "equality of deepInheritedClone, objectWithProtoInheritedProps", ->
            it "_.isEqual false (soft equality, not looking at inherited props of either)", ->
              expect(_.isEqual deepInheritedClone, objectWithProtoInheritedProps).to.be.false

            it "_B.isEqual false (soft equality, not looking at inherited props of either)", ->
              notDeepEqual deepInheritedClone, objectWithProtoInheritedProps

            it "_B.isIqual true (soft equality, inherited props)", ->
              iqual deepInheritedClone, objectWithProtoInheritedProps

            it "_B.isExact false (strict references equality)", ->
              notExact deepInheritedClone, objectWithProtoInheritedProps

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              notIxact deepInheritedClone, objectWithProtoInheritedProps

          describe "equality of deepInheritedClone, expectedPropertyValues", ->
            it "_.isEqual true (soft equality, all props are equal )", ->
              deepEqual deepInheritedClone, expectedPropertyValues

            it "_B.isEqual true (soft equality, all props are equal)", ->
              deepEqual deepInheritedClone, expectedPropertyValues

            it "_B.isIqual true (soft equality, inherited props, all props are equal)", ->
              iqual deepInheritedClone, expectedPropertyValues

            it "_B.isExact false (strict references equality)", ->
              notExact deepInheritedClone, expectedPropertyValues

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              notIxact deepInheritedClone, expectedPropertyValues

    describe "Using ['path'] orders in BlenderBehavior:", ->

      # a bit of a ['path'] order
      # All blenders below define the exact same thing (in a slightly different way):
      # "Destination 'Strings' inside 'bundle/basics' dont get overwriten by source 'String's!"

      blenders = []

      blenders.push new _B.DeepCloneBlender [
        order:['dst', 'path', 'src']
        String:                   # our destination MUST be String
          bundle: basics : '|':   # our PATH
            String:               # our source also MUST be String
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      ], isExactPath: false

      blenders.push new _B.DeepCloneBlender [
        order:['path', 'src', 'dst']
        bundle: basics : '|':   # our PATH
          String:               # our source also MUST be String
            String:             # our destination MUST be String
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      ], isExactPath: false

      blenders.push new _B.DeepCloneBlender [
        order:['path', 'src', 'dst']
        'bundle : basics': '|': # our PATH
          String:               # our source also MUST be String
            String:             # our destination MUST be String
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      ], isExactPath: false

      blenders.push new _B.DeepCloneBlender [
        order:['src', 'dst', 'path']
        String:               # our source also MUST be String
          String:             # our destination MUST be String
            ' bundle: basics': '|': # our PATH, using ':' as separator & triming
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do      )
      ], isExactPath: false

      blenders.push new _B.DeepCloneBlender [
        order:['src', 'dst', 'path']
        String:               # our source also MUST be String
          String:             # our destination MUST be String
            bundle: basics: '|': # our PATH
                (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      ], isExactPath: false

      o1 =
          bundle:
            someOkString: "OLD String#1"
            someOkStrings: ["OLD [String]#1", "OLD [String]#2"]
            basics:
              newString2: 665
              someObject: skippedString: 'OLD string #2'
              skippedString: 'OLD string #3'
              skippedStrings: ["OLD [String]#3", "OLD [String]#4"]
              anIntAsString: "665"
              anInt: 8
      o2 =
          bundle:
            someOkString: "OVERWRITTEN String#1"
            someOkStrings: ["OVERWRITTEN [String]#1", "OVERWRITTEN [String]#2"]
            basics:
              newString: "I am a OVERWRITTEN String, but on `undefined <-- String`, so I am ok!"
              newString2: "I am a OVERWRITTEN String, but on `Number <-- String`, so I am ok!"
              someObject: skippedString: 'SKIPed string #2'
              skippedString: 'SKIPed string #3'
              skippedStrings: ["SKIPed [String]#3", "SKIPed [String]#4"]
              anIntAsString: 77
              anInt: "18"

      expected =
          bundle:
            someOkString: 'OVERWRITTEN String#1'
            someOkStrings: [
              'OVERWRITTEN [String]#1',
              'OVERWRITTEN [String]#2'
            ]
            basics:
              newString: "I am a OVERWRITTEN String, but on `undefined <-- String`, so I am ok!"
              newString2: "I am a OVERWRITTEN String, but on `Number <-- String`, so I am ok!"
              someObject: skippedString: 'OLD string #2'
              skippedString: 'OLD string #3'
              skippedStrings: [ 'OLD [String]#3', 'OLD [String]#4' ]
              anIntAsString: 77 # `String<--Number` overwrites
              anInt: "18"       # `Number<--String` overwrites

      for blender, bi in blenders
        it "_.isEqual is true for blender ##{bi}", ->
          result = blender.blend {}, o1, o2
          expect(_.isEqual result, expected).to.be.true
#          expect(false).to.be.true

      #todo: with isExactPath
#      blenders.push new _B.DeepCloneBlender([
#        order:['src', 'dst', 'path']
#        String:               # our source also MUST be String
#          String:             # our destination MUST be String
#            bundle: basics:
#              overWrittingString: '|': -> _B.Blender.NEXT
#
#              '*': '|': # our PATH
#                (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
#      ], {pathTerminator: '|', isExactPath: false })

