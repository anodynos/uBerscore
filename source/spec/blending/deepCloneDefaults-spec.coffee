assert = chai.assert
expect = chai.expect
# clone to check mutability
{ project, team, bundle, bundle_project_team
  obj, arrInt, arrInt2, arrStr
} = _.clone data, true

# @todo: rewrite this!!!!
# @todo: test _.mixin deepExtend

describe 'deepCloneDefaults:', ->

  it "more 'specific' options eg. project, merged (taking precedence) to more 'team' defaults", ->
    result = _B.deepCloneDefaults project, team
#    console.log '\n', JSON.stringify result, null, ' '

    expect(
      result
    ).to.deep.equal
      'enabled': true
      'bundleRoot': '/team/project'
      'compilers':
        'rjs-build': 'project-rjs-build' # <- changed by project

  it "many defaults", ->
    result = _B.deepCloneDefaults bundle, project, team
    expect(result).to.deep.equal bundle_project_team

  it "Original objects not mutated", ->
    expect(bundle).to.deep.equal data.bundle
    expect(project).to.deep.equal data.project
    expect(team).to.deep.equal data.team


