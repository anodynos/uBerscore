### REAL mocha/chai START ###
if chai?
  assert = chai.assert
  expect = chai.expect
  { objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues

    project, team, bundle
    bundle_project_team

    earth
    laboratory
    experiment
    earth_laboratory_experiment
    experiment_laboratory_earth
    laboratory_experiment
  } = data
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

describe "Defaults: The DeepDefaultsBlender, overwritting only null/undefined & merging all nested types", ->

  describe "Default settings:", ->
    deepDefaultsBlender = new _B.DeepDefaultsBlender

    describe "bundle, project, team", ->
      result = deepDefaultsBlender.blend {}, bundle, project, team

      it "_.isEqual result, bundle_project_team", ->
        expect(_.isEqual result, bundle_project_team)

      it "_.isRefDisjoint result with each of bundle, project, team", ->
        for o in [bundle, project, team]
          expect(_B.isRefDisjoint result, o)

    describe "earth, laboratory, experiment", ->
      result = deepDefaultsBlender.blend {}, earth, laboratory, experiment

      it "_.isEqual result, earth_laboratory_experiment", ->
        expect(_.isEqual result, earth_laboratory_experiment)

      it "_.isRefDisjoint result with each of earth, laboratory, experiment", ->
        for o in [bundle, project, team]
          expect(_B.isRefDisjoint result, o)

    describe "experiment, laboratory, earth", ->
      result = deepDefaultsBlender.blend {}, experiment, laboratory, earth

      it "_.isEqual result, experiment_laboratory_earth", ->
        expect(_.isEqual result, experiment_laboratory_earth)

      it "_.isRefDisjoint result with each of experiment, laboratory, earth", ->
        for o in [experiment, laboratory, earth]
          expect(_B.isRefDisjoint result, o)

    describe "laboratory, experiment", ->
      result = deepDefaultsBlender.blend {}, laboratory, experiment

      it "_.isEqual result, laboratory_experiment", ->
        expect(_.isEqual result, laboratory_experiment)

      it "_.isRefDisjoint result with each of laboratory, experiment", ->
        for o in [laboratory, experiment]
          expect(_B.isRefDisjoint result, o)