// Generated by uRequire v0.6.20 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('../../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', '../../agreement/isAgree'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, isAgree) {
  

var isAgree, arrayize;
isAgree = require("../../agreement/isAgree");
arrayize = function (item) {
  if (_.isArray(item)) {
    return item;
  } else {
    if (_.isUndefined(item) || _.isNull(item)) {
      return [];
    } else {
      return [item];
    }
  }
};
module.exports = arrayize;

return module.exports;

})
}).call(this)