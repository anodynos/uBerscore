assert = chai.assert
expect = chai.expect

isEqualArraySet = (a1, a2)->
  if _.difference(a1, a2).length is 0
    _.difference(a2, a1).length is 0
  else
    false

describe 'getRefs:', ->

  it "from array", ->
    oa = [  0
            1
            {p:[PP:3]}
            {a:b:->}
            4
          ]
    refs = _B.getRefs oa

    expect(
      isEqualArraySet refs, [
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
    refs = _B.getRefs(oa, true)
    expect(
      isEqualArraySet refs, [
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
      refs = _B.getRefs(oa, true)
      expect(isEqualArraySet refs, [
          oa.p2.p
          oa.p2.p[0]

          oa.p2 #order doesn't matter

          oa.p3
          oa.p3.a
          oa.p3.a.b
      ]).to.be.true
