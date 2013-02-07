// Generated by uRequire v0.3.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/deepExtend-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../spec-data', './shared/deepExtendExamples-specs', './shared/lodashMerge-specs'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var assert, expect;

assert = chai.assert;

expect = chai.expect;

describe("deepExtend :", function() {
    require("./shared/deepExtendExamples-specs")(_B.deepExtend);
    return require("./shared/lodashMerge-specs")(_B.deepExtend);
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();