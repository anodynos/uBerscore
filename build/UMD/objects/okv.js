// Generated by uRequire v0.7.0-beta8 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

var okv, __slice = [].slice;
okv = function () {
  var idx, keyName, keyValPairs, obj, _i, _len;
  obj = arguments[0], keyValPairs = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
  if (_.isString(obj)) {
    keyValPairs.unshift(obj);
    obj = {};
  }
  if (_.isObject(obj)) {
    for (idx = _i = 0, _len = keyValPairs.length; _i < _len; idx = _i += 2) {
      keyName = keyValPairs[idx];
      if (idx + 1 < keyValPairs.length) {
        obj[keyName + ""] = keyValPairs[idx + 1];
      }
    }
    return obj;
  } else {
    return null;
  }
};
module.exports = okv;

return module.exports;

})
}).call(this)