// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;


(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('collections/array/arrayize', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../../agreement/isAgree'], factory);
 }
}).call(this, this,function (require, exports, module, _, isAgree) {
  
// uRequire v0.6.0: START body of original nodejs module
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
// uRequire v0.6.0: END body of original nodejs module


return module.exports;
})
}).call(this);