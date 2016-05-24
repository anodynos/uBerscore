// Generated by uRequire v0.7.0-beta.28 target: 'spec' template: 'UMDplain'
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('../spec-data'), require('../specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', '../spec-data', '../specHelpers'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('objects/isEqual-spec.js');

var Class3, c3, c3Clone, expectedPropertyValues, inheritedDeepClone, inheritedShallowClone, l, oClone, object, objectDeepClone1, objectDeepClone2, objectShallowClone1, objectShallowClone2, objectWithProtoInheritedProps;
objectWithProtoInheritedProps = data.objectWithProtoInheritedProps, Class3 = data.Class3, c3 = data.c3, expectedPropertyValues = data.expectedPropertyValues, object = data.object, objectShallowClone1 = data.objectShallowClone1, objectShallowClone2 = data.objectShallowClone2, objectDeepClone1 = data.objectDeepClone1, objectDeepClone2 = data.objectDeepClone2, inheritedShallowClone = data.inheritedShallowClone, inheritedDeepClone = data.inheritedDeepClone;
oClone = _.clone(objectWithProtoInheritedProps);
c3Clone = _.clone(c3);
l = new _B.Logger("spec/objects/isEqual");
describe("isEqual:", function () {
  describe("lodash _.isEqual tests on _B.isEqual:", function () {
    it("should work with `arguments` objects (test in IE < 9)", function () {
      var args1, args2, args3;
      args1 = function () {
        return arguments;
      }(1, 2, 3);
      args2 = function () {
        return arguments;
      }(1, 2, 3);
      args3 = function () {
        return arguments;
      }(1, 2);
      expect(_B.isEqual(args1, args2)).to.be["true"];
      if (!(window.PHANTOMJS || window.mochaPhantomJS)) {
        expect(_B.isEqual(args1, args3)).to.be["false"];
      }
      if (_B.isLodash()) {
        expect(_B.isEqual(args1, {
          "0": 1,
          "1": 2,
          "2": 3
        })).to.be["true"];
      }
      if (!(window.PHANTOMJS || window.mochaPhantomJS)) {
        return expect(_B.isEqual(args1, [
          1,
          2,
          3
        ])).to.be["false"];
      }
    });
    it("should return `false` when comparing values with circular references to unlike values", function () {
      var array1, array2, object1, object2;
      array1 = [
        "a",
        null,
        "c"
      ];
      array2 = [
        "a",
        [],
        "c"
      ];
      object1 = {
        a: 1,
        b: null,
        c: 3
      };
      object2 = {
        a: 1,
        b: {},
        c: 3
      };
      array1[1] = array1;
      expect(_B.isEqual(array1, array2)).to.be["false"];
      object1.b = object1;
      return expect(_B.isEqual(object1, object2)).to.be["false"];
    });
    if (_B.isLodash()) {
      return describe("callback (lodash only):", function () {
        it("respects returning true", function () {
          return expect(_B.isEqual(111, "111", function (a, b) {
            return a + "" === b + "";
          })).to.be["true"];
        });
        it("is undecided if callback returns undefined", function () {
          var a, b;
          a = {
            a: "a",
            b: "b",
            c: "EQUAL",
            d: 4
          };
          b = {
            a: "a",
            b: "b",
            c: { d: "Not really equal, but assumed as so" },
            d: 4
          };
          return expect(_B.isEqual(a, b, function (a, b) {
            if (a === "EQUAL") {
              return true;
            } else {
              return void 0;
            }
          })).to.be["true"];
        });
        it("options are passed to lodash's _.isEqual (called internally if no options)", function () {
          var a, b;
          a = {
            a: "a",
            b: "b",
            c: 4
          };
          b = {
            a: "a",
            b: "b",
            c: 4
          };
          return expect(_B.isEqual(a, b, function (a, b, options) {
            if (!_.isEqual(options, _B.isEqual.defaults)) {
              return false;
            }
          })).to.be["true"];
        });
        it("options with callback & ctx are passed to _B.isEqual (with options)", function () {
          var a, b, ctx, opts;
          a = {
            a: "a",
            b: "b",
            c: 4
          };
          b = {
            a: "a",
            b: "b",
            c: 4
          };
          ctx = {};
          return expect(_B.isEqual(a, b, opts = {
            path: [],
            callback: function (a, b, options) {
              if (options !== opts || this !== ctx) {
                return false;
              }
            }
          }, ctx)).to.be["true"];
        });
        it("should pass the correct arguments (ctx & options) to `callback`", function () {
          var args, cb, ctx;
          args = void 0;
          cb = function () {
          };
          ctx = {};
          expect(_B.isEqual("a", "b", function () {
            args = [].slice.call(arguments);
            return this === ctx;
          }, ctx)).to.be["true"];
          return expect(args).to.be.deep.equal([
            "a",
            "b",
            _B.isEqual.defaults
          ]);
        });
        it("should correct set the `this` binding", function () {
          return expect(_B.isEqual("a", "b", function (a, b) {
            return this[a] === this[b];
          }, {
            a: 1,
            b: 1
          })).to.be["true"];
        });
        it("should handle comparisons if `callback` returns `undefined`", function () {
          expect(_B.isEqual("a", "a", function () {
          })).to.be["true"];
          return expect(_B.isEqual("a", "b", function () {
          })).to.be["false"];
        });
        it("should treat all truthy as true ", function () {
          var i, len, ref, results, truthy;
          ref = [
            "hey",
            {},
            [],
            1,
            true
          ];
          results = [];
          for (i = 0, len = ref.length; i < len; i++) {
            truthy = ref[i];
            results.push(function (truthy) {
              return expect(_B.isEqual("a", "b", function () {
                return truthy;
              })).to.be["true"];
            }(truthy));
          }
          return results;
        });
        return it("should treat all falsey (except undefined) as false ", function () {
          var falsey, i, len, ref, results;
          ref = [
            "",
            0,
            NaN,
            null
          ];
          results = [];
          for (i = 0, len = ref.length; i < len; i++) {
            falsey = ref[i];
            results.push(function (falsey) {
              return expect(_B.isEqual("a", "a", function () {
                return falsey;
              })).to.be["false"];
            }(falsey));
          }
          return results;
        });
      });
    }
  });
  describe("rudimentary checks:", function () {
    describe("primitives:", function () {
      it("one undefined", function () {
        expect(_B.isEqual(void 0, objectWithProtoInheritedProps)).to.be["false"];
        return expect(_B.isEqual(objectWithProtoInheritedProps, void 0)).to.be["false"];
      });
      it("one null", function () {
        expect(_B.isEqual(null, objectWithProtoInheritedProps)).to.be["false"];
        return expect(_B.isEqual(objectWithProtoInheritedProps, null)).to.be["false"];
      });
      it("both undefined/null", function () {
        expect(_B.isEqual(void 0, void 0)).to.be["true"];
        expect(_B.isEqual([void 0], [void 0])).to.be["true"];
        expect(_B.isEqual(null, null)).to.be["true"];
        return expect(_B.isEqual([null], [null])).to.be["true"];
      });
      it("one undefined, other null", function () {
        expect(_B.isEqual(null, void 0)).to.be["false"];
        return expect(_B.isEqual(void 0, null)).to.be["false"];
      });
      it("Number", function () {
        expect(_B.isEqual(111, 111)).to.be["true"];
        expect(_B.isEqual(111.002, 111.002)).to.be["true"];
        expect(_B.isEqual(112, 111)).to.be["false"];
        return expect(_B.isEqual(111.002, 111.003)).to.be["false"];
      });
      describe("String", function () {
        it("as primitive \"\"", function () {
          expect(_B.isEqual("AAA 111", "AAA 111")).to.be["true"];
          return expect(_B.isEqual("AAA 112", "AAA 111")).to.be["false"];
        });
        return it("as String Object", function () {
          expect(_B.isEqual(new String("AAA 111"), "AAA 111")).to.be["true"];
          expect(_B.isEqual("AAA 111", new String("AAA 111"))).to.be["true"];
          expect(_B.isEqual(new String("AAA 111"), new String("AAA 111"))).to.be["true"];
          expect(_B.isEqual("AAA 112", new String("AAA 111"))).to.be["false"];
          expect(_B.isEqual(new String("AAA 112"), "AAA 111")).to.be["false"];
          return expect(_B.isEqual(new String("AAA 112"), new String("AAA 111"))).to.be["false"];
        });
      });
      it("Date", function () {
        expect(_B.isEqual(new Date("2012/12/12"), new Date("2012/12/12"))).to.be["true"];
        return expect(_B.isEqual(new Date("2012/12/13"), new Date("2012/12/12"))).to.be["false"];
      });
      it("RegExp", function () {
        expect(_B.isEqual(/abc/, /abc/)).to.be["true"];
        return expect(_B.isEqual(/abcd/, /abc/)).to.be["false"];
      });
      describe("Boolean", function () {
        it("as primitive", function () {
          expect(_B.isEqual(true, true)).to.be["true"];
          return expect(_B.isEqual(true, false)).to.be["false"];
        });
        return it("as Boolean Object", function () {
          expect(_B.isEqual(new Boolean(true), true)).to.be["true"];
          expect(_B.isEqual(new Boolean(true), false)).to.be["false"];
          return expect(_B.isEqual(false, new Boolean(false))).to.be["true"];
        });
      });
      return describe("Mixed primitives", function () {
        it("boolean truthys", function () {
          expect(_B.isEqual(true, 1)).to.be["false"];
          return expect(_B.isEqual(true, "a string")).to.be["false"];
        });
        return it("boolean falsys", function () {
          expect(_B.isEqual(false, 0)).to.be["false"];
          return expect(_B.isEqual(false, "")).to.be["false"];
        });
      });
    });
    describe("Simple Objects & functions:", function () {
      it("empty objects & arrays", function () {
        expect(_B.isEqual([], [])).to.be["true"];
        return expect(_B.isEqual({}, {})).to.be["true"];
      });
      it("empty different `_.isObject`s aren't equal", function () {
        expect(_B.isEqual({}, [])).to.be["false"];
        expect(_B.isEqual({}, function () {
        })).to.be["false"];
        return expect(_B.isEqual([], function () {
        })).to.be["false"];
      });
      it("present keys are important, even if undefined", function () {
        expect(_.isEqual({
          a: 1,
          b: void 0
        }, { a: 1 })).to.be["false"];
        return expect(_.isEqual({ a: 1 }, {
          a: 1,
          b: void 0
        })).to.be["false"];
      });
      return it("functions, with/without props", function () {
        var f1, f2;
        f1 = function () {
        };
        f2 = function () {
        };
        expect(_B.isEqual(f1, f2)).to.be["false"];
        expect(_B.isExact(f1, f2)).to.be["false"];
        expect(_B.isIqual(f1, f2)).to.be["false"];
        f1.p = "a";
        f2.p = "a";
        expect(_B.isEqual(f1, f2)).to.be["false"];
        expect(_B.isExact(f1, f2)).to.be["false"];
        return expect(_B.isIqual(f1, f2)).to.be["false"];
      });
    });
    return describe("Arrays & lookalikes :", function () {
      var arr1, arr2, arrLookalike;
      arr1 = [
        1,
        2,
        "3",
        [4],
        { a: 1 }
      ];
      arr2 = [
        1,
        2,
        "3",
        [4],
        { a: 1 }
      ];
      arrLookalike = {
        "0": 1,
        "1": 2,
        "2": "3",
        "3": [4],
        "4": { a: 1 }
      };
      it("simple Arrays", function () {
        return expect(_B.isEqual(arr1, arr2)).to.be["true"];
      });
      it("Arrays with missing items", function () {
        delete arr2[2];
        return expect(_B.isEqual(arr1, arr2)).to.be["false"];
      });
      return it("Array lookalikes arent equal", function () {
        return expect(_B.isEqual(arr1, arrLookalike)).to.be["false"];
      });
    });
  });
  describe("Argument's `isEqual` function:", function () {
    var A;
    A = function () {
      function A(val) {
        this.val = val;
      }
      A.prototype.isEqual = function (other) {
        return ((other != null ? other.val : void 0) || other) === "YEAH";
      };
      return A;
    }();
    return it("recognsises & uses isEqual function on either side", function () {
      var a, b;
      a = new A("whatever");
      b = new A("YEAH");
      expect(_B.isEqual(a, b)).to.be["true"];
      expect(_B.isEqual(a, "YEAH")).to.be["true"];
      expect(_B.isEqual(b, "YEAH")).to.be["true"];
      expect(_B.isEqual(b, a)).to.be["false"];
      expect(_B.isEqual(a, null)).to.be["false"];
      return expect(_B.isEqual(a, void 0)).to.be["false"];
    });
  });
  describe("options.exclude - excludes properties from test:", function () {
    describe("on Arrays:", function () {
      it("excludes index as Number or String", function () {
        var a, b;
        a = [
          1,
          2,
          3,
          99,
          5
        ];
        b = [
          1,
          2,
          3,
          44,
          5
        ];
        expect(_B.isEqual(a, b)).to.be["false"];
        expect(_B.isEqual(a, b, { exclude: [3] })).to.be["true"];
        return expect(_B.isEqual(a, b, { exclude: ["3"] })).to.be["true"];
      });
      return it("excludes index & property with options.allProps", function () {
        var a, b;
        a = [
          1,
          2,
          3,
          99,
          5
        ];
        a.prop = 1;
        a.badProp = 13;
        b = [
          1,
          2,
          3,
          44,
          5
        ];
        b.prop = 1;
        b.badProp = 13;
        expect(_B.isEqual(a, b)).to.be["false"];
        expect(_B.isEqual(a, b, {
          exclude: [3],
          allProps: true
        })).to.be["true"];
        b.badProp = 1113;
        expect(_B.isEqual(a, b, {
          exclude: [3],
          allProps: true
        })).to.be["false"];
        expect(_B.isEqual(a, b, {
          exclude: [
            3,
            "badProp"
          ],
          allProps: true
        })).to.be["true"];
        return expect(_B.isEqual(a, b, {
          exclude: [
            "badProp",
            "3"
          ],
          allProps: true
        })).to.be["true"];
      });
    });
    return it("excludes properties & number-like properties as numbers", function () {
      var a, b;
      a = {
        a: 1,
        b: 2,
        "3": 99,
        badProp: 5
      };
      b = {
        a: 1,
        b: 2,
        "3": 44,
        badProp: 15
      };
      expect(_B.isEqual(a, b)).to.be["false"];
      expect(_B.isEqual(a, b, {
        exclude: [
          3,
          "badProp"
        ]
      })).to.be["true"];
      return expect(_B.isEqual(a, b, {
        exclude: [
          "badProp",
          "3"
        ]
      })).to.be["true"];
    });
  });
  describe("options.allProps - considers all properties of Objects (i.e primitive imposters, functions, arrays etc):", function () {
    it("considers properties of primitive as Object:", function () {
      var a, b;
      a = new Number(111);
      b = new Number(111);
      a.prop = 1;
      b.prop = 2;
      expect(_B.isEqual(a, b)).to.be["true"];
      expect(_B.isEqual(a, b, { allProps: true })).to.be["false"];
      b.prop = 1;
      return expect(_B.isEqual(a, b, { allProps: true })).to.be["true"];
    });
    return it("considers properties (not just items) on Arrays", function () {
      var arr1, arr2;
      arr1 = [
        1,
        2,
        "3",
        [4],
        { a: 1 }
      ];
      arr2 = [
        1,
        2,
        "3",
        [4],
        { a: 1 }
      ];
      arr1.prop = [1];
      arr2.prop = [2];
      expect(_B.isEqual(arr1, arr2)).to.be["true"];
      expect(_B.isEqual(arr1, arr2, { allProps: true })).to.be["false"];
      arr2.prop = [1];
      return expect(_B.isEqual(arr1, arr2, { allProps: true })).to.be["true"];
    });
  });
  describe("options.onlyProps - ignores value & type of property containers (primitives as Object, functions etc):", function () {
    it("cares only about properties, on equal values", function () {
      var a, b;
      a = new Number(111);
      b = new Number(111);
      a.prop = 1;
      b.prop = 2;
      expect(_B.isEqual(a, b, { onlyProps: true })).to.be["false"];
      b.prop = 1;
      return expect(_B.isEqual(a, b, { onlyProps: true })).to.be["true"];
    });
    describe("cares only about properties, on NON-equal values:", function () {
      it("ignores Number Object value, only properties matter", function () {
        var a, b;
        a = new Number(111);
        b = new Number(112);
        a.prop = 1;
        b.prop = 2;
        expect(_B.isEqual(b, a, { onlyProps: true })).to.be["false"];
        b.prop = 1;
        return expect(_B.isEqual(b, a, { onlyProps: true })).to.be["true"];
      });
      it("ignores different Functions, only properties matter", function () {
        var a, b;
        a = function () {
          return "Hello";
        };
        b = function () {
          return "Goodbye";
        };
        a.prop = 1;
        b.prop = 2;
        expect(_B.isEqual(a, b, { onlyProps: true })).to.be["false"];
        b.prop = 1;
        return expect(_B.isEqual(a, b, { onlyProps: true })).to.be["true"];
      });
      return it("DOES NOT ignore String Object 'value', as each char is a property!", function () {
        var a, b;
        a = new String("111");
        b = new String("112");
        a.prop = 1;
        b.prop = 1;
        return expect(_B.isEqual(b, a, { onlyProps: true })).to.be["false"];
      });
    });
    describe("only properties matter, even on NON-equal types:", function () {
      it("ignores type of Objects, along with value", function () {
        var a, b;
        a = new RegExp(/./);
        b = new Boolean(false);
        a.prop = 1;
        b.prop = 2;
        expect(_B.isEqual(a, b, { onlyProps: true })).to.be["false"];
        b.prop = 1;
        return expect(_B.isEqual(a, b, { onlyProps: true })).to.be["true"];
      });
      return describe("works on different type of property containers like", function () {
        var A, args, arr, func, hash, instance;
        hash = {
          "0": 1,
          "1": 2,
          "2": 3
        };
        arr = [
          1,
          2,
          3
        ];
        args = function (a, b, c) {
          return arguments;
        }(1, 2, 3);
        func = function () {
          return "Hi";
        };
        func["0"] = 1;
        func["1"] = 2;
        func["2"] = 3;
        A = function () {
          function A() {
            this["0"] = 1;
            this["1"] = 2;
            this["2"] = 3;
          }
          return A;
        }();
        instance = new A();
        it("hash against array", function () {
          fals(_B.isEqual(hash, arr));
          return tru(_B.isEqual(hash, arr, { onlyProps: true }));
        });
        it("instance against array", function () {
          fals(_B.isEqual(instance, arr));
          return tru(_B.isEqual(instance, arr, { onlyProps: true }));
        });
        it.skip("arguments against array", function () {
          if (!(window.PHANTOMJS || window.mochaPhantomJS)) {
            fals(_B.isEqual(args, arr));
            return tru(_B.isEqual(args, arr, { onlyProps: true }));
          }
        });
        it("hash against function", function () {
          fals(_B.isEqual(hash, func));
          return tru(_B.isEqual(hash, func, { onlyProps: true }));
        });
        return it("instance against function", function () {
          fals(_B.isEqual(instance, func));
          return tru(_B.isEqual(instance, func, { onlyProps: true }));
        });
      });
    });
    return describe("works along with like:", function () {
      it("1st args as primitive", function () {
        var b;
        b = new Number(111);
        b.prop = 1;
        expect(_B.isEqual(1, b, { onlyProps: true })).to.be["false"];
        expect(_B.isEqual(1, b, {
          onlyProps: true,
          like: true
        })).to.be["true"];
        return expect(_B.isEqual(b, 1, {
          onlyProps: true,
          like: true
        })).to.be["false"];
      });
      return it("both as Object imporsters, 2nd has more props", function () {
        var a, b;
        a = new Number(111);
        b = new Boolean(false);
        a.prop = 1;
        b.prop = 1;
        b.prop2 = 2;
        expect(_B.isEqual(a, b, {
          onlyProps: true,
          like: true
        })).to.be["true"];
        expect(_B.isEqual(b, a, {
          onlyProps: true,
          like: true
        })).to.be["false"];
        a.prop2 = 2;
        return expect(_B.isEqual(b, a, {
          onlyProps: true,
          like: true
        })).to.be["true"];
      });
    });
  });
  describe("options.inherited - Objects with inherited properties:", function () {
    describe("object with inherited properties:", function () {
      it("_B.isEqual is true", function () {
        expect(_B.isEqual(objectWithProtoInheritedProps, expectedPropertyValues, void 0, void 0, { inherited: true })).to.be["true"];
        return expect(_B.isEqual(expectedPropertyValues, objectWithProtoInheritedProps, { inherited: true })).to.be["true"];
      });
      it("_.isEqual fails", function () {
        expect(_.isEqual(objectWithProtoInheritedProps, expectedPropertyValues)).to.be["false"];
        return expect(_.isEqual(expectedPropertyValues, objectWithProtoInheritedProps)).to.be["false"];
      });
      describe("with _.clone: ", function () {
        it("_B.isIqual fails (imperfect _.clone)", function () {
          expect(_B.isIqual(oClone, expectedPropertyValues)).to.be["false"];
          return expect(_B.isIqual(expectedPropertyValues, oClone)).to.be["false"];
        });
        return it("_.isEqual fails", function () {
          expect(_.isEqual(oClone, expectedPropertyValues)).to.be["false"];
          return expect(_.isEqual(expectedPropertyValues, oClone)).to.be["false"];
        });
      });
      return describe("with _B.clone proto: ", function () {
        var oCloneProto;
        oCloneProto = _B.clone(objectWithProtoInheritedProps, { copyProto: true });
        it("_B.isIqual succeeds (a perfect clone:-)", function () {
          expect(_B.isIqual(oCloneProto, expectedPropertyValues)).to.be["true"];
          return expect(_B.isIqual(expectedPropertyValues, oCloneProto)).to.be["true"];
        });
        return it("_.isEqual still fails", function () {
          expect(_.isEqual(oCloneProto, expectedPropertyValues)).to.be["false"];
          return expect(_.isEqual(expectedPropertyValues, oCloneProto)).to.be["false"];
        });
      });
    });
    return describe("coffeescript object with inherited properties:", function () {
      it("_B.isEqual is true", function () {
        expect(_B.isEqual(c3, expectedPropertyValues, {
          inherited: true,
          exclude: ["constructor"]
        })).to.be["true"];
        return expect(_B.isIqual(expectedPropertyValues, c3)).to.be["true"];
      });
      it("_.isEqual fails", function () {
        expect(_.isEqual(c3, expectedPropertyValues)).to.be["false"];
        return expect(_.isEqual(expectedPropertyValues, c3)).to.be["false"];
      });
      describe("with _.clone:", function () {
        it("_B.isIqual fails (imperfect _.clone)", function () {
          expect(_B.isEqual(c3Clone, expectedPropertyValues, void 0, void 0, { inherited: true })).to.be["false"];
          return expect(_B.isIqual(expectedPropertyValues, c3Clone)).to.be["false"];
        });
        return it("_.isEqual fails", function () {
          expect(_.isEqual(c3Clone, expectedPropertyValues)).to.be["false"];
          return expect(_.isEqual(expectedPropertyValues, c3Clone)).to.be["false"];
        });
      });
      return describe("with _B.clone: ", function () {
        var c3CloneProto;
        c3CloneProto = _B.clone(c3, { copyProto: true });
        it("_B.isIqual is true", function () {
          expect(_B.isEqual(c3CloneProto, expectedPropertyValues, {
            inherited: true,
            exclude: ["constructor"]
          })).to.be["true"];
          return expect(_B.isIqual([expectedPropertyValues], [c3CloneProto])).to.be["true"];
        });
        return it("_.isEqual fails", function () {
          expect(_.isEqual(c3CloneProto, expectedPropertyValues)).to.be["false"];
          return expect(_.isEqual(expectedPropertyValues, c3CloneProto)).to.be["false"];
        });
      });
    });
  });
  describe("options.exact (Objects need to have exact refs) :", function () {
    describe("shallow cloned objects :", function () {
      it("_B.isExact(object, objectShallowClone1) is true", function () {
        expect(_B.isEqual(object, objectShallowClone1, void 0, void 0, { exact: true })).to.be["true"];
        return expect(_B.isExact(objectShallowClone1, object)).to.be["true"];
      });
      it("_B.isExact(object, objectShallowClone2) with _.clone(object) is true", function () {
        expect(_B.isEqual(object, objectShallowClone2, { exact: true })).to.be["true"];
        return expect(_B.isExact(objectShallowClone2, object)).to.be["true"];
      });
      return it("_.isEqual(object, shallowClone1 & 2) gives true", function () {
        expect(_.isEqual(object, objectShallowClone1)).to.be["true"];
        return expect(_.isEqual(object, objectShallowClone2)).to.be["true"];
      });
    });
    describe("deeply cloned objects:", function () {
      describe("objectDeepClone1 with copied proto:", function () {
        it("_B.isExact is false", function () {
          expect(_B.isEqual(object, objectDeepClone1, { exact: true })).to.be["false"];
          return expect(_B.isExact(objectDeepClone1, object)).to.be["false"];
        });
        return it("_B.isEqual is true", function () {
          expect(_B.isEqual(object, objectDeepClone1)).to.be["true"];
          return expect(_B.isEqual(objectDeepClone1, object)).to.be["true"];
        });
      });
      describe("objectDeepClone2 = _.clone(object):", function () {
        it("_B.isExact is false", function () {
          expect(_B.isEqual(object, objectDeepClone2, void 0, void 0, { exact: true })).to.be["false"];
          return expect(_B.isExact(objectDeepClone2, object)).to.be["false"];
        });
        return it("_B.isEqual is true", function () {
          expect(_B.isEqual(object, objectDeepClone2)).to.be["true"];
          return expect(_B.isEqual(objectDeepClone2, object)).to.be["true"];
        });
      });
      return it("_.isEqual(object, objectDeepClone1 & 2) gives true", function () {
        expect(_.isEqual(object, objectDeepClone1)).to.be["true"];
        return expect(_.isEqual(object, objectDeepClone2)).to.be["true"];
      });
    });
    return describe("isIxact : isEqual with inherited & exact :", function () {
      describe("shallow inherited clone: inheritedShallowClone:", function () {
        it("isIxact is true:", function () {
          return expect(_B.isIxact(inheritedShallowClone, object)).to.be["true"];
        });
        return it("isIqual is true:", function () {
          return expect(_B.isIqual(object, inheritedShallowClone)).to.be["true"];
        });
      });
      return describe("deep inherited clone : inheritedDeepClone:", function () {
        it("isIxact is true:", function () {
          return expect(_B.isIxact(inheritedDeepClone, object)).to.be["false"];
        });
        return it("isIqual is true:", function () {
          return expect(_B.isIqual(object, inheritedDeepClone)).to.be["true"];
        });
      });
    });
  });
  describe("options.path:", function () {
    var a1, a2;
    a1 = {
      a: { a1: { a2: 1 } },
      b: {
        b1: 1,
        b2: { b3: 3 }
      }
    };
    a2 = {
      a: { a1: { a2: 1 } },
      b: {
        b1: 1,
        b2: { b3: 3333 }
      }
    };
    it("contains the keys as they are processed, 1st obj misses props", function () {
      var options;
      expect(_B.isEqual(a1, a2, options = { path: [] })).to.be["false"];
      return expect(options.path).to.be.deep.equal([
        "b",
        "b2",
        "b3"
      ]);
    });
    return it("contains the keys as they are processed, 2nd obj misses props", function () {
      var options;
      expect(_B.isEqual(a2, a1, null, null, options = { path: [] })).to.be["false"];
      return expect(options.path).to.be.deep.equal([
        "b",
        "b2",
        "b3"
      ]);
    });
  });
  describe("_B.isLike : _B.isEqual with like:true (1st arg can be a partial of 2nd arg)", function () {
    var a1, a2, b1, b2;
    a1 = {
      a: 1,
      b: { b1: 1 }
    };
    b1 = {
      a: 1,
      b: {
        b1: 1,
        b2: 2
      },
      c: 3
    };
    a2 = {
      a: 1,
      b: { bb: 2 },
      c: [
        1,
        { p2: 2 },
        4
      ]
    };
    b2 = {
      a: 1,
      b: {
        bb: 2,
        missingFrom: { a: "a" }
      },
      missingFrom: "a",
      c: [
        1,
        {
          p2: 2,
          p3: 3
        },
        4,
        { p: 5 },
        6
      ]
    };
    it("is true if 1st args's properties are _B.isLike to 2nd arg's", function () {
      expect(_B.isLike(a1, b1)).to.be["true"];
      expect(_B.isEqual(a1, b1)).to.be["false"];
      expect(_B.isLike(a2, b2)).to.be["true"];
      return expect(_B.isEqual(a2, b2)).to.be["false"];
    });
    return it("is false if 1st args's properties are not _B.isLike to 2nd arg's", function () {
      expect(_B.isLike(b1, a1)).to.be["false"];
      expect(_B.isEqual(b1, a1)).to.be["false"];
      expect(_B.isLike(b2, a2)).to.be["false"];
      return expect(_B.isEqual(b2, a2)).to.be["false"];
    });
  });
  return describe("aliases like _B.isLike : ", function () {
    var _b, a1, b1;
    a1 = {
      a: 1,
      b: { b1: 1 }
    };
    b1 = {
      a: 1,
      b: _b = {
        b1: 1,
        b2: 2
      },
      c: 3
    };
    it("pass options in place of the constructor", function () {
      var path;
      expect(_B.isLike(b1, a1, { path: path = [] })).to.be["false"];
      return expect(path).to.be.deep.equal([
        "b",
        "b2"
      ]);
    });
    it("pass options in its proper place", function () {
      var path;
      expect(_B.isLike(b1, a1, void 0, void 0, { path: path = [] })).to.be["false"];
      return expect(path).to.be.deep.equal([
        "b",
        "b2"
      ]);
    });
    it("passes callback & options in its proper place & as an option", function () {
      var callback, path;
      callback = function (val1, val2) {
        if (val1 === _b || path[0] === "c") {
          return true;
        }
      };
      expect(_B.isLike(b1, a1, callback, void 0, { path: path = [] })).to.be["true"];
      return expect(_B.isLike(b1, a1, null, void 0, {
        path: path = [],
        callback: callback
      })).to.be["true"];
    });
    return it("options in its proper place DOESN NOT has precedence over callback's place", function () {
      var path1, path2;
      expect(_B.isLike(b1, a1, { path: path1 = [] }, void 0, { path: path2 = [] })).to.be["false"];
      expect(path1).to.be.deep.equal([
        "b",
        "b2"
      ]);
      return expect(path2).to.be.empty;
    });
  });
});

return module.exports;

});
}).call(this, (typeof exports === 'object' || typeof window === 'undefined' ? global : window), (typeof exports === 'object' || typeof window === 'undefined' ? global : window));