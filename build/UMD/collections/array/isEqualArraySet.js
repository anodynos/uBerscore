// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;


(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('collections/array/isEqualArraySet', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../../agreement/isAgree'], factory);
 }
}).call(this, this,function (require, exports, module, _, isAgree) {
  
// uRequire v0.6.0: START body of original nodejs module
  var isEqualArraySet;
  isEqualArraySet = function (a1, a2, equalsFn) {
    if (_.difference(a1, a2).length === 0) {
      return _.difference(a2, a1).length === 0;
    } else {
      return false;
    }
  };
  module.exports = isEqualArraySet;
// uRequire v0.6.0: END body of original nodejs module


return module.exports;
})
}).call(this);