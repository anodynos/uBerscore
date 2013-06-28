// Generated by uRequire v0.4.0
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('uberscore-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('./spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', './spec-data'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var assert, expect, _uB;

assert = chai.assert;

expect = chai.expect;

_uB = require("uberscore");

describe("uRequire's `rootExports` & `noConflict()`\n   (running on " + (__isNode ? "nodsjs" : "Web") + " via " + (__isAMD ? "AMD" : "noAMD/script") + ")", function() {
    if (__isWeb) {
        it("registers globals '_B' & 'uberscore'", function() {
            expect(window._B).to.equal(_uB);
            return expect(window.uberscore).to.equal(_uB);
        });
        return it("noConflict() returns module & sets old values to globals '_B' & 'uberscore'", function() {
            expect(window._B.noConflict()).to.equal(_uB);
            expect(window._B).to.equal("Old global `_B`");
            expect(window.uberscore).to.equal("Old global `uberscore`");
            return window._B = _uB;
        });
    } else {
        it("NOT TESTING `rootExports`, I am on node/" + (__isAMD ? "AMD" : "plain") + "!", function() {});
        return it("NOT TESTING `noConflict()`, I am on node/" + (__isAMD ? "AMD" : "plain") + "!", function() {});
    }
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();