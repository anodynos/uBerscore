// Generated by uRequire v0.7.0-beta.25 target: 'UMD' template: 'UMDplain'
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('./type'), require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', './type', 'lodash'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, type, _) {
  

return function (o) {
    return type(o) === "Object";
  };


});
}).call(this);