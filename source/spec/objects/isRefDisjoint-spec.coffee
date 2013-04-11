assert = chai.assert
expect = chai.expect

o1 = p1:1
o2 = p2:2
o3 = p3:3
o4 = p4:4

describe 'isRefDisjoint:', ->

    describe 'arrays:', ->
      it "recognises disjoint:", ->
        expect(_B.isRefDisjoint [o1, o2], [o3, o4, a:b:o1], true).to.be.true
        expect(_.intersection [1, 2, 3], [4, 5, 6, '1']).to.deep.equal []


