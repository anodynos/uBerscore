assert = chai.assert
expect = chai.expect

describe 'getRefs:', ->

  it "from array, deep = false", ->
    oa = [  0
            1
            {p:[PP:3]}
            {a:b:->}
            4
          ]
    refs = _B.getRefs oa

    expect( _B.isEqualArraySet refs, [
        oa[3] #order doesn't matter
        oa[2]
      ]).to.be.true

  it "from array, deep = true:", ->
    oa = [  0
            1
            {p:[PP:3]}
            {a:b:->}
            4
          ]
    refs = _B.getRefs(oa, deep:true)
    expect(_B.isEqualArraySet refs, [
        oa[2]
        oa[2].p
        oa[2].p[0]
        oa[3]
        oa[3].a
        oa[3].a.b
      ]).to.be.true

  it "from object, deep = true:", ->
      oa = {
        p0:0
        p1:1
        p2:p:[PP:3]
        p3:a:b:->
        p4:4
      }
      refs = _B.getRefs(oa, deep:true)
      expect(_B.isEqualArraySet refs, [
          oa.p2.p
          oa.p2.p[0]

          oa.p2 #order doesn't matter

          oa.p3
          oa.p3.a
          oa.p3.a.b
      ]).to.be.true
