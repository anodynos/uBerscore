// Generated by uRequire v0.3.0alpha18
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('deepCloneDefaults-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('./spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', './spec-data'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var arrInt, arrInt2, arrStr, assert, bundleDefaults, expect, globalDefaults, obj, projectDefaults, _ref;

assert = chai.assert;

expect = chai.expect;

_ref = _.clone(data, true), projectDefaults = _ref.projectDefaults, globalDefaults = _ref.globalDefaults, bundleDefaults = _ref.bundleDefaults, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;

describe("deepCloneDefaults:", function() {
    it("more 'specific' options eg. project, merged (taking precedence) to more 'global' defaults", function() {
        var result;
        result = _B.deepCloneDefaults(projectDefaults, globalDefaults);
        return expect(result).to.deep.equal({
            enabled: true,
            bundleRoot: "/global/project",
            compilers: {
                "rjs-build": "project-rjs-build"
            }
        });
    });
    it("many defaults", function() {
        var result;
        result = _B.deepCloneDefaults(bundleDefaults, projectDefaults, globalDefaults);
        return expect(result).to.deep.equal({
            enabled: true,
            bundleRoot: "/global/project/bundle",
            compilers: {
                "coffee-script": {
                    params: "w b"
                },
                urequire: {
                    scanPrevent: true
                },
                "rjs-build": "project-rjs-build"
            }
        });
    });
    return it("Original objects not mutated", function() {
        expect(bundleDefaults).to.deep.equal(data.bundleDefaults);
        expect(projectDefaults).to.deep.equal(data.projectDefaults);
        return expect(globalDefaults).to.deep.equal(data.globalDefaults);
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();