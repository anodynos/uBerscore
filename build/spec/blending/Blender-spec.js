// Generated by uRequire v0.3.0alpha22
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/Blender-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../spec-data', './shared/deepExtendExamples-specs', './shared/lodashMerge-specs', './shared/lodashMerge_Blender-specs'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var assert, expect, l;

assert = chai.assert;

expect = chai.expect;

l = new _B.Logger("Blender-spec", 0);

describe("Blender:", function() {
    describe("Blender.shortifyTypeNames : ", function() {
        return it("corectly transforms nested types of srcDstSpecs to short format", function() {
            var expectedShortified, longTypeNames;
            longTypeNames = {
                order: [ "src", "dst" ],
                Array: {
                    String: "someAction"
                },
                Object: {
                    Array: "doSomeAction",
                    Null: function() {}
                },
                doSomeAction: function() {}
            };
            expectedShortified = {
                order: [ "src", "dst" ],
                doSomeAction: longTypeNames.doSomeAction,
                "[]": {
                    "''": "someAction"
                },
                "{}": {
                    "[]": "doSomeAction",
                    "null": longTypeNames.Object.Null
                }
            };
            return expect(_B.Blender.shortifyTypeNames(longTypeNames)).to.deep.equal(expectedShortified);
        });
    });
    describe("DeepExtendBlender", function() {
        var deepExtendblender;
        deepExtendblender = new _B.DeepExtendBlender;
        return require("./shared/deepExtendExamples-specs")(deepExtendblender.blend);
    });
    return describe("lodash.merge -like blender", function() {
        var lodashMerge_like_blender;
        lodashMerge_like_blender = new _B.Blender({
            order: [ "src" ],
            "|": {
                Undefined: function() {
                    return _B.Blender.SKIP;
                }
            }
        });
        require("./shared/lodashMerge-specs")(lodashMerge_like_blender.blend);
        return require("./shared/lodashMerge_Blender-specs")(lodashMerge_like_blender.blend);
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();