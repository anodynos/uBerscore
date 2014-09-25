// Generated by uRequire v0.6.20 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('blending/shared/lodashMerge-specs', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../../specHelpers'), nr.require('../../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../../specHelpers', '../../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var expect = chai.expect; // injected @ `spec: bundle: commonCode`.

var deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = specHelpers.equal, notEqual = specHelpers.notEqual, ok = specHelpers.ok, notOk = specHelpers.notOk, tru = specHelpers.tru, fals = specHelpers.fals, deepEqual = specHelpers.deepEqual, notDeepEqual = specHelpers.notDeepEqual, exact = specHelpers.exact, notExact = specHelpers.notExact, iqual = specHelpers.iqual, notIqual = specHelpers.notIqual, ixact = specHelpers.ixact, notIxact = specHelpers.notIxact, like = specHelpers.like, notLike = specHelpers.notLike, likeBA = specHelpers.likeBA, notLikeBA = specHelpers.notLikeBA, equalSet = specHelpers.equalSet, notEqualSet = specHelpers.notEqualSet;

var l = new _B.Logger('blending/shared/lodashMerge-specs.js');

var arrInt, arrInt2, arrStr, bundle, global, obj, project, _ref;
_ref = _.clone(data, true), project = _ref.project, global = _ref.global, bundle = _ref.bundle, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;
module.exports = function (deepExtendMergeBlend) {
  return describe("lodash.merge specs", function () {
    it("should merge `source` into the destination object", function () {
      var ages, expected, heights, names;
      names = {
        stooges: [
          { name: "moe" },
          { name: "larry" }
        ]
      };
      ages = {
        stooges: [
          { age: 40 },
          { age: 50 }
        ]
      };
      heights = {
        stooges: [
          { height: "5'4\"" },
          { height: "5'5\"" }
        ]
      };
      expected = {
        stooges: [
          {
            name: "moe",
            age: 40,
            height: "5'4\""
          },
          {
            name: "larry",
            age: 50,
            height: "5'5\""
          }
        ]
      };
      return expect(deepExtendMergeBlend(names, ages, heights)).to.deep.equal(expected);
    });
    it("should merge sources containing circular references", function () {
      var actual, object, source;
      object = {
        foo: { a: 1 },
        bar: { a: 2 }
      };
      source = {
        foo: { b: { foo: { c: {} } } },
        bar: {}
      };
      source.foo.b.foo.c = source;
      source.bar.b = source.foo.b;
      actual = deepExtendMergeBlend(object, source);
      return expect(actual.bar.b === actual.foo.b && actual.foo.b.foo.c === actual.foo.b.foo.c.foo.b.foo.c).to.be["true"];
    });
    return it("should merge problem JScript properties (test in IE < 9)", function () {
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

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))