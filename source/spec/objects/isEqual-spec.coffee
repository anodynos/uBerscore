assert = chai.assert
expect = chai.expect

{ objectWithPrototypeInheritedProps, Class3, expectedPropertyValues } = data

describe 'isEqual:', ->

  describe "object with __proro__ inherited properties (linked object hierarchy):", ->

    it "_B.isEqual OK", ->
      expect(_B.isEqual objectWithPrototypeInheritedProps, expectedPropertyValues, undefined,undefined, inherited:true).to.be.true
      expect(_B.isEqual expectedPropertyValues, objectWithPrototypeInheritedProps, undefined, undefined,  inherited:true).to.be.true

    it "_.isEqual fails", ->
      expect(_.isEqual objectWithPrototypeInheritedProps, expectedPropertyValues).to.be.false
      expect(_.isEqual expectedPropertyValues, objectWithPrototypeInheritedProps).to.be.false

    describe "with _.clone: ", ->
      clone = _.clone objectWithPrototypeInheritedProps

      it "_B.isEqual OK", ->
        expect(_B.isEqualInherited clone, expectedPropertyValues).to.be.true
        expect(_B.isEqualInherited expectedPropertyValues, clone).to.be.true

      it "with _.clone, _.isEqual fails", ->
        expect(_.isEqual clone, expectedPropertyValues).to.be.false
        expect(_.isEqual expectedPropertyValues, clone).to.be.false


  describe "coffeescript object with inherited properties:", ->

    c3 = new Class3

    it "_B.isEqual OK", ->
      expect(_B.isEqual c3, expectedPropertyValues, undefined, undefined, inherited:true).to.be.true
      expect(_B.isEqual expectedPropertyValues, c3, undefined, undefined, inherited:true).to.be.true

    it "_.isEqual fails", ->
      expect(_.isEqual c3, expectedPropertyValues).to.be.false
      expect(_.isEqual expectedPropertyValues, c3).to.be.false

    describe "with _.clone: ", ->
      clone = _.clone c3

      it "_B.isEqual OK", ->
        expect(_B.isEqualInherited clone, expectedPropertyValues).to.be.true
        expect(_B.isEqualInherited expectedPropertyValues, clone).to.be.true

      it "_.isEqual fails", ->
        expect(_.isEqual clone, expectedPropertyValues).to.be.false
        expect(_.isEqual expectedPropertyValues, clone).to.be.false