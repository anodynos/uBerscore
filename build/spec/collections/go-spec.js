// Generated by uRequire v0.7.0-beta8 - template: 'UMDplain' 
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('../spec-data'), require('../specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', '../spec-data', '../specHelpers'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('collections/go-spec.js');

var arrInt, arrInt2, arrStr, bundle, global, obj, project, _ref, __indexOf = [].indexOf || function (item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (i in this && this[i] === item)
        return i;
    }
    return -1;
  };
_ref = _.clone(data, true), project = _ref.project, global = _ref.global, bundle = _ref.bundle, obj = _ref.obj, arrInt = _ref.arrInt, arrInt2 = _ref.arrInt2, arrStr = _ref.arrStr;
if (_B.isLodash()) {
  describe("go: version 0.0.3 - lodash only", function () {
    describe("go: Object passed, no params, ", function () {
      var result;
      result = _B.go(obj);
      it("should be a same looking object", function () {
        return expect(result).to.deep.equal(obj);
      });
      return it("but should NOT be the *identical* object, but a clone of it", function () {
        expect(result).to.not.equal(obj);
        return expect(result !== obj).to.be["true"];
      });
    });
    describe("go: Array<int> passed, no params, ", function () {
      var result;
      result = _B.go(arrInt);
      it("equal's contents array returned", function () {
        return expect(result).to.deep.equal(arrInt);
      });
      return it("but should NOT be the *identical* array, but a clone of it", function () {
        return expect(result).to.not.equal(arrInt);
      });
    });
    describe("go: Array<String> passed, no params, ", function () {
      var result;
      result = _B.go(_B.go(arrStr));
      it("equal's contents array returned", function () {
        return expect(result).to.deep.equal(arrStr);
      });
      return it("but should NOT be the *identical* array, but a clone of it", function () {
        return expect(result).to.not.equal(arrStr);
      });
    });
    describe("go: Filter : Object ", function () {
      it("keys named b", function () {
        return expect(_B.go(obj, {
          fltr: function (val, key) {
            return key !== "b";
          }
        })).to.deep.equal({
          ciba: 4,
          aaa: 7,
          c: -1
        });
      });
      return it("values < 5", function () {
        return expect(_B.go(obj, {
          fltr: function (val, key) {
            return val < 5;
          }
        })).to.deep.equal({
          ciba: 4,
          b: 2,
          c: -1
        });
      });
    });
    describe("Object: filter values < 5 and sortBy key, ", function () {
      var result;
      result = _B.go(obj, {
        fltr: function (val, key) {
          return val < 5;
        },
        sort: function (val, key) {
          return key;
        }
      });
      it("deeply equals {b: 2, ciba: 4, c: -1}", function () {
        return expect(result).to.deep.equal({
          b: 2,
          ciba: 4,
          c: -1
        });
      });
      it("keys 'appear' sorted - WARNING: might not work with some runtimes!", function () {
        return expect(_.map(result, function (v, k) {
          return k;
        })).to.deep.equal([
          "b",
          "c",
          "ciba"
        ]);
      });
      return it("iter respects sorted order", function () {
        return expect(_.map(_B.go(result), function (v, k) {
          return k;
        })).to.deep.equal([
          "b",
          "c",
          "ciba"
        ]);
      });
    });
    describe("Object: filter large key-names & sortBy value descenting", function () {
      var result;
      result = _B.go(obj, {
        fltr: function (val, key) {
          return key.length < 4;
        },
        sort: function (val) {
          return -val;
        }
      });
      it("deeply equals {aaa: 7, b: 2, c: -1}", function () {
        return expect(result).to.deep.equal({
          aaa: 7,
          b: 2,
          c: -1
        });
      });
      it("keys 'appear' sorted - WARNING: might not work with some runtimes!", function () {
        return expect(_.map(result, function (v, k) {
          return k;
        })).to.deep.equal([
          "aaa",
          "b",
          "c"
        ]);
      });
      return it("iter respects sorted order", function () {
        return expect(_.map(_B.go(result), function (v, k) {
          return k;
        })).to.deep.equal([
          "aaa",
          "b",
          "c"
        ]);
      });
    });
    describe("Object: filter values < 5 and sortBy value", function () {
      var result;
      result = _B.go(arrInt, {
        fltr: function (val) {
          return val < 5;
        },
        sort: function (val) {
          return val;
        }
      });
      return it("deeply equals [-1, 2, 4] ", function () {
        return expect(result).to.deep.equal([
          -1,
          2,
          4
        ]);
      });
    });
    describe("Object: filter historical names and sortBy value", function () {
      var result;
      result = _B.go(arrStr, {
        fltr: function (val) {
          return val !== "Babylon" && val !== "Sparta";
        },
        sort: function (val) {
          return val;
        }
      });
      return it("deeply equals ['Agelos', 'Anodynos', 'Pikoulas' ] ", function () {
        return expect(result).to.deep.equal([
          "Agelos",
          "Anodynos",
          "Pikoulas"
        ]);
      });
    });
    describe("Collecting types & objects", function () {
      describe("Object: collects to Array & Object!", function () {
        it("collect values as Array ", function () {
          return expect(_B.go(obj, {
            sort: function (v, k) {
              return k;
            },
            grab: "[]"
          })).to.deep.equal([
            7,
            2,
            -1,
            4
          ]);
        });
        it("declaratively collect on another object, but also returns Obj!", function () {
          var newObj, result;
          newObj = { oldKey: "oldValue" };
          result = _B.go(obj, {
            sort: function (v, k) {
              return k;
            },
            grab: newObj
          });
          expect(newObj).to.deep.equal({
            oldKey: "oldValue",
            aaa: 7,
            b: 2,
            c: -1,
            ciba: 4
          });
          return expect(result).to.deep.equal({
            aaa: 7,
            b: 2,
            c: -1,
            ciba: 4
          });
        });
        return it("using grab:-> collects keys as Array (in reverse -unsihft!), but returns sorted proper sorted Obj!", function () {
          var newArr, result;
          newArr = [];
          result = _B.go(obj, {
            sort: function (v, k) {
              return k;
            },
            grab: function (v, k) {
              return newArr.unshift(k);
            }
          });
          expect(newArr).to.deep.equal([
            "ciba",
            "c",
            "b",
            "aaa"
          ]);
          return expect(result).to.deep.equal({
            aaa: 7,
            b: 2,
            c: -1,
            ciba: 4
          });
        });
      });
      return describe("Array: collects to Object (& Array)!", function () {
        it("returns an Object when grab instructs it", function () {
          return expect(_B.go(arrInt, {
            sort: function (v, k) {
              return v;
            },
            fltr: function (v) {
              return v < 7;
            },
            grab: "{}"
          })).to.deep.equal({
            "0": -1,
            "1": 2,
            "2": 4
          });
        });
        it("'grab' declaratively collects array values as object values, with idx as key", function () {
          var newObj, result;
          newObj = { oldKey: "oldValue" };
          result = _B.go(arrInt, {
            sort: function (v) {
              return v;
            },
            grab: newObj
          });
          expect(newObj).to.deep.equal({
            "0": -1,
            "1": 2,
            "2": 4,
            "3": 7,
            oldKey: "oldValue"
          });
          return expect(result).to.deep.equal({
            "0": -1,
            "1": 2,
            "2": 4,
            "3": 7
          });
        });
        return it("using a function, it collects keys/values newObj, but returns sorted Array!", function () {
          var newObj, result;
          newObj = { oldKey: "oldValue" };
          result = _B.go(arrInt, {
            sort: function (v, k) {
              return v;
            },
            grab: function (v, k) {
              return newObj[k] = v;
            }
          });
          expect(newObj).to.deep.equal({
            "0": -1,
            "1": 2,
            "2": 4,
            "3": 7,
            oldKey: "oldValue"
          });
          return expect(result).to.deep.equal([
            -1,
            2,
            4,
            7
          ]);
        });
      });
    });
    describe("Object: mimicking various _ functions!", function () {
      it("resembles _.pick with single string name", function () {
        return expect(_B.go(obj, { fltr: "ciba" })).to.deep.equal(_.pick(obj, "ciba"));
      });
      it("resembles _.pick with array of String (or string evaluated objects)", function () {
        var aaa;
        aaa = {};
        aaa.toString = function () {
          return "aaa";
        };
        return expect(_B.go(obj, {
          fltr: [
            "ciba",
            aaa
          ]
        })).to.deep.equal(_.pick(obj, "ciba", aaa));
      });
      it("resembles _.omit ", function () {
        return expect(_B.go(obj, {
          fltr: function (v, k) {
            return k !== "ciba" && k !== "aaa";
          }
        })).to.deep.equal(_.omit(obj, "ciba", "aaa"));
      });
      it("resembles _.difference", function () {
        return expect(_B.go(arrInt, {
          fltr: function (v) {
            return __indexOf.call(arrInt2, v) < 0;
          }
        })).to.deep.equal(_.difference(arrInt, arrInt2));
      });
      it("resembles _.map", function () {
        var ar;
        ar = [];
        _B.go(obj, {
          grab: function (v) {
            return ar.push(v);
          }
        });
        return expect(ar).to.deep.equal(_.map(obj, function (v) {
          return v;
        }));
      });
      it("resembles _.map, with a difference: not restricted to collect in array!", function () {
        var ob;
        ob = {};
        _B.go(obj, {
          grab: function (v, k) {
            return ob[v] = k;
          }
        });
        return expect(ob).to.deep.equal({
          "4": "ciba",
          "7": "aaa",
          "2": "b",
          "-1": "c"
        });
      });
      it("resembles _.keys (with order guaranteed!)", function () {
        var keys, result;
        keys = [];
        result = _B.go(obj, {
          sort: function (v, k) {
            return k;
          },
          grab: function (v, k) {
            return keys.push(k);
          }
        });
        expect(keys).to.deep.equal(_.keys(obj).sort());
        return expect(result).to.deep.equal({
          aaa: 7,
          b: 2,
          c: -1,
          ciba: 4
        });
      });
      return it("resembles _.pluck", function () {
        var agedNames, names, stooges;
        stooges = [
          {
            "name": "moe",
            "age": 40
          },
          {
            "name": "larry",
            "age": 50
          },
          {
            "name": "curly",
            "age": 60
          }
        ];
        names = [];
        _B.go(stooges, {
          grab: function (v) {
            return names.push(v.name);
          }
        });
        expect(names).to.deep.equal(_.pluck(stooges, "name"));
        agedNames = [];
        _B.go(stooges, {
          grab: function (v) {
            return agedNames.push(v.name + " (" + v.age + ")");
          }
        });
        return expect(agedNames).to.deep.equal([
          "moe (40)",
          "larry (50)",
          "curly (60)"
        ]);
      });
    });
    return describe("Original objects not mutated", function () {
      expect(bundle).to.deep.equal(data.bundle);
      expect(project).to.deep.equal(data.project);
      expect(global).to.deep.equal(data.global);
      expect(obj).to.deep.equal(data.obj);
      expect(arrStr).to.deep.equal(data.arrStr);
      expect(arrInt).to.deep.equal(data.arrInt);
      return expect(arrInt2).to.deep.equal(data.arrInt2);
    });
  });
}

return module.exports;

})
}).call(this)