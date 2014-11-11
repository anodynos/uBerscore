// Generated by uRequire v0.7.0-beta8 - template: 'UMDplain' 
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('../spec-data'), require('../specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', '../spec-data', '../specHelpers', './shared/deepExtendExamples-specs', './shared/lodashMerge-specs'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('blending/deepExtend-spec.js');

var _lodash_dummy_var;
  _lodash_dummy_var = require("lodash");
  if (_B.deepExtend) {
    describe("deepExtend :", function () {
      require("./shared/deepExtendExamples-specs")(_B.deepExtend);
      return require("./shared/lodashMerge-specs")(_B.deepExtend);
    });
  }
  return describe("DeepExtendBlender", function () {
    var deepExtendblender;
    deepExtendblender = new _B.DeepExtendBlender();
    return require("./shared/deepExtendExamples-specs")(deepExtendblender.blend);
  });


})
}).call(this)