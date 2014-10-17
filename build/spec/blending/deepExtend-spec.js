// Generated by uRequire v0.7.0-beta4 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('blending/deepExtend-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../specHelpers'), nr.require('../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../specHelpers', '../spec-data', './shared/deepExtendExamples-specs', './shared/lodashMerge-specs'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var equal = specHelpers["equal"],notEqual = specHelpers["notEqual"],ok = specHelpers["ok"],notOk = specHelpers["notOk"],tru = specHelpers["tru"],fals = specHelpers["fals"],deepEqual = specHelpers["deepEqual"],notDeepEqual = specHelpers["notDeepEqual"],exact = specHelpers["exact"],notExact = specHelpers["notExact"],iqual = specHelpers["iqual"],notIqual = specHelpers["notIqual"],ixact = specHelpers["ixact"],notIxact = specHelpers["notIxact"],like = specHelpers["like"],notLike = specHelpers["notLike"],likeBA = specHelpers["likeBA"],notLikeBA = specHelpers["notLikeBA"],equalSet = specHelpers["equalSet"],notEqualSet = specHelpers["notEqualSet"];
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
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))