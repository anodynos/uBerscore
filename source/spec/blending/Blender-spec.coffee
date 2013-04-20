if chai?
  assert = chai.assert
  expect = chai.expect

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
#      DeepDefaultsBlender = require basePath + 'blending/blenders/DeepDefaultsBlender'
#
#      {isEqual, isIqual, isExact, isIxact, getRefs, isEqualArraySet, getRefs,
#      isRefDisjoint, isDisjoint, Blender, DeepCloneBlender, DeepDefaultsBlender}
#
#  { objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues
#
#    project, team, bundle
#    bundle_project_team
#
#    earth
#    laboratory
#    experiment
#    earth_laboratory_experiment
#    experiment_laboratory_earth
#    laboratory_experiment
#  } = require '../spec-data'
### FAKE mocha/chai style tests END###


describe 'Blender:', ->
  describe 'Blender.shortifyTypeNames : ', ->
    it "corectly transforms nested types of srcDstSpecs to short format", ->
      longTypeNames = {
        order: ['src', 'dst']
        Array: String:'someAction'
        Object:
          "Array": "doSomeAction"
          "Null": ->

        doSomeAction:->
      }

      expectedShortified = {
        order: [ 'src', 'dst' ]
        doSomeAction: longTypeNames.doSomeAction # copy function ref
        '[]': "''": 'someAction'
        '{}':
          '[]': 'doSomeAction'
          'null': longTypeNames.Object.Null
      }

      expect(_.isEqual _B.Blender.shortifyTypeNames(longTypeNames), expectedShortified)

    describe 'Handles primitives:', ->

      blender = new _B.Blender

      it "overwrites undefined / null:", ->
        expect blender.blend(undefined, 6, 18) is 18
        expect blender.blend(undefined, 'a string') is 'a string'
        expect blender.blend(null, 16.7) is 16.7
        expect blender.blend(null, 'a string') is 'a string'
        expect _.isEqual(blender.blend(undefined, 18, {prop:'someValue'}), {prop:'someValue'})

      it "overwrites primitives", ->
        expect blender.blend(6, 18) is 18
        expect blender.blend('a string', 18, 'another string') is 'another string'
        expect _.isEqual(blender.blend('a string', 18, {prop:'someValue'}), {prop:'someValue'})

  describe 'Options passing', ->

    it "deepCloneBlender.anOption is someOptions.anOption", ->
      someOptions = {anOption:->'I am a function'}
      deepCloneBlender = new _B.DeepCloneBlender [], someOptions
      expect(deepCloneBlender.anOption is someOptions.anOption)

    it "real options: ", ->
      deepCloneBlender = new _B.DeepCloneBlender
      expect(deepCloneBlender.inherited is false)
      expect(deepCloneBlender.copyProto is false)

      deepCloneBlender = new _B.DeepCloneBlender [], {inherited: true, copyProto: true}
      expect(deepCloneBlender.inherited)
      expect(deepCloneBlender.copyProto)

    it "options go up the inheritance, respecting subclassed options", ->

      class SomeBlender extends _B.Blender

        constructor: (@blenderBehaviors...)->
          (@_optionsList or= []).unshift {someOption: "someOptionValue"}
          super

      someBlender = new SomeBlender
      expect(someBlender.someOption is "someOptionValue")

      someBlender = new SomeBlender [], someOption: "someOtherOptionValue"
      expect(someBlender.someOption is "someOtherOptionValue")

  describe 'Blender behaviours:', ->
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

    it "Numbers dont just overwrite each other: they add up", ->
      deepCloneBlenderAddingNumbers =
        new _B.DeepCloneBlender '|': 'Number': 'Number': (prop, src, dst)-> dst[prop]+src[prop]


      result = deepCloneBlenderAddingNumbers.blend {}, o1, o2

      expect(_.isEqual result,
        p1:15
        p2:
          p21:'Another String'
          p22: [25, 46, 'String in array']
        p3: 'Some string'
      )

    it "src Array items dont just overwrite the destination Array ones: they are increased by 1 (if numbers) & pushed in dst.", ->
      deepCloneBlenderAddingNumbers =
        new _B.DeepCloneBlender(
          '|': 'Array': 'Array': (prop, src, dst, bldr)->
              for item in src[prop]
                item = bldr.blend({}, {hack:item}).hack
                dst[prop].push item + if _.isNumber(item) then 1 else 0

              _B.Blender.SKIP
        )
      result = (deepCloneBlenderAddingNumbers.blend {}, o1, o2)
      expect(_.isEqual result,
        p1:10
        p2:
          p21:'Another String'
          p22: [5, 6, 'String in array', 21, 41]
        p3: 'Some string'
      )


    it "Strings are banned", ->
      deepCloneBlenderOmmitingStrings =
        new _B.DeepCloneBlender(
          order: ['src']
          '|': 'String': (prop, src, dst, bldr)-> _B.Blender.SKIP
        )
      result = (deepCloneBlenderOmmitingStrings.blend {}, o1, o2)
      expect(_.isEqual result,
        p1:10
        p2:
          p22: [20, 40]
      )
