describe 'getRefs:', ->

  it "from array, deep = false", ->
    oa = [  0
            1
            {p:[PP:3]}
            {a:b:->}
            4
          ]

    equalSet _B.getRefs(oa), [ oa[3], oa[2]]

  it "from array, deep = true:", ->
    oa = [  0
            1
            {p:[PP:3]}
            {a:b:->}
            4
          ]
    equalSet _B.getRefs(oa, deep:true), [
        oa[2]
        oa[2].p
        oa[2].p[0]
        oa[3]
        oa[3].a
        oa[3].a.b
      ]

  it "from object, deep = true:", ->
      oa = {
        p0:0
        p1:1
        p2:p:[PP:3]
        p3:a:b:->
        p4:4
      }
      equalSet _B.getRefs(oa, deep:true), [
          oa.p2.p
          oa.p2.p[0]

          oa.p2 #order doesn't matter

          oa.p3
          oa.p3.a
          oa.p3.a.b
      ]
