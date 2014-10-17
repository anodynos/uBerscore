// Generated by uRequire v0.7.0-beta4 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('objects/getRefs-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../specHelpers'), nr.require('../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../specHelpers', '../spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var equal = specHelpers["equal"],notEqual = specHelpers["notEqual"],ok = specHelpers["ok"],notOk = specHelpers["notOk"],tru = specHelpers["tru"],fals = specHelpers["fals"],deepEqual = specHelpers["deepEqual"],notDeepEqual = specHelpers["notDeepEqual"],exact = specHelpers["exact"],notExact = specHelpers["notExact"],iqual = specHelpers["iqual"],notIqual = specHelpers["notIqual"],ixact = specHelpers["ixact"],notIxact = specHelpers["notIxact"],like = specHelpers["like"],notLike = specHelpers["notLike"],likeBA = specHelpers["likeBA"],notLikeBA = specHelpers["notLikeBA"],equalSet = specHelpers["equalSet"],notEqualSet = specHelpers["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('objects/getRefs-spec.js');

describe("getRefs:", function () {
  it("from array, deep = false", function () {
    var oa;
    oa = [
      0,
      1,
      { p: [{ PP: 3 }] },
      {
        a: {
          b: function () {
          }
        }
      },
      4
    ];
    return equalSet(_B.getRefs(oa), [
      oa[3],
      oa[2]
    ]);
  });
  it("from array, deep = true:", function () {
    var oa;
    oa = [
      0,
      1,
      { p: [{ PP: 3 }] },
      {
        a: {
          b: function () {
          }
        }
      },
      4
    ];
    return equalSet(_B.getRefs(oa, { deep: true }), [
      oa[2],
      oa[2].p,
      oa[2].p[0],
      oa[3],
      oa[3].a,
      oa[3].a.b
    ]);
  });
  return it("from object, deep = true:", function () {
    var oa;
    oa = {
      p0: 0,
      p1: 1,
      p2: { p: [{ PP: 3 }] },
      p3: {
        a: {
          b: function () {
          }
        }
      },
      p4: 4
    };
    return equalSet(_B.getRefs(oa, { deep: true }), [
      oa.p2.p,
      oa.p2.p[0],
      oa.p2,
      oa.p3,
      oa.p3.a,
      oa.p3.a.b
    ]);
  });
});

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))