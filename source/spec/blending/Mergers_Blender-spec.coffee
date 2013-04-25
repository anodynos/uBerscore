### REAL mocha/chai START ###
if chai?
  assert = chai.assert
  expect = chai.expect
  { objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = data
### REAL mocha/chai END ###

### FAKE mocha/chai style tests START###
#if not chai?
#  basePath = '../../code/'
#  #todo: (3 4 2) Find a way to run real specs with 'run', no full build!
#  l = new (require basePath + 'Logger') 'Blender & merging'
#  errorCount = 0; hasError = false; level = 0; indent = ->("   " for i in [0..level]).join('')
#  describe = (msg, fn)->
#    l.verbose indent() + msg;
#    level++; fn(msg); level--
#    if errorCount and level is 0
#      l.warn 'Error count:' + errorCount
#
#  it = (msg, expectedFn)->
#    hasError = false; expectedFn();
#    if hasError
#      errorCount++
#      l.warn(indent() + msg + ' - false')
#    else
#      l.ok(indent() + msg + ' - OK')
#  expect = (v)-> hasError = true if not v
#  ### fake mocha/chai style tests ###
#
#  _ = require 'lodash'
#  _B = do()->
#      isRefDisjoint = require basePath + 'objects/isRefDisjoint'
#      isDisjoint = require basePath + 'objects/isDisjoint'
#      getRefs = require basePath + 'objects/getRefs'
#      isIqual = require basePath + 'objects/isIqual'
#      getRefs = require basePath + 'objects/getRefs'
#      isEqualArraySet = require basePath + 'collections/array/isEqualArraySet'
#      isEqual = require basePath + 'objects/isEqual'
#      isIqual = require basePath + 'objects/isIqual'
#      isExact = require basePath + 'objects/isExact'
#      isIxact = require basePath + 'objects/isIxact'
#      Blender = require basePath + 'blending/Blender'
#      DeepCloneBlender = require basePath + 'blending/blenders/DeepCloneBlender'
#
#      {isEqual, isIqual, isExact, isIxact, getRefs, isEqualArraySet, getRefs,
#      isRefDisjoint, isDisjoint, Blender, DeepCloneBlender}
#
#  { objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = require '../spec-data'
### FAKE mocha/chai style tests END###

describe "Default 'Blender.blend'", ->

  describe "Default settings: with inherited:false, copyProto:false", ->
    defaultBlender = new _B.Blender

    describe "clones POJSO Object (no inheritance)", ->

      describe "(shallowClone = defaultBlender.blend {}, expectedPropertyValues)", ->
        shallowClone = defaultBlender.blend {}, expectedPropertyValues

        describe "is a shallow clone and compared to source: ", ->
          it "is not RefDisjoint - (there is at least one common reference))", ->
            expect(_B.isRefDisjoint(shallowClone, expectedPropertyValues, {deep:true, inherited:true}) is false)

          it "has common references of all nested objects", ->
            sRefs = _B.getRefs expectedPropertyValues, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowClone, {deep:true, inherited:true}
            expect(_B.isEqualArraySet sRefs, cRefs)

          it "has a nested object copied by reference", ->
            expect(shallowClone.aProp1 is expectedPropertyValues.aProp1)
            expect(shallowClone.aProp1 isnt undefined)

          it "_.isEqual true (soft equality, same values/JSON)", ->
            expect(_.isEqual shallowClone, expectedPropertyValues)

          it "_B.isEqual true (soft equality, same values/JSON)", ->
            expect(_B.isEqual shallowClone, expectedPropertyValues)

          it "_B.isExact true (strict references equality)", ->
            expect(_B.isExact shallowClone, expectedPropertyValues)

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(shallowClone = defaultBlender.blend {}, objectWithProtoInheritedProps)", ->
        shallowIncompleteClone = defaultBlender.blend {}, objectWithProtoInheritedProps

        describe "is an incomplete shallow clone, not copied inherited props: ", ->

          it "has NOT common references of all nested objects", ->
            sRefs = _B.getRefs objectWithProtoInheritedProps, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowIncompleteClone, {deep:true, inherited:true}
            expect(_B.isDisjoint(sRefs, cRefs))

          it "has NOT copied inherited nested object", ->
            expect(shallowIncompleteClone.aProp1 is undefined)

          it "_.isEqual true (soft equality, same values/JSON)", ->
            expect(_.isEqual shallowIncompleteClone, objectWithProtoInheritedProps)

          it "_B.isEqual true (soft equality, same values/JSON)", ->
            expect(_B.isEqual shallowIncompleteClone, objectWithProtoInheritedProps)

          it "_B.isExact true (strict references equality, no inherited props)", ->
            expect(_B.isExact shallowIncompleteClone, objectWithProtoInheritedProps)

          it "_B.isIqual false (inherited props, soft object equality)", ->
            expect(!_B.isIqual shallowIncompleteClone, objectWithProtoInheritedProps)

          it "_B.isIxact false (inherited props equality + strict references equality)", ->
            expect(!_B.isIxact shallowIncompleteClone, objectWithProtoInheritedProps)


  describe "Default 'Blender.blend' with inherited:true", ->
    defaultBlenderInheritedCopier = new _B.Blender [], inherited:true

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend {}, objectWithProtoInheritedProps)", ->
        shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend {}, objectWithProtoInheritedProps

        describe "is a complete shallow clone, having shallow copied all inherited props: ", ->

          it "has common references of all nested objects", ->
            sRefs = _B.getRefs objectWithProtoInheritedProps, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowCloneInheritedCopied, {deep:true, inherited:true}
            expect(_B.isEqualArraySet sRefs, cRefs)

          it "has copied inherited nested object", ->
            expect(shallowCloneInheritedCopied.aProp1 is objectWithProtoInheritedProps.aProp1)
            expect(shallowCloneInheritedCopied.aProp1 isnt undefined)

          it "_.isEqual is false (soft equality, not looking at inherited props of source)", ->
            expect(!_.isEqual shallowCloneInheritedCopied, objectWithProtoInheritedProps)

          it "_B.isEqual is false (soft equality, not looking at inherited props of source)", ->
            expect(!_B.isEqual shallowCloneInheritedCopied, objectWithProtoInheritedProps)

          it "_B.isExact is false (strict references equality, no inherited props of source)", ->
            expect(!_B.isExact shallowCloneInheritedCopied, objectWithProtoInheritedProps)

          it "_B.isIqual is true (inherited props, soft object equality)", ->
            expect(_B.isIqual(shallowCloneInheritedCopied, objectWithProtoInheritedProps))

          it "_B.isIxact true (inherited props, strict references equality)", ->
            expect(_B.isIxact(shallowCloneInheritedCopied, objectWithProtoInheritedProps))

  describe "Default 'Blender.blend' with copyProto:true", ->
    defaultBlenderProtoCopier = new _B.Blender [], copyProto:true

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(shallowClone = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps)", ->
        shallowCloneProtoCopied = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps

        describe "is a complete shallow clone, having shallow copied only own props & __proto__: ", ->

          it "has ALL common references of all nested objects", ->
            sRefs = _B.getRefs objectWithProtoInheritedProps, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowCloneProtoCopied, {deep:true, inherited:true}
            expect(_B.isEqualArraySet sRefs, cRefs)

          it "has not copied inherited nested object, but can access it through __proto__ inheritance", ->
            expect(shallowCloneProtoCopied.aProp1 is objectWithProtoInheritedProps.aProp1)
            expect(shallowCloneProtoCopied.aProp1 isnt undefined)
            expect(!objectWithProtoInheritedProps.hasOwnProperty 'aProp1')
            expect(!shallowCloneProtoCopied.hasOwnProperty 'aProp1')

           it "_.isEqual is true (soft equality, not looking at inherited props of either)", ->
            expect(_.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps))

          it "_B.isEqual is true (soft equality, not looking at inherited props of either)", ->
            expect(_B.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps))

          it "_B.isExact is true (strict references equality, no inherited props of either)", ->
            expect(_B.isExact(shallowCloneProtoCopied, objectWithProtoInheritedProps) )

          it "_B.isIqual is true (inherited props, soft object equality)", ->
            expect(_B.isIqual(shallowCloneProtoCopied, objectWithProtoInheritedProps))

          it "_B.isIxact true (inherited props, strict references equality)", ->
            expect(_B.isIxact(shallowCloneProtoCopied, objectWithProtoInheritedProps))



