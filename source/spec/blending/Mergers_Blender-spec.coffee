assert = chai.assert
expect = chai.expect
{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = data

#### fake mocha/chai style tests ###
#basePath = '../../code/'
##todo: (3 4 2) Find a way to run real specs with 'run', no full build!
#l = new (require basePath + 'Logger') 'Blender & merging'
#errorCount = 0; hasError = false; level = 0; indent = ->("   " for i in [0..level]).join('')
#describe = (msg, fn)->
#  l.verbose indent() + msg;
#  level++; fn(msg); level--
#  if errorCount and level is 0
#    l.warn 'Error count:' + errorCount
#
#it = (msg, expectedFn)->
#  hasError = false; expectedFn();
#  if hasError
#    errorCount++
#    l.warn(indent() + msg + ' - false')
#  else
#    l.ok(indent() + msg + ' - OK')
#expect = (v)-> hasError = true if not v
#### fake mocha/chai style tests ###
#
#_ = require 'lodash'
#_B = do()->
#
#  isRefDisjoint = require basePath + 'objects/isRefDisjoint'
#  isDisjoint = require basePath + 'objects/isDisjoint'
#  getRefs = require basePath + 'objects/getRefs'
#  isIqual = require basePath + 'objects/isIqual'
#  getRefs = require basePath + 'objects/getRefs'
#  isEqualArraySet = require basePath + 'collections/array/isEqualArraySet'
#  isEqual = require basePath + 'objects/isEqual'
#  isIqual = require basePath + 'objects/isIqual'
#  isExact = require basePath + 'objects/isExact'
#  isIxact = require basePath + 'objects/isIxact'
#  Blender = require basePath + 'blending/Blender'
#  DeepCloneBlender = require basePath + 'blending/blenders/DeepCloneBlender'
#
#  {isEqual, isIqual, isExact, isIxact, getRefs, isEqualArraySet, getRefs, isRefDisjoint, isDisjoint, Blender, DeepCloneBlender}
#
#{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = require '../spec-data'


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
            expect(_B.isIqual(shallowIncompleteClone, objectWithProtoInheritedProps) is false)

          it "_B.isIxact false (inherited props equality + strict references equality)", ->
            expect(_B.isIxact(shallowIncompleteClone, objectWithProtoInheritedProps) is false)


  describe "Default 'Blender.blend' with inherited:true", ->
    defaultBlenderProtoCopier = new _B.Blender [], inherited:true

    describe "clones objectWithProtoInheritedProps (with inheritance)", ->

      describe "(shallowClone = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps)", ->
        shallowCloneProtoCopied = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps

        describe "is a complete shallow clone, having shallow copied all inherited props: ", ->

          it "has common references of all nested objects", ->
            sRefs = _B.getRefs objectWithProtoInheritedProps, {deep:true, inherited:true}
            cRefs = _B.getRefs shallowCloneProtoCopied, {deep:true, inherited:true}
            expect(_B.isEqualArraySet sRefs, cRefs)

          it "has copied inherited nested object", ->
            expect(shallowCloneProtoCopied.aProp1 is objectWithProtoInheritedProps.aProp1)
            expect(shallowCloneProtoCopied.aProp1 isnt undefined)

          it "_.isEqual is false (soft equality, not looking at inherited props of source)", ->
            expect(_.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps) is false)

          it "_B.isEqual is false (soft equality, not looking at inherited props of source)", ->
            expect(_B.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps) is false)

          it "_B.isExact is false (strict references equality, no inherited props of source)", ->
            expect(_B.isExact(shallowCloneProtoCopied, objectWithProtoInheritedProps) is false)

          it "_B.isIqual is true (inherited props, soft object equality)", ->
            expect(_B.isIqual(shallowCloneProtoCopied, objectWithProtoInheritedProps))

          it "_B.isIxact true (inherited props, strict references equality)", ->
            expect(_B.isIxact(shallowCloneProtoCopied, objectWithProtoInheritedProps))

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
            expect(objectWithProtoInheritedProps.hasOwnProperty('aProp1') is false)
            expect(shallowCloneProtoCopied.hasOwnProperty('aProp1') is false)

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
            expect(_B.isExact(deepClone, expectedPropertyValues) is false)


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
              expect(_B.isIqual(deepIncompleteClone, objectWithProtoInheritedProps) is false)

            it "_B.isExact true (strict references equality)", ->
              expect(_B.isExact deepIncompleteClone, objectWithProtoInheritedProps)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(_B.isIxact(deepIncompleteClone, objectWithProtoInheritedProps) is false)

          describe "equality of deepInheritedClone, expectedPropertyValues", ->

            it "_.isEqual false (soft equality, same values/JSON)", ->
              expect(_.isEqual(deepIncompleteClone, expectedPropertyValues) is false)

            it "_B.isEqual false (soft equality, same values/JSON)", ->
              expect(_B.isEqual(deepIncompleteClone, expectedPropertyValues) is false)

            it "_B.isIqual false (inherited props)", ->
              expect(_B.isIqual(deepIncompleteClone, expectedPropertyValues) is false)

            it "_B.isExact false (strict references equality)", ->
              expect(_B.isExact(deepIncompleteClone, expectedPropertyValues) is false)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(_B.isIxact(deepIncompleteClone, expectedPropertyValues) is false)


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
              expect(_.isEqual(deepInheritedClone, objectWithProtoInheritedProps) is false)

            it "_B.isEqual false (soft equality, not looking at inherited props of either)", ->
              expect(_B.isEqual(deepInheritedClone, objectWithProtoInheritedProps) is false)

            it "_B.isIqual true (soft equality, inherited props)", ->
              expect(_B.isIqual(deepInheritedClone, objectWithProtoInheritedProps))

            it "_B.isExact false (strict references equality)", ->
              expect(_B.isExact(deepInheritedClone, objectWithProtoInheritedProps) is false)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(_B.isIxact(deepInheritedClone, objectWithProtoInheritedProps) is false)

          describe "equality of deepInheritedClone, expectedPropertyValues", ->
            it "_.isEqual true (soft equality, all props are equal )", ->
              expect(_.isEqual(deepInheritedClone, expectedPropertyValues))

            it "_B.isEqual false (soft equality, all props are equal)", ->
              expect(_B.isEqual(deepInheritedClone, expectedPropertyValues))

            it "_B.isIqual true (soft equality, inherited props, all props are equal)", ->
              expect(_B.isIqual(deepInheritedClone, expectedPropertyValues))

            it "_B.isExact false (strict references equality)", ->
              expect(_B.isExact(deepInheritedClone, expectedPropertyValues) is false)

            it "_B.isIxact false (inherited props, scrict references equality)", ->
              expect(_B.isIxact(deepInheritedClone, expectedPropertyValues) is false)

