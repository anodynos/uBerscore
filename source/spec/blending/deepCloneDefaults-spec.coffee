assert = chai.assert
expect = chai.expect
# clone to check mutability
{ projectDefaults, globalDefaults, bundleDefaults
  obj, arrInt, arrInt2, arrStr
} = _.clone data, true

# @todo: rewrite this!!!!
# @todo: test _.mixin deepExtend

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


