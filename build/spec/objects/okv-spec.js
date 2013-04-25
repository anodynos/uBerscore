// Generated by uRequire v{NO_VERSION}
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/okv-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var arrInt, arrInt2, arrStr, assert, bundle, expect, global, obj, project, _ref;

assert = chai.assert;

expect = chai.expect;

_ref = _.clone(data, true), project = _ref.project, global = _ref.global, bundle = _ref.bundle, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;

describe("okv :", function() {
    var weirdKeyName;
    weirdKeyName = " $#%!@&";
    it("builds a simple object, with weird keyName", function() {
        return expect(_B.okv({}, "foo_" + weirdKeyName, 8, "bar" + weirdKeyName, "some bar")).to.deep.equal({
            "foo_ $#%!@&": 8,
            "bar $#%!@&": "some bar"
        });
    });
    return describe("build a more invloved object", function() {
        var bar, o;
        o = {};
        _B.okv(o, "foo_" + weirdKeyName, 8, bar = "bar" + weirdKeyName, "some bar");
        o[bar] = _B.okv({}, "nestedBar" + weirdKeyName, "This is a secret bar", "anotherBar" + weirdKeyName, "Many bars, no foo");
        it("o is build, then part of it augmented", function() {
            return expect(o).to.deep.equal({
                "foo_ $#%!@&": 8,
                "bar $#%!@&": {
                    "nestedBar $#%!@&": "This is a secret bar",
                    "anotherBar $#%!@&": "Many bars, no foo"
                }
            });
        });
        return it("add nested weird keyd bars on existing key", function() {
            var i;
            _B.okv(o[bar], "newbar" + weirdKeyName, "a new bar!", "bar" + function() {
                var _i, _len, _ref1, _results;
                _ref1 = [ 1, 2, 3 ];
                _results = [];
                for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
                    i = _ref1[_i];
                    _results.push("" + i);
                }
                return _results;
            }().join("-"), "ther weirest bar!");
            return expect(o).to.deep.equal({
                "foo_ $#%!@&": 8,
                "bar $#%!@&": {
                    "nestedBar $#%!@&": "This is a secret bar",
                    "anotherBar $#%!@&": "Many bars, no foo",
                    "newbar $#%!@&": "a new bar!",
                    "bar1-2-3": "ther weirest bar!"
                }
            });
        });
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();