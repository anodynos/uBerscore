// Generated by uRequire v0.7.0-beta.25 target: 'UMD' template: 'UMDplain'
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', './DeepCloneBlender', './DeepExtendBlender', './DeepDefaultsBlender', './ArrayizeBlender'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

module.exports = {
  DeepCloneBlender: require("./DeepCloneBlender"),
  DeepExtendBlender: require("./DeepExtendBlender"),
  DeepDefaultsBlender: require("./DeepDefaultsBlender"),
  ArrayizeBlender: require("./ArrayizeBlender")
};

return module.exports;

});
}).call(this);