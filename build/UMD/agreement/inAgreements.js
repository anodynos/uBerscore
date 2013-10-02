// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;


(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('agreement/inAgreements', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './isAgree', '../collections/array/arrayize'], factory);
 }
}).call(this, this,function (require, exports, module, _, isAgree) {
  
// uRequire v0.6.0: START body of original nodejs module
  var arrayize;
  arrayize = require("../collections/array/arrayize");
  module.exports = function (o, agreements) {
    var agr, _i, _len;
    agreements = arrayize(agreements);
    if (_.isEmpty(agreements)) {
      return false;
    } else {
      for (_i = 0, _len = agreements.length; _i < _len; _i++) {
        agr = agreements[_i];
        if (isAgree(o, agr)) {
          return true;
        }
      }
    }
    return false;
  };
// uRequire v0.6.0: END body of original nodejs module


return module.exports;
})
}).call(this);