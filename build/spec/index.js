// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;


(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('index', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('./spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', './spec-data', './blending/Blender-spec', './blending/deepExtend-spec', './blending/lodash-merge-spec', './blending/Mergers_Blender-spec', './blending/DeepDefaultsBlender-spec', './blending/ArrayizePushBlender-spec', './blending/traverse-spec', './objects/getInheritedPropertyNames-spec', './objects/getp-spec', './objects/getRefs-spec', './objects/isDisjoint-spec', './objects/isEqual-spec', './objects/isRefDisjoint-spec', './objects/mutate-spec', './objects/okv-spec', './objects/setp-spec', './collections/go-spec', './collections/array/arrayize-spec', './collections/array/isEqualArraySet-spec', './agreement/isAgree-spec', './types/types-spec', './utils/CoffeeUtils-spec', './utils/CalcCachedProperties-spec', './Logger-spec', './uberscore-spec'], factory);
 }
}).call(this, this,function (require, exports, module, chai, _, _B, data) {
  
// uRequire v0.6.0: START body of original nodejs module
  require("./blending/Blender-spec");
  require("./blending/deepExtend-spec");
  require("./blending/lodash-merge-spec");
  require("./blending/Mergers_Blender-spec");
  require("./blending/DeepDefaultsBlender-spec");
  require("./blending/ArrayizePushBlender-spec");
  require("./blending/traverse-spec");
  require("./objects/getInheritedPropertyNames-spec");
  require("./objects/getp-spec");
  require("./objects/getRefs-spec");
  require("./objects/isDisjoint-spec");
  require("./objects/isEqual-spec");
  require("./objects/isRefDisjoint-spec");
  require("./objects/mutate-spec");
  require("./objects/okv-spec");
  require("./objects/setp-spec");
  require("./collections/go-spec");
  require("./collections/array/arrayize-spec");
  require("./collections/array/isEqualArraySet-spec");
  require("./agreement/isAgree-spec");
  require("./types/types-spec");
  require("./utils/CoffeeUtils-spec");
  require("./utils/CalcCachedProperties-spec");
  require("./Logger-spec");
  require("./spec-data");
  require("./uberscore-spec");
// uRequire v0.6.0: END body of original nodejs module


return module.exports;
})
}).call(this);