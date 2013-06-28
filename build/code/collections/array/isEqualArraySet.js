// Generated by uRequire v0.4.0
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
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var isEqualArraySet, _;

_ = require("lodash");

isEqualArraySet = function(a1, a2, equalsFn) {
    if (_.difference(a1, a2).length === 0) {
        return _.difference(a2, a1).length === 0;
    } else {
        return false;
    }
};

module.exports = isEqualArraySet;
// uRequire: end body of original nodejs module


return module.exports;
})
})();