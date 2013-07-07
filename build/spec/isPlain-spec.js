// Generated by uRequire v0.4.2
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('isPlain-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('./spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', './spec-data'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var arrInt, arrInt2, arrStr, assert, bundle, expect, global, obj, project, _ref;

assert = chai.assert;

expect = chai.expect;

_ref = _.clone(data, true), project = _ref.project, global = _ref.global, bundle = _ref.bundle, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;

describe("isPlain :", function() {
    it("Strings", function() {
        return expect(_B.isPlain("I am a String")).to.be["true"];
    });
    it("Numbers", function() {
        return expect(_B.isPlain(123)).to.be["true"];
    });
    it("Boolean", function() {
        return expect(_B.isPlain(false)).to.be["true"];
    });
    it("not Objects", function() {
        return expect(_B.isPlain({
            a: "a"
        })).to.be["false"];
    });
    return it("not Arrays", function() {
        return expect(_B.isPlain([ 1, 2, 3 ])).to.be["false"];
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();