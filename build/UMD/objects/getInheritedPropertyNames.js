// Generated by uRequire v0.7.0-beta4 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, isAgree) {
  

var getInheritedPropertyNames, _getInheritedPropertyNames;
getInheritedPropertyNames = function (obj) {
  return _getInheritedPropertyNames(Object.getPrototypeOf(obj));
};
_getInheritedPropertyNames = function (obj) {
  var props;
  props = [];
  while (true) {
    if (!obj || obj === void 0 || _.isEmpty(obj) && !Object.getPrototypeOf(obj)) {
      break;
    }
    Object.getOwnPropertyNames(obj).forEach(function (prop) {
      if (props.indexOf(prop) === -1 && prop !== "constructor") {
        return props.push(prop);
      }
    });
    obj = Object.getPrototypeOf(obj);
  }
  return props;
};
module.exports = getInheritedPropertyNames;

return module.exports;

})
}).call(this)