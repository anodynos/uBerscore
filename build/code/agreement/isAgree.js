// Generated by uRequire v0.4.2
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('agreement/isAgree', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var _;

_ = require("lodash");

module.exports = function(o, agreement) {
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
// uRequire: end body of original nodejs module


return module.exports;
})
})();