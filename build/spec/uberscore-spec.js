// Generated by uRequire v0.6.20 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('uberscore-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('./specHelpers'), nr.require('./spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', './specHelpers', './spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var expect = chai.expect; // injected @ `spec: bundle: commonCode`.

var deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = specHelpers.equal, notEqual = specHelpers.notEqual, ok = specHelpers.ok, notOk = specHelpers.notOk, tru = specHelpers.tru, fals = specHelpers.fals, deepEqual = specHelpers.deepEqual, notDeepEqual = specHelpers.notDeepEqual, exact = specHelpers.exact, notExact = specHelpers.notExact, iqual = specHelpers.iqual, notIqual = specHelpers.notIqual, ixact = specHelpers.ixact, notIxact = specHelpers.notIxact, like = specHelpers.like, notLike = specHelpers.notLike, likeBA = specHelpers.likeBA, notLikeBA = specHelpers.notLikeBA, equalSet = specHelpers.equalSet, notEqualSet = specHelpers.notEqualSet;

var l = new _B.Logger('uberscore-spec.js');

return describe("uRequire's `rootExports` & `noConflict():`\n  (running on " + (__isNode ? "nodejs" : "Web") + " loading via " + (__isAMD ? "AMD" : "noAMD/script") + "):", function () {
    var _uB;
    _uB = require("uberscore");
    it("registers globals (NOT RUNS ON AMD) ", function () {
      if (!__isAMD) {
        equal(window._B, _uB);
        return equal(window.uberscore, _uB);
      }
    });
    it("Doesn't register globals & noConflict on AMD (RUNS ONLY ON AMD) ", function () {
      if (__isAMD && !__isWeb) {
        equal(window._B, void 0);
        return equal(window.uberscore, void 0);
      }
    });
    return it("noConflict() returns module & sets old values (NOT RUNS ON AMD)", function () {
      if (!__isAMD) {
        equal(window._B.noConflict(), _uB);
      }
      if (__isWeb) {
        equal(window._B, "Old global `_B`");
        return equal(window.uberscore, "Old global `uberscore`");
      }
    });
  });


})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))