describe "DeepCloneBlender .blend:", ->

  describe "Default settings: with inherited:false, copyProto:false", ->

    deepCloneBlender = new _B.DeepCloneBlender # [] , {copyProto: true}

    describe "clones POJSO Object (no inheritance)", ->

      describe "(deepClone = deepCloneBlender.blend {}, expectedPropertyValues)", ->
        deepClone  = deepCloneBlender.blend {}, expectedPropertyValues
        describe "is a deep clone", ->
          it "_B.isDisjoint true, NO common references in objects", ->
            expect(_B.isRefDisjoint(deepClone, expectedPropertyValues, {deep:true, inherited:true}))

          it "nested object is a clone it self - NOT the same reference", ->
            expect(deepClone.aProp1 isnt expectedPropertyValues.aProp1)

          it "_.isEqual true (soft equality, same values/JSON)", ->
            expect(_.isEqual deepClone, expectedPropertyValues)

          it "_B.isEqual true (soft equality, same values/JSON)", ->
            expect(_B.isEqual deepClone, expectedPropertyValues)

          it "_B.isExact is false (strict references equality)", ->
            expect(!_B.isExact deepClone, expectedPropertyValues)


    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(deepIncompleteClone = deepCloneBlender.blend {}, objectWithProtoInheritedProps)", ->
        deepIncompleteClone = deepCloneBlender.blend {}, objectWithProtoInheritedProps

        describe "is an incomplete deep clone, not copied inherited props: ", ->

          it "_B.isDisjoint true, has NO common references of all nested objects", ->
            expect(_B.isRefDisjoint(objectWithProtoInheritedProps, deepIncompleteClone, {deep:true, inherited:true}))

          it "has NOT copied inherited nested object", ->
            expect(deepIncompleteClone.aProp1 is undefined)

          describe "equality of deepIncompleteClone, objectWithProtoInheritedProps", ->

            it "_.isEqual true (soft equality, same values/JSON)", ->
              expect(_.isEqual deepIncompleteClone, objectWithProtoInheritedProps)

            it "_B.isEqual true (soft equality, same values/JSON)", ->
              expect(_B.isEqual deepIncompleteClone, objectWithProtoInheritedProps)

            it "_B.isIqual false (inherited props)", ->
              expect(!_B.isIqual deepIncompleteClone, objectWithProtoInheritedProps)

            it "_B.isExact true (strict references equality)", ->
              expect(_B.isExact deepIncompleteClone, objectWithProtoInheritedProps)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(!_B.isIxact deepIncompleteClone, objectWithProtoInheritedProps)

          describe "equality of deepInheritedClone, expectedPropertyValues", ->

            it "_.isEqual false (soft equality, same values/JSON)", ->
              expect(!_.isEqual deepIncompleteClone, expectedPropertyValues)

            it "_B.isEqual false (soft equality, same values/JSON)", ->
              expect(!_B.isEqual deepIncompleteClone, expectedPropertyValues)

            it "_B.isIqual false (inherited props)", ->
              expect(!_B.isIqual deepIncompleteClone, expectedPropertyValues)

            it "_B.isExact false (strict references equality)", ->
              expect(!_B.isExact deepIncompleteClone, expectedPropertyValues)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(!_B.isIxact deepIncompleteClone, expectedPropertyValues)


  describe "with inherited:true", ->

    deepCloneInheritedBlender = new _B.DeepCloneBlender [], {inherited:true}

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(deepInheritedClone = deepCloneInheritedBlender .blend {}, objectWithProtoInheritedProps)", ->
        deepInheritedClone = deepCloneInheritedBlender .blend {}, objectWithProtoInheritedProps

        describe "is a complete deep clone, having deep cloned all inherited props as its own: ", ->

          it "_B.isDisjoint true, has NO common references of all nested objects", ->
            expect(_B.isRefDisjoint(objectWithProtoInheritedProps, deepInheritedClone, {deep:true, inherited:true}))

          describe "equality of deepInheritedClone, objectWithProtoInheritedProps", ->
            it "_.isEqual false (soft equality, not looking at inherited props of either)", ->
              expect(!_.isEqual deepInheritedClone, objectWithProtoInheritedProps)

            it "_B.isEqual false (soft equality, not looking at inherited props of either)", ->
              expect(!_B.isEqual deepInheritedClone, objectWithProtoInheritedProps)

            it "_B.isIqual true (soft equality, inherited props)", ->
              expect(_B.isIqual deepInheritedClone, objectWithProtoInheritedProps)

            it "_B.isExact false (strict references equality)", ->
              expect(!_B.isExactdeepInheritedClone, objectWithProtoInheritedProps)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(!_B.isIxact deepInheritedClone, objectWithProtoInheritedProps)

          describe "equality of deepInheritedClone, expectedPropertyValues", ->
            it "_.isEqual true (soft equality, all props are equal )", ->
              expect(_.isEqual(deepInheritedClone, expectedPropertyValues))

            it "_B.isEqual true (soft equality, all props are equal)", ->
              expect(_B.isEqual deepInheritedClone, expectedPropertyValues)

            it "_B.isIqual true (soft equality, inherited props, all props are equal)", ->
              expect(_B.isIqual(deepInheritedClone, expectedPropertyValues))

            it "_B.isExact false (strict references equality)", ->
              expect(!_B.isExact deepInheritedClone, expectedPropertyValues)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(!_B.isIxact deepInheritedClone, expectedPropertyValues)

    describe "Something different & trivial: using ['path'] order in BlenderBehavior", ->

      # a bit of a ['path'] order
      # All blenders below define the exact same thing (in a slightly different way):
      # "Destination 'Strings' inside 'bundle/basics' dont get overwriten by source 'String's!"

      blenders = []

      blenders.push new _B.DeepCloneBlender(
        order:['dst', 'path', 'src']
        String:                   # our destination MUST be String
          bundle: basics : '|':   # our PATH
            String:               # our source also MUST be String
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      )

      blenders.push new _B.DeepCloneBlender(
        order:['path', 'src', 'dst']
        bundle: basics : '|':   # our PATH
          String:               # our source also MUST be String
            String:             # our destination MUST be String
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      )

      blenders.push new _B.DeepCloneBlender(
        order:['path', 'src', 'dst']
        '/bundle/basics/': '|': # our PATH
          String:               # our source also MUST be String
            String:             # our destination MUST be String
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      )

      blenders.push new _B.DeepCloneBlender(
        order:['src', 'dst', 'path']
        String:               # our source also MUST be String
          String:             # our destination MUST be String
            '/bundle/basics/': '|': # our PATH
              (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      )

      blenders.push new _B.DeepCloneBlender([
        order:['src', 'dst', 'path']
        String:               # our source also MUST be String
          String:             # our destination MUST be String
            bundle: basics: '|': # our PATH
                (prop, src, dst, blender)-> _B.Blender.SKIP # here's what we do
      ])


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
            expect(_.isEqual result, expected)

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
#      ], {pathTerminator: '|', isExactPath: true })

