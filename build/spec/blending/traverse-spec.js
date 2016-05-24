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


var l = new _B.Logger('blending/traverse-spec.js');

describe("traverse:", function () {
  var o;
  o = {
    a: {
      a1: { a1_1: { a1_1_1: 111 } },
      a2: {
        bingo: true,
        a2_1: { a2_1_1: 211 }
      }
    },
    b: 2
  };
  it("traverses nested objects", function () {
    var props;
    props = [];
    _B.traverse(o, function (prop, src, blender) {
      return props.push(prop);
    });
    return expect(props).to.be.deep.equal([
      "a",
      "a1",
      "a1_1",
      "a2",
      "a2_1"
    ]);
  });
  return it("quits branch if callback returns false", function () {
    var props;
    props = [];
    _B.traverse(o, function (prop, src, blender) {
      props.push(prop);
      if (src[prop].bingo === true) {
        return false;
      }
    });
    return expect(props).to.be.deep.equal([
      "a",
      "a1",
      "a1_1",
      "a2"
    ]);
  });
});

return module.exports;

});
}).call(this);