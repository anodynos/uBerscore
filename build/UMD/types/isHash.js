// Generated by uRequire v0.6.18 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, require('./type'), require('lodash'), require('../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) { define(['require', './type', 'lodash', '../agreement/isAgree'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, type, _, isAgree) {
  

return function (o) {
    return type(o) === "Object";
  };


})
}).call(this)