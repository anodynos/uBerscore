// Generated by uRequire v0.7.0-beta.28 target: 'spec' template: 'UMDplain'
(function () {
  
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


var l = new _B.Logger('types/types-spec.js');

var A, AClass, anInstance, oOs;
AClass = function () {
  function AClass(prop) {
    this.prop = prop != null ? prop : "a property value";
  }
  return AClass;
}();
anInstance = new AClass();
oOs = {
  "Array": [
    [
      "this",
      "is",
      1,
      "array"
    ],
    new Array(1, 2, 3)
  ],
  "Arguments": [function () {
      return arguments;
    }()],
  "Function": [
    function (x) {
      return x;
    },
    new Function("var a = 'a'"),
    A = function () {
      function A() {
      }
      return A;
    }(),
    function () {
    }
  ],
  "String": [
    "I am a String!",
    new String("I am another String")
  ],
  "Number": [
    667,
    new Number(668.13)
  ],
  "Date": [new Date()],
  "RegExp": [
    /./g,
    new RegExp("/./")
  ],
  "Boolean": [
    true,
    false,
    new Boolean(true)
  ],
  "Null": [null],
  "Undefined": [
    void 0,
    void 0,
    function () {
    }()
  ],
  "Object": [
    { someProp: "SomeVal" },
    anInstance,
    new Object(),
    new function () {
    }()
  ]
};
describe("types & its associates:", function () {
  describe("`type` distisquishes all types", function () {
    var fn, i, len, typeName, value, values;
    for (typeName in oOs) {
      values = oOs[typeName];
      fn = function (typeName, value, longType, shortType) {
        return it("`type` recognises value of type '" + typeName + "' both as long='" + longType + "', as short='" + shortType, function () {
          expect(longType).to.equal(_B.type.toLong(typeName));
          expect(_B.type.isType(longType)).to.be["true"];
          expect(shortType).to.equal(_B.type.toShort(typeName));
          expect(_B.type.isType(shortType)).to.be["true"];
          return expect(_B.type.areEqual(longType, shortType)).to.be["true"];
        });
      };
      for (i = 0, len = values.length; i < len; i++) {
        value = values[i];
        fn(typeName, value, _B.type(value), _B.type(value, true));
      }
    }
    return null;
  });
  describe("`type` recognises all Object/Hashes {} correctly :", function () {
    return it("`type` correctly treats instances as Object, unlike lodash's `_.isPlainObject(anInstance) is false`", function () {
      if (_B.isLodash()) {
        expect(_.isPlainObject(anInstance)).to.be["false"];
      }
      return expect(_B.type(anInstance)).to.equal("Object");
    });
  });
  describe("`_B.isHash` uses the above to solve distinquishing an {} from other types (->, []), even if {} is an instance.", function () {
    it("`_B.isHash` recognises all {} as Objects, all Arrays & Functions are NON Objects", function () {
      expect(_B.isHash(anInstance)).to.be["true"];
      expect(_B.isHash({})).to.be["true"];
      expect(_B.isHash([])).to.be["false"];
      expect(_B.isHash(function () {
      })).to.be["false"];
      return [];
    });
    it("`_.isObject` is too broad - considers Arrays & Functions as `Object`", function () {
      expect(_.isObject(anInstance)).to.be["true"];
      expect(_.isObject({})).to.be["true"];
      expect(_.isObject([])).to.be["true"];
      return expect(_.isObject(function () {
      })).to.be["true"];
    });
    if (_B.isLodash()) {
      return it("`_.isPlainObject` (lodash) is too strict - non `Object` constructed {} are not Object!", function () {
        expect(_.isPlainObject({})).to.be["true"];
        expect(_.isPlainObject(anInstance)).to.be["false"];
        expect(_.isPlainObject([])).to.be["false"];
        return expect(_.isPlainObject(function () {
        })).to.be["false"];
      });
    }
  });
  describe("`_Β.isHash` recognises all types correctly:", function () {
    var fn, i, len, typeName, value, values;
    for (typeName in oOs) {
      values = oOs[typeName];
      fn = function (typeName, value) {
        return it("`_B.isHash` for '" + typeName + "' returns '" + (typeName === "Object" ? "true" : "false"), function () {
          if (typeName === "Object") {
            return expect(_B.isHash(value)).to.be["true"];
          } else {
            return expect(_B.isHash(value)).to.be["false"];
          }
        });
      };
      for (i = 0, len = values.length; i < len; i++) {
        value = values[i];
        fn(typeName, value);
      }
    }
    return null;
  });
  return describe("isPlain correctly recognises plain (non-nested) value types:", function () {
    var fn, i, isPlainType, len, typeName, value, values;
    isPlainType = function (typeName) {
      return typeName === "String" || typeName === "Date" || typeName === "RegExp" || typeName === "Number" || typeName === "Boolean" || typeName === "Null" || typeName === "Undefined";
    };
    for (typeName in oOs) {
      values = oOs[typeName];
      fn = function (typeName, value) {
        return it("`isPlain` recognises all '" + typeName + "' as a " + (isPlainType(typeName) ? "" : "NON") + " plain type", function () {
          if (isPlainType(typeName)) {
            return expect(_B.isPlain(value)).to.be["true"];
          } else {
            return expect(_B.isPlain(value)).to.be["false"];
          }
        });
      };
      for (i = 0, len = values.length; i < len; i++) {
        value = values[i];
        fn(typeName, value);
      }
    }
    return null;
  });
});

return module.exports;

});
}).call(this);