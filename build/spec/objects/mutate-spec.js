// Generated by uRequire v0.7.0-beta8 - template: 'UMDplain' 
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('../spec-data'), require('../specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', '../spec-data', '../specHelpers'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


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
}).call(this)