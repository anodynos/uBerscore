// Generated by uRequire v0.7.0-beta8 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', './isIqual'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

var isIqual, isIxact;
isIqual = require("./isIqual");
isIxact = function (a, b, callback, ctx, options) {
  if (options == null) {
    options = {};
  }
  options.exact = true;
  return isIqual(a, b, callback, ctx, options);
};
module.exports = isIxact;

return module.exports;

})
}).call(this)