chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore'

describe "Get classes of inherited classes", ->
  class OtherClass extends _B.CoffeeUtils
  class SubClass extends OtherClass
  class SubSubClass extends SubClass

  sc = new SubClass
  ssc = new SubSubClass

  describe "Get extending classes in descenting order, including the own as last:", ->
    scClasses = [_B.CoffeeUtils, OtherClass, SubClass]
    sscClasses = [_B.CoffeeUtils, OtherClass, SubClass, SubSubClass ]

    describe "without params:", ->

      describe "called on target instance:", ->
        it "#1", ->
          expect(ssc.getClasses()).to.deep.equal sscClasses
          #expect(ssc.classes).to.deep.equal sscClasses

        it "#2", ->
          expect(sc.getClasses()).to.deep.equal scClasses
          #expect(sc.classes).to.deep.equal scClasses

      describe "called staticically (on target class):", ->
        it "#1", -> expect(SubSubClass.getClasses()).to.deep.equal sscClasses
        it "#2", -> expect(SubClass.getClasses()).to.deep.equal scClasses

    describe "with instance as param:", ->

      describe "called on (any) instance:", ->
        it "#1", -> expect(sc.getClasses ssc).to.deep.equal sscClasses
        it "#2", -> expect(ssc.getClasses sc).to.deep.equal scClasses

      describe "called statically (on any class):", ->
        it "#1", ->
          expect(_B.CoffeeUtils.getClasses ssc).to.deep.equal sscClasses
          expect(SubClass.getClasses ssc).to.deep.equal sscClasses
          expect(SubSubClass.getClasses ssc).to.deep.equal sscClasses

        it "#2", ->
          expect(_B.CoffeeUtils.getClasses sc).to.deep.equal scClasses
          expect(SubClass.getClasses sc).to.deep.equal scClasses
          expect(SubSubClass.getClasses sc).to.deep.equal scClasses

    describe "with class as param:", ->

      describe "called on (any) instance:", ->
        it "#1", -> expect(sc.getClasses SubSubClass).to.deep.equal sscClasses
        it "#2", -> expect(ssc.getClasses SubClass).to.deep.equal scClasses

      describe "called staticically (on any class):", ->
        it "#1", -> expect(SubClass.getClasses SubSubClass).to.deep.equal sscClasses
        it "#2", -> expect(SubSubClass.getClasses SubClass).to.deep.equal scClasses
