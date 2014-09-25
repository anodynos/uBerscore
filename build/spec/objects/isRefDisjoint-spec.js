// Generated by uRequire v0.6.20 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('objects/isRefDisjoint-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../specHelpers'), nr.require('../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../specHelpers', '../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var expect = chai.expect; // injected @ `spec: bundle: commonCode`.

var deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = specHelpers.equal, notEqual = specHelpers.notEqual, ok = specHelpers.ok, notOk = specHelpers.notOk, tru = specHelpers.tru, fals = specHelpers.fals, deepEqual = specHelpers.deepEqual, notDeepEqual = specHelpers.notDeepEqual, exact = specHelpers.exact, notExact = specHelpers.notExact, iqual = specHelpers.iqual, notIqual = specHelpers.notIqual, ixact = specHelpers.ixact, notIxact = specHelpers.notIxact, like = specHelpers.like, notLike = specHelpers.notLike, likeBA = specHelpers.likeBA, notLikeBA = specHelpers.notLikeBA, equalSet = specHelpers.equalSet, notEqualSet = specHelpers.notEqualSet;

var l = new _B.Logger('objects/isRefDisjoint-spec.js');

var O1, a1_2, a3_4, a3_4_2, a3_4_a1_2, a3_4_nested_a1_2, a3_4_nested_o2, inheritedDeepClone, inheritedShallowClone, o1, o1_2, o2, o3, o3_4, o3_4_2, o3_4_nested_o1_2, o3_4_nested_o2, o3_4_o1_2, o4, object, objectDeepClone1, objectDeepClone2, objectShallowClone1, objectShallowClone2;
O1 = o1 = { p1: 1 };
o2 = { p2: 2 };
o3 = { p3: 3 };
o4 = { p4: 4 };
a1_2 = [
  o1,
  o2
];
o1_2 = {
  p1: o1,
  p2: o2
};
a3_4 = [
  o3,
  o4
];
o3_4 = {
  p3: o3,
  p4: o4
};
a3_4_2 = [
  o3,
  o4,
  o2
];
o3_4_2 = {
  p3: o3,
  p4: o4,
  p5: o2
};
a3_4_a1_2 = [
  o3,
  o4,
  a1_2
];
o3_4_o1_2 = {
  p3: o3,
  p4: o4,
  p5: o1_2
};
a3_4_nested_o2 = [
  o3,
  o4,
  { a: { b: o2 } }
];
o3_4_nested_o2 = {
  p3: o3,
  p4: o4,
  p5: { a: { b: o2 } }
};
a3_4_nested_a1_2 = [
  o3,
  o4,
  { a: { b: a1_2 } }
];
o3_4_nested_o1_2 = {
  p3: o3,
  p4: o4,
  p5: { a: { b: o1_2 } }
};
object = data.object, objectShallowClone1 = data.objectShallowClone1, objectShallowClone2 = data.objectShallowClone2, objectDeepClone1 = data.objectDeepClone1, objectDeepClone2 = data.objectDeepClone2, inheritedShallowClone = data.inheritedShallowClone, inheritedDeepClone = data.inheritedDeepClone;
describe("isRefDisjoint:", function () {
  it("recognises self as non disjoint:", function () {
    return expect(_B.isRefDisjoint(o1, O1)).to.be["false"];
  });
  describe("Arrays:", function () {
    describe("with deep=false (shallow):", function () {
      it("recognises disjoint:", function () {
        expect(_B.isRefDisjoint(a1_2, a3_4)).to.be["true"];
        return expect(_B.isRefDisjoint(a3_4, a1_2)).to.be["true"];
      });
      it("recognises non-disjoint", function () {
        expect(_B.isRefDisjoint(a1_2, a3_4_2)).to.be["false"];
        return expect(_B.isRefDisjoint(a3_4_2, a1_2)).to.be["false"];
      });
      return describe("recognises disjoint:", function () {
        it("with nested shared reference", function () {
          expect(_B.isRefDisjoint(a1_2, a3_4_nested_o2, { deep: false })).to.be["true"];
          return expect(_B.isRefDisjoint(a3_4_nested_o2, a1_2, { deep: false })).to.be["true"];
        });
        return it("with one side being a shared reference", function () {
          expect(_B.isRefDisjoint(a1_2, a3_4_nested_a1_2, { deep: false })).to.be["true"];
          return expect(_B.isRefDisjoint(a3_4_nested_a1_2, a1_2, { deep: false })).to.be["true"];
        });
      });
    });
    return describe("with deep=true:", function () {
      it("recognises disjoint:", function () {
        expect(_B.isRefDisjoint(a1_2, a3_4, { deep: true })).to.be["true"];
        return expect(_B.isRefDisjoint(a3_4, a1_2, { deep: true })).to.be["true"];
      });
      return describe("recognises non-disjoint:", function () {
        it("with nested shared reference", function () {
          expect(_B.isRefDisjoint(a1_2, a3_4_nested_o2, { deep: true })).to.be["false"];
          return expect(_B.isRefDisjoint(a3_4_nested_o2, a1_2, { deep: true })).to.be["false"];
        });
        return it("with one side being a shared reference", function () {
          expect(_B.isRefDisjoint(a1_2, a3_4_nested_a1_2, { deep: true })).to.be["false"];
          return expect(_B.isRefDisjoint(a3_4_nested_a1_2, a1_2, { deep: true })).to.be["false"];
        });
      });
    });
  });
  describe("Objects:", function () {
    describe("with deep=false (shallow):", function () {
      it("recognises disjoint:", function () {
        expect(_B.isRefDisjoint(o1_2, o3_4)).to.be["true"];
        return expect(_B.isRefDisjoint(o3_4, o1_2)).to.be["true"];
      });
      it("recognises non-disjoint", function () {
        expect(_B.isRefDisjoint(o1_2, o3_4_2)).to.be["false"];
        return expect(_B.isRefDisjoint(o3_4_2, o1_2)).to.be["false"];
      });
      return describe("recognises disjoint:", function () {
        it("with nested shared reference", function () {
          expect(_B.isRefDisjoint(o1_2, o3_4_nested_o2, { deep: false })).to.be["true"];
          return expect(_B.isRefDisjoint(o3_4_nested_o2, o1_2, { deep: false })).to.be["true"];
        });
        return it("with one side being a shared reference", function () {
          expect(_B.isRefDisjoint(o1_2, o3_4_nested_o1_2, { deep: false })).to.be["true"];
          return expect(_B.isRefDisjoint(o3_4_nested_o1_2, o1_2, { deep: false })).to.be["true"];
        });
      });
    });
    return describe("with deep=true:", function () {
      it("recognises disjoint:", function () {
        expect(_B.isRefDisjoint(o1_2, o3_4, { deep: true })).to.be["true"];
        return expect(_B.isRefDisjoint(o3_4, o1_2, { deep: true })).to.be["true"];
      });
      return describe("recognises non-disjoint:", function () {
        it("with nested shared reference", function () {
          expect(_B.isRefDisjoint(o1_2, o3_4_nested_o2, { deep: true })).to.be["false"];
          return expect(_B.isRefDisjoint(o3_4_nested_o2, o1_2, { deep: true })).to.be["false"];
        });
        return it("with one side being a shared reference", function () {
          expect(_B.isRefDisjoint(o1_2, o3_4_nested_o1_2, { deep: true })).to.be["false"];
          return expect(_B.isRefDisjoint(o3_4_nested_o1_2, o1_2, { deep: true })).to.be["false"];
        });
      });
    });
  });
  describe("Mixed Arrays & Objects:", function () {
    describe("with deep=false (shallow):", function () {
      it("recognises disjoint:", function () {
        expect(_B.isRefDisjoint(o1_2, a3_4)).to.be["true"];
        return expect(_B.isRefDisjoint(o3_4, a1_2)).to.be["true"];
      });
      it("recognises non-disjoint", function () {
        expect(_B.isRefDisjoint(o1_2, a3_4_2)).to.be["false"];
        return expect(_B.isRefDisjoint(o3_4_2, a1_2)).to.be["false"];
      });
      return describe("recognises disjoint:", function () {
        it("with nested shared reference", function () {
          expect(_B.isRefDisjoint(o1_2, a3_4_nested_o2, { deep: false })).to.be["true"];
          return expect(_B.isRefDisjoint(o3_4_nested_o2, a1_2, { deep: false })).to.be["true"];
        });
        return it("with one side being a shared reference", function () {
          expect(_B.isRefDisjoint([o1_2], o3_4_nested_o1_2, { deep: false })).to.be["true"];
          return expect(_B.isRefDisjoint([o3_4_nested_o1_2], o1_2, { deep: false })).to.be["true"];
        });
      });
    });
    return describe("with deep=true:", function () {
      it("recognises disjoint:", function () {
        expect(_B.isRefDisjoint(o1_2, a3_4, { deep: true })).to.be["true"];
        return expect(_B.isRefDisjoint(o3_4, a1_2, { deep: true })).to.be["true"];
      });
      return describe("recognises non-disjoint:", function () {
        it("with nested shared reference", function () {
          expect(_B.isRefDisjoint(o1_2, a3_4_nested_o2, { deep: true })).to.be["false"];
          return expect(_B.isRefDisjoint(o3_4_nested_o2, a1_2, { deep: true })).to.be["false"];
        });
        return it("with one side being a shared reference", function () {
          expect(_B.isRefDisjoint([o1_2], o3_4_nested_o1_2, { deep: true })).to.be["false"];
          return expect(_B.isRefDisjoint([o3_4_nested_o1_2], o1_2, { deep: true })).to.be["false"];
        });
      });
    });
  });
  return describe("Cloned objects :", function () {
    describe("Without inherited properties:", function () {
      it("recognises non-disjoint (shallow clones):", function () {
        expect(_B.isRefDisjoint(objectShallowClone1, object, {
          deep: true,
          inherited: true
        })).to.be["false"];
        expect(_B.isRefDisjoint(object, objectShallowClone1, {
          deep: true,
          inherited: true
        })).to.be["false"];
        expect(_B.isRefDisjoint(objectShallowClone2, object, {
          deep: true,
          inherited: true
        })).to.be["false"];
        return expect(_B.isRefDisjoint(object, objectShallowClone2, {
          deep: true,
          inherited: true
        })).to.be["false"];
      });
      return it("recognises disjoint (deep clones):", function () {
        expect(_B.isRefDisjoint(objectDeepClone1, object, {
          deep: true,
          inherited: true
        })).to.be["true"];
        expect(_B.isRefDisjoint(object, objectDeepClone1, {
          deep: true,
          inherited: true
        })).to.be["true"];
        expect(_B.isRefDisjoint(objectDeepClone1, object, {
          deep: true,
          inherited: true
        })).to.be["true"];
        return expect(_B.isRefDisjoint(object, objectDeepClone1, {
          deep: true,
          inherited: true
        })).to.be["true"];
      });
    });
    return describe("With inherited properties:", function () {
      it("recognises non-disjoint (shallow clones):", function () {
        expect(_B.isRefDisjoint(inheritedShallowClone, object, {
          deep: true,
          inherited: true
        })).to.be["false"];
        return expect(_B.isRefDisjoint(object, inheritedShallowClone, {
          deep: true,
          inherited: true
        })).to.be["false"];
      });
      return it("recognises disjoint (deep clones):", function () {
        expect(_B.isRefDisjoint(inheritedDeepClone, object, {
          deep: true,
          inherited: true
        })).to.be["true"];
        return expect(_B.isRefDisjoint(object, inheritedDeepClone, {
          deep: true,
          inherited: true
        })).to.be["true"];
      });
    });
  });
});

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))