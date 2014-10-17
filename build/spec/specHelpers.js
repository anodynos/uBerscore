// Generated by uRequire v0.7.0-beta4 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('specHelpers', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('./spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', './spec-data'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, data) {
  

var expect = chai["expect"];


var l = new _B.Logger('specHelpers.js');

var are, createEqualSet, deepEqual, equal, equalSet, exact, fals, iqual, ixact, like, likeBA, notDeepEqual, notEqual, notEqualSet, notExact, notIqual, notIxact, notLike, notLikeBA, notOk, ok, tru;
equal = function (a, b) {
  return expect(a).to.equal(b);
};
notEqual = function (a, b) {
  return expect(a).to.not.equal(b);
};
ok = function (a) {
  return expect(a).to.be.ok;
};
notOk = function (a) {
  return expect(a).to.be.not.ok;
};
tru = function (a) {
  return expect(a).to.be["true"];
};
fals = function (a) {
  return expect(a).to.be["false"];
};
are = function (name, asEqual) {
  if (asEqual == null) {
    asEqual = true;
  }
  return function (a, b) {
    var isEq, path;
    isEq = _B[name](a, b, {
      path: path = [],
      allProps: true,
      exclude: ["inspect"]
    });
    if (asEqual) {
      if (!isEq) {
        l.warn("Discrepancy, expected `true` from _B." + name + " \n at path: ", path.join("."), " \n left value = ", _B.getp(a, path), "\n right value =", _B.getp(b, path), " \n left Object = \n", a, "\n right Object = \n", b);
      }
      return expect(isEq).to.be["true"];
    } else {
      if (isEq) {
        l.warn("Discrepancy, expected `false` from _B." + name + ", but its `true`.");
      }
      return expect(isEq).to.be["false"];
    }
  };
};
createEqualSet = function (asEqual) {
  return function (result, expected) {
    var isEq;
    isEq = _B.isEqualArraySet(result, expected);
    if (asEqual) {
      if (!isEq) {
        l.warn("\n _B.isEqualArraySet expected `true`", "\n result \\ expected \n", _.difference(result, expected), "\n expected \\ result \n", _.difference(expected, result));
      }
      return expect(isEq).to.be["true"];
    } else {
      if (isEq) {
        l.warn("\n _B.isEqualArraySet expected `false`, got `true`");
      }
      return expect(isEq).to.be["false"];
    }
  };
};
equalSet = createEqualSet(true);
notEqualSet = createEqualSet(false);
deepEqual = are("isEqual");
notDeepEqual = are("isEqual", false);
exact = are("isExact");
notExact = are("isExact", false);
iqual = are("isIqual");
notIqual = are("isIqual", false);
ixact = are("isIxact");
notIxact = are("isIxact", false);
like = are("isLike");
notLike = are("isLike", false);
likeBA = function (a, b) {
  return like(b, a);
};
notLikeBA = function (a, b) {
  return notLike(b, a);
};
module.exports = {
  equal: equal,
  notEqual: notEqual,
  tru: tru,
  fals: fals,
  ok: ok,
  notOk: notOk,
  deepEqual: deepEqual,
  notDeepEqual: notDeepEqual,
  exact: exact,
  notExact: notExact,
  iqual: iqual,
  notIqual: notIqual,
  ixact: ixact,
  notIxact: notIxact,
  like: like,
  notLike: notLike,
  likeBA: likeBA,
  notLikeBA: notLikeBA,
  equalSet: equalSet,
  notEqualSet: notEqualSet
};

return module.exports;

})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))