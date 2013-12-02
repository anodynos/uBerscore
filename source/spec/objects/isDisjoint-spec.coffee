describe 'isDisjoint:', ->

  describe 'with primitives:', ->

    describe 'arrays:', ->
      it "recognises disjoint:", ->
        expect(_B.isDisjoint  [1, 2, 3], [4, 5, 6, '1']).to.be.true
        expect(_.intersection [1, 2, 3], [4, 5, 6, '1']).to.be.an('array').and.is.empty

      it "recognises non disjoint:", ->
        expect(_B.isDisjoint  [1, 2, 3], [4, 2, 5]).to.be.false
        expect(_.intersection [1, 2, 3], [4, 2, 5]).to.deep.equal [2]

    describe 'arrays & objects:', ->
      it "recognises disjoint in [] & {}:", ->
        expect(_B.isDisjoint  [4, 5, 6], {a:1, b:7, c:8}).to.be.true

      it "recognises non disjoint in [] & {}:", ->
        expect(_B.isDisjoint  [1, 2, 3], {a:1, b:7, c:8}).to.be.false

  describe 'with references:', ->
    o1 = p1:1
    o2 = p2:2
    o3 = p3:3
    o4 = p4:4

    describe 'arrays:', ->
      it "recognises disjoint:", ->
        expect(_B.isDisjoint  [o1, o2], [p1:1, o3, o4]).to.be.true
        expect(_.intersection [o1, o2], [p1:1, o3, o4]).to.deep.equal []

      it "recognises non disjoint:", ->
        expect(_B.isDisjoint  [o1, o2], [p1:1, o3, o4, o2]).to.be.false
        expect(_.intersection [o1, o2], [p1:1, o3, o4, o2]).to.deep.equal [o2]

    describe 'arrays & objects:', ->
      it "recognises disjoint in [] & {}", ->
        expect(_B.isDisjoint  [o1, o2], {p1:1, o3:o3, o4:o4}).to.be.true

      it "recognises non disjoint in [] & {}:", ->
        expect(_B.isDisjoint  [o1, o2], {p1:1, o3:o3, o4:o4, o2:o2}).to.be.false

    describe 'equality using _.isEqual :', ->
      it "recognises disjoint in [] & {}, without _.isEqual", ->
        expect(_B.isDisjoint  [o1, o2], {someP:{p1:1}, o3:o3}).to.be.true

      it "recognises non disjoint in [] & {}, when using _.isEqual", ->
        expect(_B.isDisjoint  [o1, o2], {someP:{p1:1}, o3:o3}, _.isEqual).to.be.false



