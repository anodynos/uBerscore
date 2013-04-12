assert = chai.assert
expect = chai.expect

O1 = o1 = p1:1
o2 = p2:2
o3 = p3:3
o4 = p4:4

#genuinly disjoint
a1_2 = [o1, o2]
o1_2 = {p1:o1, p2:o2}

a3_4 = [o3, o4]
o3_4 = {p3:o3, p4:o4}

#genuinly non-disjoint
a3_4_2 = [o3, o4, o2]
o3_4_2 = {p3:o3, p4:o4, p5:o2}

a3_4_a1_2 = [o3, o4, a1_2]
o3_4_o1_2 = {p3:o3, p4:o4, p5:o1_2}

a3_4_nested_o2 = [o3, o4, a:b:o2]
o3_4_nested_o2 = {p3:o3, p4:o4, p5:a:b:o2}

a3_4_nested_a1_2 = [o3, o4, a:b:a1_2]
o3_4_nested_o1_2 = {p3:o3, p4:o4, p5:a:b:o1_2}

describe 'isRefDisjoint:', ->

  it "recognises self as non disjoint:", ->
    expect(_B.isRefDisjoint o1, O1 ).to.be.false

  describe 'Arrays:', ->
    describe 'with deep=false (shallow):', ->

      it "recognises disjoint:", ->
        expect(_B.isRefDisjoint a1_2, a3_4).to.be.true
        expect(_B.isRefDisjoint a3_4, a1_2).to.be.true

      it "recognises non-disjoint", ->
        expect(_B.isRefDisjoint a1_2, a3_4_2).to.be.false
        expect(_B.isRefDisjoint a3_4_2, a1_2).to.be.false

      describe "recognises disjoint:", ->
        it "with nested shared reference", ->
          expect(_B.isRefDisjoint a1_2, a3_4_nested_o2, false).to.be.true
          expect(_B.isRefDisjoint a3_4_nested_o2, a1_2, false).to.be.true

        it "with one side being a shared reference", ->
          expect(_B.isRefDisjoint a1_2, a3_4_nested_a1_2, false).to.be.true
          expect(_B.isRefDisjoint a3_4_nested_a1_2, a1_2, false).to.be.true

    describe 'with deep=true:', ->

      it "recognises disjoint:", ->
        expect(_B.isRefDisjoint a1_2, a3_4, true).to.be.true
        expect(_B.isRefDisjoint a3_4, a1_2, true).to.be.true

      describe "recognises non-disjoint:", ->

        it "with nested shared reference", ->
          expect(_B.isRefDisjoint a1_2, a3_4_nested_o2, true).to.be.false
          expect(_B.isRefDisjoint a3_4_nested_o2, a1_2, true).to.be.false

        it "with one side being a shared reference", ->
          expect(_B.isRefDisjoint a1_2, a3_4_nested_a1_2, true).to.be.false
          expect(_B.isRefDisjoint a3_4_nested_a1_2, a1_2, true).to.be.false

  describe 'Objects:', ->

    describe 'with deep=false (shallow):', ->

      it "recognises disjoint:", ->
        expect(_B.isRefDisjoint o1_2, o3_4).to.be.true
        expect(_B.isRefDisjoint o3_4, o1_2).to.be.true

      it "recognises non-disjoint", ->
        expect(_B.isRefDisjoint o1_2, o3_4_2).to.be.false
        expect(_B.isRefDisjoint o3_4_2, o1_2).to.be.false

      describe "recognises disjoint:", ->
        it "with nested shared reference", ->
          expect(_B.isRefDisjoint o1_2, o3_4_nested_o2, false).to.be.true
          expect(_B.isRefDisjoint o3_4_nested_o2, o1_2, false).to.be.true

        it "with one side being a shared reference", ->
          expect(_B.isRefDisjoint o1_2, o3_4_nested_o1_2, false).to.be.true
          expect(_B.isRefDisjoint o3_4_nested_o1_2, o1_2, false).to.be.true

    describe 'with deep=true:', ->

      it "recognises disjoint:", ->
        expect(_B.isRefDisjoint o1_2, o3_4, true).to.be.true
        expect(_B.isRefDisjoint o3_4, o1_2, true).to.be.true

      describe "recognises non-disjoint:", ->

        it "with nested shared reference", ->
          expect(_B.isRefDisjoint o1_2, o3_4_nested_o2, true).to.be.false
          expect(_B.isRefDisjoint o3_4_nested_o2, o1_2, true).to.be.false

        it "with one side being a shared reference", ->
          expect(_B.isRefDisjoint o1_2, o3_4_nested_o1_2, true).to.be.false
          expect(_B.isRefDisjoint o3_4_nested_o1_2, o1_2, true).to.be.false

  describe 'Mixed Arrays & Objects:', ->

    describe 'with deep=false (shallow):', ->

      it "recognises disjoint:", ->
        expect(_B.isRefDisjoint o1_2, a3_4).to.be.true
        expect(_B.isRefDisjoint o3_4, a1_2).to.be.true

      it "recognises non-disjoint", ->
        expect(_B.isRefDisjoint o1_2, a3_4_2).to.be.false
        expect(_B.isRefDisjoint o3_4_2, a1_2).to.be.false

      describe "recognises disjoint:", ->
        it "with nested shared reference", ->
          expect(_B.isRefDisjoint o1_2, a3_4_nested_o2, false).to.be.true
          expect(_B.isRefDisjoint o3_4_nested_o2, a1_2, false).to.be.true

        it "with one side being a shared reference", ->
          expect(_B.isRefDisjoint [o1_2], o3_4_nested_o1_2, false).to.be.true
          expect(_B.isRefDisjoint [o3_4_nested_o1_2], o1_2, false).to.be.true

    describe 'with deep=true:', ->

      it "recognises disjoint:", ->
        expect(_B.isRefDisjoint o1_2, a3_4, true).to.be.true
        expect(_B.isRefDisjoint o3_4, a1_2, true).to.be.true

      describe "recognises non-disjoint:", ->

        it "with nested shared reference", ->
          expect(_B.isRefDisjoint o1_2, a3_4_nested_o2, true).to.be.false
          expect(_B.isRefDisjoint o3_4_nested_o2, a1_2, true).to.be.false

        it "with one side being a shared reference", ->
          expect(_B.isRefDisjoint [o1_2], o3_4_nested_o1_2, true).to.be.false
          expect(_B.isRefDisjoint [o3_4_nested_o1_2], o1_2, true).to.be.false

