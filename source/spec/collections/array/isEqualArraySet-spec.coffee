assert = chai.assert
expect = chai.expect
# clone to check mutability
{ obj, arrInt, arrInt2, arrStr } = _.clone data, true

describe 'isEqualArraySet :', ->

  it "simple arrays with primitives", ->
    expect(
      _B.isEqualArraySet [1, 2, 3, 'John', 'Doe'], ['John', 3, 'Doe', 2, 1]
    ).to.be.true

  it "arrays with primitives & references", ->
    expect(
      _B.isEqualArraySet [ obj, arrInt, arrStr, 2, 3, 'John', 'Doe'],
                         [ obj, 'John', arrInt, 3, arrStr, 'Doe', 2]
    ).to.be.true

