// Generated by uRequire v0.6.20 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('../../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', '../../agreement/isAgree', './DeepCloneBlender', './DeepExtendBlender', './DeepDefaultsBlender', './ArrayizePushBlender'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, isAgree) {
  

module.exports = {
  DeepCloneBlender: require("./DeepCloneBlender"),
  DeepExtendBlender: require("./DeepExtendBlender"),
  DeepDefaultsBlender: require("./DeepDefaultsBlender"),
  ArrayizePushBlender: require("./ArrayizePushBlender")
};

return module.exports;

})
}).call(this)