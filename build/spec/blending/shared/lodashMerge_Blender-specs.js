// Generated by uRequire v0.6.18 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('blending/shared/lodashMerge_Blender-specs', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../../specHelpers'), nr.require('../../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../../specHelpers', '../../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var expect = chai.expect; // injected @ `spec: bundle: commonCode`.

var deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = specHelpers.equal, notEqual = specHelpers.notEqual, ok = specHelpers.ok, notOk = specHelpers.notOk, tru = specHelpers.tru, fals = specHelpers.fals, deepEqual = specHelpers.deepEqual, notDeepEqual = specHelpers.notDeepEqual, exact = specHelpers.exact, notExact = specHelpers.notExact, iqual = specHelpers.iqual, notIqual = specHelpers.notIqual, ixact = specHelpers.ixact, notIxact = specHelpers.notIxact, like = specHelpers.like, notLike = specHelpers.notLike, likeBA = specHelpers.likeBA, notLikeBA = specHelpers.notLikeBA, equalSet = specHelpers.equalSet, notEqualSet = specHelpers.notEqualSet;

var l = new _B.Logger('blending/shared/lodashMerge_Blender-specs.js');

var arrInt, arrInt2, arrStr, bundle, global, obj, personDetails, personDetails2, persons, project, _ref;
_ref = _.clone(data, true), project = _ref.project, global = _ref.global, bundle = _ref.bundle, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;
persons = [
  {
    name: "agelos",
    male: true
  },
  { name: "AnoDyNoS" }
];
personDetails = [
  {
    age: 37,
    address: "1 Peak Str, Earth",
    familyState: null
  },
  {
    age: 33,
    familyState: { married: false }
  }
];
personDetails2 = [
  {
    surname: "Peakoulas",
    name: "Agelos",
    age: void 0,
    address: {
      street: "1 Peak Str",
      country: "Earth"
    },
    familyState: {
      married: true,
      children: 3
    }
  },
  { job: "Dreamer, developer, doer" }
];
module.exports = function (deepExtendMergeBlend) {
  return describe("lodashMerge_Blender-specs (shared): ", function () {
    var blended;
    blended = deepExtendMergeBlend(persons, personDetails, personDetails2);
    it("'Persons' are deeply extended, overwriting from right to left.", function () {
      return expect(blended).to.deep.equal([
        {
          surname: "Peakoulas",
          name: "Agelos",
          age: 37,
          male: true,
          address: {
            street: "1 Peak Str",
            country: "Earth"
          },
          familyState: {
            married: true,
            children: 3
          }
        },
        {
          name: "AnoDyNoS",
          age: 33,
          job: "Dreamer, developer, doer",
          familyState: { married: false }
        }
      ]);
    });
    it("'Persons' === the destination/target/extended object: ", function () {
      return expect(blended).to.equal(persons);
    });
    it("merges/blends 'Object <-- Array", function () {
      var result;
      result = deepExtendMergeBlend({ property: "I am an Object" }, [
        "I am",
        "an",
        "Array"
      ]);
      return expect(result).to.deep.equal({
        property: "I am an Object",
        0: "I am",
        1: "an",
        2: "Array"
      });
    });
    it("Array <-- Object", function () {
      var expected, result;
      result = deepExtendMergeBlend([
        "I am",
        "an",
        "Array"
      ], { property: "I am an Object" });
      expected = [
        "I am",
        "an",
        "Array"
      ];
      expected.property = "I am an Object";
      return expect(result).to.deep.equal(expected);
    });
    it("'Undefined' as source is ignored", function () {
      var result;
      result = deepExtendMergeBlend([
        "I am",
        "an",
        {
          objProp: "Object property",
          anotherProp: "Another Object Property"
        }
      ], [
        void 0,
        "another",
        {
          objProp: "Object Property2",
          anotherProp: void 0
        }
      ], [
        "You are",
        void 0,
        { objProp: void 0 }
      ]);
      return expect(result).to.deep.equal([
        "You are",
        "another",
        {
          objProp: "Object Property2",
          anotherProp: "Another Object Property"
        }
      ]);
    });
    it("'Null' as source IS NOT ignored, it overwrites", function () {
      var result;
      result = deepExtendMergeBlend([
        "I am",
        "an",
        {
          objProp: "Object property",
          anotherProp: "Another Object Property"
        }
      ], [
        null,
        void 0,
        {
          objProp: "Object property",
          anotherProp: null
        }
      ]);
      return expect(result).to.deep.equal([
        null,
        "an",
        {
          objProp: "Object property",
          anotherProp: null
        }
      ]);
    });
    return it("Null / Undefined as overwritten destination", function () {
      var result;
      result = deepExtendMergeBlend([
        null,
        void 0,
        null,
        {
          objProp: "Undefined doesn't hurt me!",
          anotherProp: "null kills me!"
        }
      ], [
        111,
        null,
        void 0,
        void 0
      ], [
        null,
        "I am",
        "an",
        {
          objProp: void 0,
          anotherProp: null
        }
      ]);
      return expect(result).to.deep.equal([
        null,
        "I am",
        "an",
        {
          objProp: "Undefined doesn't hurt me!",
          anotherProp: null
        }
      ]);
    });
  });
};

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))