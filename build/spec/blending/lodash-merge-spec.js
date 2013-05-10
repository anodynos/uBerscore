// Generated by uRequire v0.3.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/lodash-merge-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', '../spec-data', './shared/lodashMerge-specs', './shared/lodashMerge_Blender-specs'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var assert, expect;

assert = chai.assert;

expect = chai.expect;

describe("lodash's `merge` :", function() {
    require("./shared/lodashMerge-specs")(_.merge);
    return require("./shared/lodashMerge_Blender-specs")(_.merge);
});

describe("lodash.merge-like blender", function() {
    var lodashMerge_like_blender;
    lodashMerge_like_blender = new _B.Blender({
        order: [ "src" ],
        Undefined: function() {
            return _B.Blender.SKIP;
        }
    });
    require("./shared/lodashMerge-specs")(lodashMerge_like_blender.blend);
    return require("./shared/lodashMerge_Blender-specs")(lodashMerge_like_blender.blend);
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();