// Generated by uRequire v0.7.0-beta5 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'lodash'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, _) {
  

return function (o, agreement) {
    if (_.isRegExp(agreement)) {
      return agreement.test(o + "");
    } else {
      if (_.isFunction(agreement)) {
        return agreement(o);
      } else {
        if (agreement === void 0) {
          return true;
        } else {
          if (_.isEqual(o, agreement)) {
            return true;
          } else {
            return o + "" === agreement + "";
          }
        }
      }
    }
  };


})
}).call(this)