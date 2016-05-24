// Generated by uRequire v0.7.0-beta.28 target: 'UMD' template: 'UMDplain'
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

var isEqualArraySet;
isEqualArraySet = function (a1, a2, equalsFn) {
  if (_.difference(a1, a2).length === 0) {
    return _.difference(a2, a1).length === 0;
  } else {
    return false;
  }
};
module.exports = isEqualArraySet;

return module.exports;

});
}).call(this);