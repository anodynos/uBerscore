// Generated by uRequire v0.7.0-beta.28 target: 'spec' template: 'UMDplain'
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('../spec-data'), require('../specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', '../spec-data', '../specHelpers', './shared/lodashMerge-specs', './shared/lodashMerge_Blender-specs'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
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


});
}).call(this);