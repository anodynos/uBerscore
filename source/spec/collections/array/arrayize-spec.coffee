# clone to check mutability
{ project, global, bundle,  obj, arrInt, arrInt2, arrStr } = _.clone data, true

# @todo: use data + more examples

describe 'arrayize :', ->

  it "arrayize a String", ->
    expect(
      _B.arrayize 'agelos'
    ).to.deep.equal ['agelos']

  it "arrayize a Number", ->
    expect(
      _B.arrayize 19
    ).to.deep.equal [19]

  it "arrayize an Object", ->
    expect(
      _B.arrayize {a:1, b:2}
    ).to.deep.equal [{a:1, b:2}]

  it "arrayize an existing array", ->
    arr = [1, 'john']
    expect(
      _B.arrayize arr
    ).to.equal arr

  it "arrayize nothingness", ->
    expect(
      _B.arrayize undefined
    ).to.deep.equal []
