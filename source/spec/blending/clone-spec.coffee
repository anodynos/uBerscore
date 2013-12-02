define -> describe "_B.clone:", ->

  checkShallow = (o1, o2)->
    expect(o1, o2).not.same
    expect(o1, o2).deep.equal

    expect(_B.isExact o1, o2).to.be.true
    expect(_B.isRefDisjoint o1, o2).to.be.false

    _.each o1, (v, key)->
      expect(o1[key]).equals(o2[key])

  checkDeep = (o1, o2)->
    expect(o1, o2).not.same
    expect(o1, o2).deep.equal

    expect(_B.isExact o1, o2).to.be.false
    expect(_B.isRefDisjoint o1, o2).to.be.true

    _.each o1, (v, key)->
      if !_B.isPlain o1[key]
        expect(o1[key]).not.equals(o2[key])

  describe "simple clonning:", ->
    obj = [{a:1}, {b:b2:2}]

    it "defaults to shallow copy", ->
      checkShallow obj, _B.clone obj

    describe "copies deep with option deep:", ->

      it "as boolean", ->
        checkDeep obj, _B.clone obj, true

      it "as options `deep` key", ->
        checkDeep obj, _B.clone obj, deep:true

  describe "with copyProto:", ->
    Creator = ->
      @a = 1
      @b = b2:2
      @
    creatorPrototype = creatorPrototype: "hereIam"
    Creator::creatorPrototype = creatorPrototype

    obj = new Creator

    it "defaults to shallow copy", ->
      cloned = _B.clone obj, copyProto: true
      checkShallow obj, cloned
      expect(
        Object.getPrototypeOf(obj)
        Object.getPrototypeOf(cloned)
      ).to.be.equal

    it "with option deep", ->
      cloned = _B.clone obj, {deep:true}
      checkDeep obj, cloned

      expect(
        Object.getPrototypeOf(obj)
        Object.getPrototypeOf(cloned)
      ).to.be.equal