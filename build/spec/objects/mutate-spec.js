// Generated by uRequire v0.6.20 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('objects/mutate-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../specHelpers'), nr.require('../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../specHelpers', '../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var expect = chai.expect; // injected @ `spec: bundle: commonCode`.

var deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = specHelpers.equal, notEqual = specHelpers.notEqual, ok = specHelpers.ok, notOk = specHelpers.notOk, tru = specHelpers.tru, fals = specHelpers.fals, deepEqual = specHelpers.deepEqual, notDeepEqual = specHelpers.notDeepEqual, exact = specHelpers.exact, notExact = specHelpers.notExact, iqual = specHelpers.iqual, notIqual = specHelpers.notIqual, ixact = specHelpers.ixact, notIxact = specHelpers.notIxact, like = specHelpers.like, notLike = specHelpers.notLike, likeBA = specHelpers.likeBA, notLikeBA = specHelpers.notLikeBA, equalSet = specHelpers.equalSet, notEqualSet = specHelpers.notEqualSet;

var l = new _B.Logger('objects/mutate-spec.js');

describe("mutate :", function () {
  var simpleCalc;
  simpleCalc = function (v) {
    if (v < 0) {
      return v + 10;
    } else {
      return v + 20;
    }
  };
  it("mutate Object values", function () {
    var o;
    o = {
      a: 1,
      b: 2,
      c: -1
    };
    return expect(_B.mutate(o, simpleCalc)).to.deep.equal({
      a: 21,
      b: 22,
      c: 9
    });
  });
  it("arrayize if string", function () {
    var o;
    o = {
      key1: "lalakis",
      key2: [
        "ok",
        "yes"
      ]
    };
    return expect(_B.mutate(o, _B.arrayize, _.isString)).to.deep.equal({
      key1: ["lalakis"],
      key2: [
        "ok",
        "yes"
      ]
    });
  });
  return describe("mutate arrays :", function () {
    var a;
    a = [
      1,
      2,
      -1
    ];
    it("mutate array with simplecalc ", function () {
      return expect(_B.mutate(a, simpleCalc)).to.deep.equal([
        21,
        22,
        9
      ]);
    });
    return it("mutate array again with fltr", function () {
      return expect(_B.mutate(a, simpleCalc, function (v) {
        return v > 10;
      })).to.deep.equal([
        41,
        42,
        9
      ]);
    });
  });
});

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))