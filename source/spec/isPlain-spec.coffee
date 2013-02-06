assert = chai.assert
expect = chai.expect
# clone to check mutability
{ projectDefaults, globalDefaults, bundleDefaults
  obj, arrInt, arrInt2, arrStr
} = _.clone data, true


describe 'isPlain :', ->

  it "Strings", ->
    expect(
      _B.isPlain 'I am a String'
    ).to.be true

  it "Numbers", ->
    expect(
      _B.isPlain 123
    ).to.be true

  it "Boolean", ->
    expect(
      _B.isPlain false
    ).to.be true

  it "not Objects", ->
    expect(
      _B.isPlain {a:'a'}
    ).to.be false

  it "not Arrays", ->
    expect(
      _B.isPlain [1,2,3]
    ).to.be false