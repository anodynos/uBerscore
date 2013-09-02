chai = require "chai"
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore'
l = new _B.Logger 'spec/utils/CalcCachedProperties-spec'

describe "_B.CalcCachedProperties:", ->

  class CalcCachedProperties2 extends _B.CalcCachedProperties

  class SelfishNumber extends CalcCachedProperties2
    constructor: ->
      super
      @setNums.apply @, arguments

    setNums: (@x, @y)->
      @calcHits = {}

    @calcProperties =
      doubled: ->
        @calcHits.doubled = (@calcHits.doubled or 0) + 1
        if @x < 1000
          @x + @x
        else
          undefined # a valid cached result

      added: ->
        @calcHits.added = (@calcHits.added or 0) + 1
        @x + 1

  class DirtyNumbers extends SelfishNumber

    @calcProperties =
      added: ->
        @calcHits.added = (@calcHits.added or 0) + 1
        @x + @y

      multiplied: ->
        @calcHits.multiplied = (@calcHits.multiplied or 0) + 1
        @x * @y


  describe "Get classes & calcProperties of inherited classes", ->
    dn = new DirtyNumbers
    sn = new SelfishNumber


    describe "called on target instance:", ->
      it "#1", ->
        expect(dn.classes).to.deep.equal [_B.CoffeeUtils, _B.CalcCachedProperties, CalcCachedProperties2, SelfishNumber, DirtyNumbers ]

      it "#2", ->
        expect(sn.classes).to.deep.equal [_B.CoffeeUtils, _B.CalcCachedProperties, CalcCachedProperties2, SelfishNumber]


    describe "Get all calculated properties, overriding properties in parent classes:", ->
      allDnProperties =
        doubled: SelfishNumber.calcProperties.doubled
        added: DirtyNumbers.calcProperties.added # overriden
        multiplied: DirtyNumbers.calcProperties.multiplied

      allSnProperties =
        doubled: SelfishNumber.calcProperties.doubled
        added: SelfishNumber.calcProperties.added

      describe "without params:", ->
        describe "called on instance:", ->
          it "#1", ->
            expect(dn.getAllCalcProperties()).to.deep.equal allDnProperties
            expect(dn.allCalcProperties).to.deep.equal allDnProperties

          it "#2", ->
            expect(sn.getAllCalcProperties()).to.deep.equal allSnProperties
            expect(sn.allCalcProperties).to.deep.equal allSnProperties

        describe "called statically:", ->
          it "#1", ->expect(DirtyNumbers.getAllCalcProperties()).to.deep.equal allDnProperties
          it "#2", -> expect(SelfishNumber.getAllCalcProperties()).to.deep.equal allSnProperties

      describe "with instance as param:", ->

        describe "called on (any) instance:", ->
          it "#1", -> expect(sn.getAllCalcProperties dn ).to.deep.equal allDnProperties
          it "#2", -> expect(dn.getAllCalcProperties sn).to.deep.equal allSnProperties

        describe "called statically (on any class):", ->
          it "#1", ->
            expect(DirtyNumbers.getAllCalcProperties dn ).to.deep.equal allDnProperties
            expect(SelfishNumber.getAllCalcProperties dn ).to.deep.equal allDnProperties
            expect(_B.CalcCachedProperties.getAllCalcProperties dn ).to.deep.equal allDnProperties
          it "#2", ->
            expect(DirtyNumbers.getAllCalcProperties sn).to.deep.equal allSnProperties
            expect(SelfishNumber.getAllCalcProperties sn).to.deep.equal allSnProperties
            expect(_B.CalcCachedProperties.getAllCalcProperties sn).to.deep.equal allSnProperties

      describe "with class as param:", ->

        describe "called on (any) instance:", ->
          it "#1", -> expect(sn.getAllCalcProperties DirtyNumbers).to.deep.equal allDnProperties
          it "#2", -> expect(dn.getAllCalcProperties SelfishNumber).to.deep.equal allSnProperties

        describe "called statically (on any class):", ->
          it "#1", ->
            expect(_B.CalcCachedProperties.getAllCalcProperties DirtyNumbers).to.deep.equal allDnProperties
            expect(SelfishNumber.getAllCalcProperties DirtyNumbers).to.deep.equal allDnProperties
          it "#2", ->
            expect(_B.CalcCachedProperties.getAllCalcProperties SelfishNumber).to.deep.equal allSnProperties
            expect(DirtyNumbers.getAllCalcProperties SelfishNumber).to.deep.equal allSnProperties

  describe "calculating & caching properties:", ->
    dn = new DirtyNumbers 3, 4
    dn2 = new DirtyNumbers 5, 6

    describe "calculates calcProperties once:", ->

      it "#1", ->
        expect(dn.doubled).to.equal 6
        expect(dn.doubled).to.equal 6
        expect(dn.calcHits.doubled).to.equal 1

        expect(dn.added).to.equal 7
        expect(dn.added).to.equal 7
        expect(dn.calcHits.added).to.equal 1

        expect(dn.multiplied).to.equal 12
        expect(dn.multiplied).to.equal 12
        expect(dn.calcHits.multiplied).to.equal 1

      it "#2", ->
        expect(dn2.doubled).to.equal 10
        expect(dn2.doubled).to.equal 10
        expect(dn2.calcHits.doubled).to.equal 1

        expect(dn2.added).to.equal 11
        expect(dn2.added).to.equal 11
        expect(dn2.calcHits.added).to.equal 1

        expect(dn2.multiplied).to.equal 30
        expect(dn2.multiplied).to.equal 30
        expect(dn2.calcHits.multiplied).to.equal 1

    describe "remembers cached result, without calculating", ->

      it "#1", ->
        dn.x = 5; dn.y = 4;
        expect(dn.added).to.equal 7
        expect(dn.added).to.equal 7
        expect(dn.calcHits.added).to.equal 1

        expect(dn.multiplied).to.equal 12
        expect(dn.multiplied).to.equal 12
        expect(dn.calcHits.multiplied).to.equal 1

      it "#2", ->
        dn2.x = 2; dn2.y = 3;
        expect(dn2.added).to.equal 11
        expect(dn2.added).to.equal 11
        expect(dn2.calcHits.added).to.equal 1

        expect(dn2.multiplied).to.equal 30
        expect(dn2.multiplied).to.equal 30
        expect(dn2.calcHits.multiplied).to.equal 1

    describe "clearing cached property value & recalculate 'em:", ->

      it "clears cached properties by name & recalculates them on demand", ->
        expect(dn.cleanProps 'added').to.deep.equal ['added']

        dn.x = 6; dn.y = 3
        expect(dn.calcHits.added).to.equal 1

        expect(dn.added).to.equal 9
        expect(dn.calcHits.added).to.equal 2

        expect(dn.added).to.equal 9
        expect(dn.added).to.equal 9
        expect(dn.calcHits.added).to.equal 2

        expect(dn.calcHits.multiplied).to.equal 1
        expect(dn.multiplied).to.equal 12
        expect(dn.multiplied).to.equal 12
        expect(dn.calcHits.multiplied).to.equal 1

      it "clears cached property values by name or function, ignoring undefined", ->
        dn.x = 6; dn.y = 4
        expect(
          dn.cleanProps undefined, 'doubled', undefined, ((nme)-> nme is 'multiplied'), undefined
        ).to.deep.equal ['doubled', 'multiplied']

        # cleared, recalculating once
        expect(dn.calcHits.doubled).to.equal 1
        expect(dn.doubled).to.equal 12
        expect(dn.doubled).to.equal 12
        expect(dn.calcHits.doubled).to.equal 2

        # not cleared, stays as is
        expect(dn.calcHits.added).to.equal 2
        expect(dn.added).to.equal 9
        expect(dn.added).to.equal 9
        expect(dn.calcHits.added).to.equal 2

        # cleared, recalculating once
        expect(dn.calcHits.multiplied).to.equal 1
        expect(dn.multiplied).to.equal 24
        expect(dn.multiplied).to.equal 24
        expect(dn.calcHits.multiplied).to.equal 2

      describe "clears all cached property values, recalculates them all on demand", ->

        it "clears all cached property values", ->
          expect(
            dn.cleanProps()
          ).to.deep.equal ['doubled', 'added', 'multiplied']

        it "clearing forces recaclulation of inherited property value", ->
          dn.setNums 4, 7
          # cleared, recalculating once
          expect(dn.calcHits.doubled).to.equal undefined
          expect(dn.doubled).to.equal 8
          expect(dn.doubled).to.equal 8
          expect(dn.calcHits.doubled).to.equal 1

        it "clearing forces recaclulation of property value", ->
          dn.setNums 4, 7
          # not cleared, stays as is
          expect(dn.calcHits.added).to.equal undefined
          expect(dn.added).to.equal 11
          expect(dn.added).to.equal 11
          expect(dn.calcHits.added).to.equal 1

          # cleared, recalculating once
          expect(dn.calcHits.multiplied).to.equal undefined
          expect(dn.multiplied).to.equal 28
          expect(dn.multiplied).to.equal 28
          expect(dn.calcHits.multiplied).to.equal 1

  describe "undefined is a valid cached result", ->
    dn = new DirtyNumbers 1001

    it "undefined is a valid cached result", ->
      # cleared, recalculating once
      expect(dn.calcHits.doubled).to.equal undefined
      expect(dn.doubled).to.equal undefined
      expect(dn.calcHits.doubled).to.equal 1

      expect(dn.doubled).to.equal undefined
      expect(dn.doubled).to.equal undefined
      expect(dn.calcHits.doubled).to.equal 1

      expect(dn.cleanProps 'doubled').to.deep.equal ['doubled']
      dn.setNums 5
      expect(dn.calcHits.doubled).to.equal undefined
      expect(dn.doubled).to.equal 10
      expect(dn.calcHits.doubled).to.equal 1
      expect(dn.doubled).to.equal 10
      expect(dn.doubled).to.equal 10
      expect(dn.calcHits.doubled).to.equal 1

