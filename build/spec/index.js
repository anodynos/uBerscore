// Generated by uRequire v0.3.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('index', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('./spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', './spec-data', './blending/Blender-spec', './blending/deepExtend-spec', './blending/lodash-merge-spec', './blending/Mergers_Blender-spec', './blending/DeepDefaultsBlender-spec', './objects/getInheritedPropertyNames-spec', './objects/getRefs-spec', './objects/getValueAtPath-spec', './objects/isDisjoint-spec', './objects/isEqual-spec', './objects/isRefDisjoint-spec', './objects/mutate-spec', './objects/okv-spec', './objects/setValueAtPath-spec', './collections/go-spec', './collections/array/arrayize-spec', './collections/array/isEqualArraySet-spec', './type-spec', './isPlain-spec', './uberscore-spec'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
require("./blending/Blender-spec");

require("./blending/deepExtend-spec");

require("./blending/lodash-merge-spec");

require("./blending/Mergers_Blender-spec");

require("./blending/DeepDefaultsBlender-spec");

require("./objects/getInheritedPropertyNames-spec");

require("./objects/getRefs-spec");

require("./objects/getValueAtPath-spec");

require("./objects/isDisjoint-spec");

require("./objects/isEqual-spec");

require("./objects/isRefDisjoint-spec");

require("./objects/mutate-spec");

require("./objects/okv-spec");

require("./objects/setValueAtPath-spec");

require("./collections/go-spec");

require("./collections/array/arrayize-spec");

require("./collections/array/isEqualArraySet-spec");

require("./type-spec");

require("./isPlain-spec");

require("./spec-data");

require("./uberscore-spec");
// uRequire: end body of original nodejs module


return module.exports;
})
})();