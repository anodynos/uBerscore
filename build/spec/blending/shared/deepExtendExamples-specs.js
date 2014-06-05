// Generated by uRequire v0.6.18 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('blending/shared/deepExtendExamples-specs', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../../specHelpers'), nr.require('../../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../../specHelpers', '../../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var expect = chai.expect; // injected @ `spec: bundle: commonCode`.

var deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = specHelpers.equal, notEqual = specHelpers.notEqual, ok = specHelpers.ok, notOk = specHelpers.notOk, tru = specHelpers.tru, fals = specHelpers.fals, deepEqual = specHelpers.deepEqual, notDeepEqual = specHelpers.notDeepEqual, exact = specHelpers.exact, notExact = specHelpers.notExact, iqual = specHelpers.iqual, notIqual = specHelpers.notIqual, ixact = specHelpers.ixact, notIxact = specHelpers.notIxact, like = specHelpers.like, notLike = specHelpers.notLike, likeBA = specHelpers.likeBA, notLikeBA = specHelpers.notLikeBA, equalSet = specHelpers.equalSet, notEqualSet = specHelpers.notEqualSet;

var l = new _B.Logger('blending/shared/deepExtendExamples-specs.js');

var arrInt, arrInt2, arrStr, bundle, global, obj, project, _ref;
_ref = _.clone(data, true), project = _ref.project, global = _ref.global, bundle = _ref.bundle, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;
module.exports = function (deepExtendMergeBlend) {
  describe("deepExtend source code examples : ", function () {
    it("replaceRE allows you to concatenate strings.", function () {
      return expect(deepExtendMergeBlend({ url: "www.example.com" }, { url: "http://${_}/path/to/file.html" })).to.deep.equal({ url: "http://www.example.com/path/to/file.html" });
    });
    it("replaceRE also acts as a placeholder, which can be useful when you need to change one value in an array,\nwhile leaving the others untouched.", function () {
      return expect(deepExtendMergeBlend([
        100,
        { id: 1234 },
        true,
        "foo",
        [
          250,
          500
        ]
      ], [
        "${_}",
        "${_}",
        false,
        "${_}",
        "${_}"
      ])).to.deep.equal([
        100,
        { id: 1234 },
        false,
        "foo",
        [
          250,
          500
        ]
      ]);
    });
    it("replaceRE also acts as a placeholder, #2 ", function () {
      return expect(deepExtendMergeBlend([
        100,
        { id: 1234 },
        true,
        "foo",
        [
          250,
          500
        ]
      ], [
        "${_}",
        {},
        false,
        "${_}",
        []
      ])).to.deep.equal([
        100,
        { id: 1234 },
        false,
        "foo",
        [
          250,
          500
        ]
      ]);
    });
    it("replaceRE also acts as a placeholder, #3", function () {
      return expect(deepExtendMergeBlend([
        100,
        { id: 1234 },
        true,
        "foo",
        [
          250,
          500
        ]
      ], [
        "${_}",
        {},
        false
      ])).to.deep.equal([
        100,
        { id: 1234 },
        false,
        "foo",
        [
          250,
          500
        ]
      ]);
    });
    it("Array order is important.", function () {
      return expect(deepExtendMergeBlend([
        1,
        2,
        3,
        4
      ], [
        1,
        4,
        3,
        2
      ])).to.deep.equal([
        1,
        4,
        3,
        2
      ]);
    });
    return it("Remove Array element in destination object, by setting same index to null in a source object.", function () {
      return expect(deepExtendMergeBlend({
        arr: [
          1,
          2,
          3,
          4
        ]
      }, {
        arr: [
          "${_}",
          null,
          void 0
        ]
      })).to.deep.equal({
        arr: [
          1,
          4
        ]
      });
    });
  });
  return describe("more deepExtend examples: ", function () {
    return it("Remove Object key in destination object, by setting same key to undefined in a source object, similar to null in Array!", function () {
      return expect(deepExtendMergeBlend({
        foo: "foo",
        bar: {
          name: "bar",
          price: 20
        }
      }, {
        foo: void 0,
        bar: { price: null }
      })).to.deep.equal({ bar: { name: "bar" } });
    });
  });
};

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))