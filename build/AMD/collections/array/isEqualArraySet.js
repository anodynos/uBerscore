// Generated by uRequire v0.7.0-beta8 - template: 'AMD' 
(function () {
  define(['require', 'exports', 'module', 'lodash'], function (require, exports, module, _) {
  

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

})
}).call(this)