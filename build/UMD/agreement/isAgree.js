// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;


(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('agreement/isAgree', module, __dirname, '.');
   module.exports = factory(nr.require, nr.require('lodash'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'lodash'], factory);
 }
}).call(this, this,function (require, _) {
  
// uRequire v0.6.0: START body of original AMD module
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
// uRequire v0.6.0: END body of original AMD module


})
}).call(this);