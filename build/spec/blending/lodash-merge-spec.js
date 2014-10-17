// Generated by uRequire v0.7.0-beta4 - template: 'UMD' 
(function (window, global) {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('blending/lodash-merge-spec', module, __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../specHelpers'), nr.require('../spec-data'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../specHelpers', '../spec-data', './shared/lodashMerge-specs', './shared/lodashMerge_Blender-specs'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, chai, _, _B, specHelpers, data) {
  

var equal = specHelpers["equal"],notEqual = specHelpers["notEqual"],ok = specHelpers["ok"],notOk = specHelpers["notOk"],tru = specHelpers["tru"],fals = specHelpers["fals"],deepEqual = specHelpers["deepEqual"],notDeepEqual = specHelpers["notDeepEqual"],exact = specHelpers["exact"],notExact = specHelpers["notExact"],iqual = specHelpers["iqual"],notIqual = specHelpers["notIqual"],ixact = specHelpers["ixact"],notIxact = specHelpers["notIxact"],like = specHelpers["like"],notLike = specHelpers["notLike"],likeBA = specHelpers["likeBA"],notLikeBA = specHelpers["notLikeBA"],equalSet = specHelpers["equalSet"],notEqualSet = specHelpers["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('blending/lodash-merge-spec.js');

if (_B.isLodash()) {
    describe("lodash's `merge` :", function () {
      require("./shared/lodashMerge-specs")(_.merge);
      return require("./shared/lodashMerge_Blender-specs")(_.merge);
    });
  }
  return describe("lodash.merge-like blender", function () {
    var lodashMerge_like_blender;
    lodashMerge_like_blender = new _B.Blender({
      order: ["src"],
      "Undefined": function () {
        return _B.Blender.SKIP;
      }
    });
    require("./shared/lodashMerge-specs")(lodashMerge_like_blender.blend);
    return require("./shared/lodashMerge_Blender-specs")(lodashMerge_like_blender.blend);
  });


})
}).call(this, (typeof exports === 'object' ? global : window), (typeof exports === 'object' ? global : window))