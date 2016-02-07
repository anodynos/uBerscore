// Generated by uRequire v0.7.0-beta.25 target: 'spec' template: 'UMDplain'
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('../../spec-data'), require('../../specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', '../../spec-data', '../../specHelpers'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('blending/shared/deepExtendExamples-specs.js');

var arrInt, arrInt2, arrStr, bundle, global, obj, project, ref;
ref = _.clone(data, true), project = ref.project, global = ref.global, bundle = ref.bundle, obj = ref.obj, arrInt = ref.arrInt, arrInt2 = ref.arrInt2, arrStr = ref.arrStr;
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

});
}).call(this);