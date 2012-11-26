chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require '../code/uBerscore' #

data = require '../spec/spec-data'
# clone to check mutability
projectDefaults = _.clone data.projectDefaults, true
globalDefaults = _.clone data.globalDefaults, true
bundleDefaults = _.clone data.bundleDefaults, true


describe 'deepCloneDefaults:', ->

  it "more 'specific' options eg. project, merged (taking precedence) to more 'global' defaults", ->
    result = _B.deepCloneDefaults projectDefaults, globalDefaults
#    console.log '\n', JSON.stringify result, null, ' '

    expect(
      result
    ).to.deep.equal
      'enabled': true
      'bundleRoot': '/global/project'
      'compilers':
#        'coffee-script': true
#        'urequire': true
        'rjs-build': 'project-rjs-build' # <- changed by projectDefaults


  it "many defaults", ->
    result = _B.deepCloneDefaults bundleDefaults, projectDefaults, globalDefaults

    expect(
      result
    ).to.deep.equal
      'enabled': true
      'bundleRoot': '/global/project/bundle'
      'compilers':
        'coffee-script':    # <- changed by someBundle
          'params': 'w b'
        'urequire':         # <- changed by someBundle
          'scanPrevent': true
        'rjs-build': 'project-rjs-build'  # <- changed by projectDefaults


  it "Original objects not mutated", ->
    expect(bundleDefaults).to.deep.equal data.bundleDefaults
    expect(projectDefaults).to.deep.equal data.projectDefaults
    expect(globalDefaults).to.deep.equal data.globalDefaults


