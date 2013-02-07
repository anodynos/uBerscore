// Generated by uRequire v0.3.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/shared/lodashMerge-specs', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../../spec-data'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var arrInt, arrInt2, arrStr, assert, bundleDefaults, expect, globalDefaults, obj, projectDefaults, _ref;

assert = chai.assert;

expect = chai.expect;

_ref = _.clone(data, true), projectDefaults = _ref.projectDefaults, globalDefaults = _ref.globalDefaults, bundleDefaults = _ref.bundleDefaults, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;

module.exports = function(deepExtendMergeBlend) {
    return describe("lodash.merge tests", function() {
        it("should merge `source` into the destination object", function() {
            var ages, expected, heights, names;
            names = {
                stooges: [ {
                    name: "moe"
                }, {
                    name: "larry"
                } ]
            };
            ages = {
                stooges: [ {
                    age: 40
                }, {
                    age: 50
                } ]
            };
            heights = {
                stooges: [ {
                    height: "5'4\""
                }, {
                    height: "5'5\""
                } ]
            };
            expected = {
                stooges: [ {
                    name: "moe",
                    age: 40,
                    height: "5'4\""
                }, {
                    name: "larry",
                    age: 50,
                    height: "5'5\""
                } ]
            };
            return expect(deepExtendMergeBlend(names, ages, heights)).to.deep.equal(expected);
        });
        it("should merge sources containing circular references", function() {
            var actual, object, source;
            object = {
                foo: {
                    a: 1
                },
                bar: {
                    a: 2
                }
            };
            source = {
                foo: {
                    b: {
                        foo: {
                            c: {}
                        }
                    }
                },
                bar: {}
            };
            source.foo.b.foo.c = source;
            source.bar.b = source.foo.b;
            actual = deepExtendMergeBlend(object, source);
            return expect(actual.bar.b === actual.foo.b && actual.foo.b.foo.c === actual.foo.b.foo.c.foo.b.foo.c).to.equal(true);
        });
        return it("should merge problem JScript properties (test in IE < 9)", function() {
            var blended, object, source;
            object = {
                constructor: 1,
                hasOwnProperty: 2,
                isPrototypeOf: 3
            };
            source = {
                propertyIsEnumerable: 4,
                toLocaleString: 5,
                toString: 6,
                valueOf: 7
            };
            blended = deepExtendMergeBlend(object, source);
            return expect(blended).to.deep.equal({
                constructor: 1,
                hasOwnProperty: 2,
                isPrototypeOf: 3,
                propertyIsEnumerable: 4,
                toLocaleString: 5,
                toString: 6,
                valueOf: 7
            });
        });
    });
};
// uRequire: end body of original nodejs module


return module.exports;
})
})();