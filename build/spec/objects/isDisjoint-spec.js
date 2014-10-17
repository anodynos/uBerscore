// Generated by uRequire v0.7.0-beta4 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('objects/isDisjoint-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../specHelpers'), nr.require('../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../specHelpers', '../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var equal = specHelpers["equal"],notEqual = specHelpers["notEqual"],ok = specHelpers["ok"],notOk = specHelpers["notOk"],tru = specHelpers["tru"],fals = specHelpers["fals"],deepEqual = specHelpers["deepEqual"],notDeepEqual = specHelpers["notDeepEqual"],exact = specHelpers["exact"],notExact = specHelpers["notExact"],iqual = specHelpers["iqual"],notIqual = specHelpers["notIqual"],ixact = specHelpers["ixact"],notIxact = specHelpers["notIxact"],like = specHelpers["like"],notLike = specHelpers["notLike"],likeBA = specHelpers["likeBA"],notLikeBA = specHelpers["notLikeBA"],equalSet = specHelpers["equalSet"],notEqualSet = specHelpers["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('objects/isDisjoint-spec.js');

describe("isDisjoint:", function () {
  describe("with primitives:", function () {
    describe("arrays:", function () {
      it("recognises disjoint:", function () {
        expect(_B.isDisjoint([
          1,
          2,
          3
        ], [
          4,
          5,
          6,
          "1"
        ])).to.be["true"];
        return expect(_.intersection([
          1,
          2,
          3
        ], [
          4,
          5,
          6,
          "1"
        ])).to.be.an("array").and.is.empty;
      });
      return it("recognises non disjoint:", function () {
        expect(_B.isDisjoint([
          1,
          2,
          3
        ], [
          4,
          2,
          5
        ])).to.be["false"];
        return expect(_.intersection([
          1,
          2,
          3
        ], [
          4,
          2,
          5
        ])).to.deep.equal([2]);
      });
    });
    return describe("arrays & objects:", function () {
      it("recognises disjoint in [] & {}:", function () {
        return expect(_B.isDisjoint([
          4,
          5,
          6
        ], {
          a: 1,
          b: 7,
          c: 8
        })).to.be["true"];
      });
      return it("recognises non disjoint in [] & {}:", function () {
        return expect(_B.isDisjoint([
          1,
          2,
          3
        ], {
          a: 1,
          b: 7,
          c: 8
        })).to.be["false"];
      });
    });
  });
  return describe("with references:", function () {
    var o1, o2, o3, o4;
    o1 = { p1: 1 };
    o2 = { p2: 2 };
    o3 = { p3: 3 };
    o4 = { p4: 4 };
    describe("arrays:", function () {
      it("recognises disjoint:", function () {
        expect(_B.isDisjoint([
          o1,
          o2
        ], [
          { p1: 1 },
          o3,
          o4
        ])).to.be["true"];
        return expect(_.intersection([
          o1,
          o2
        ], [
          { p1: 1 },
          o3,
          o4
        ])).to.deep.equal([]);
      });
      return it("recognises non disjoint:", function () {
        expect(_B.isDisjoint([
          o1,
          o2
        ], [
          { p1: 1 },
          o3,
          o4,
          o2
        ])).to.be["false"];
        return expect(_.intersection([
          o1,
          o2
        ], [
          { p1: 1 },
          o3,
          o4,
          o2
        ])).to.deep.equal([o2]);
      });
    });
    describe("arrays & objects:", function () {
      it("recognises disjoint in [] & {}", function () {
        return expect(_B.isDisjoint([
          o1,
          o2
        ], {
          p1: 1,
          o3: o3,
          o4: o4
        })).to.be["true"];
      });
      return it("recognises non disjoint in [] & {}:", function () {
        return expect(_B.isDisjoint([
          o1,
          o2
        ], {
          p1: 1,
          o3: o3,
          o4: o4,
          o2: o2
        })).to.be["false"];
      });
    });
    return describe("equality using _.isEqual :", function () {
      it("recognises disjoint in [] & {}, without _.isEqual", function () {
        return expect(_B.isDisjoint([
          o1,
          o2
        ], {
          someP: { p1: 1 },
          o3: o3
        })).to.be["true"];
      });
      return it("recognises non disjoint in [] & {}, when using _.isEqual", function () {
        return expect(_B.isDisjoint([
          o1,
          o2
        ], {
          someP: { p1: 1 },
          o3: o3
        }, _.isEqual)).to.be["false"];
      });
    });
  });
});

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))