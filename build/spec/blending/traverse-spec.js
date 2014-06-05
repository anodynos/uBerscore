// Generated by uRequire v0.6.18 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('blending/traverse-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../specHelpers'), nr.require('../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../specHelpers', '../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var expect = chai.expect; // injected @ `spec: bundle: commonCode`.

var deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = specHelpers.equal, notEqual = specHelpers.notEqual, ok = specHelpers.ok, notOk = specHelpers.notOk, tru = specHelpers.tru, fals = specHelpers.fals, deepEqual = specHelpers.deepEqual, notDeepEqual = specHelpers.notDeepEqual, exact = specHelpers.exact, notExact = specHelpers.notExact, iqual = specHelpers.iqual, notIqual = specHelpers.notIqual, ixact = specHelpers.ixact, notIxact = specHelpers.notIxact, like = specHelpers.like, notLike = specHelpers.notLike, likeBA = specHelpers.likeBA, notLikeBA = specHelpers.notLikeBA, equalSet = specHelpers.equalSet, notEqualSet = specHelpers.notEqualSet;

var l = new _B.Logger('blending/traverse-spec.js');

describe("traverse:", function () {
  var o;
  o = {
    a: {
      a1: { a1_1: { a1_1_1: 111 } },
      a2: {
        bingo: true,
        a2_1: { a2_1_1: 211 }
      }
    },
    b: 2
  };
  it("traverses nested objects", function () {
    var props;
    props = [];
    _B.traverse(o, function (prop, src, blender) {
      return props.push(prop);
    });
    return expect(props).to.be.deep.equal([
      "a",
      "a1",
      "a1_1",
      "a2",
      "a2_1"
    ]);
  });
  return it("quits branch if callback returns false", function () {
    var props;
    props = [];
    _B.traverse(o, function (prop, src, blender) {
      props.push(prop);
      if (src[prop].bingo === true) {
        return false;
      }
    });
    return expect(props).to.be.deep.equal([
      "a",
      "a1",
      "a1_1",
      "a2"
    ]);
  });
});

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))