// Generated by uRequire v0.3.0alpha23
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/isExact', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree', './isEqual'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var isEqual, isExact;

isEqual = require("./isEqual");

isExact = function(a, b, callback, thisArg, options) {
    if (options == null) {
        options = {};
    }
    options.exact = true;
    return isEqual.apply(void 0, [ a, b, callback, thisArg, options ]);
};

module.exports = isExact;
// uRequire: end body of original nodejs module


return module.exports;
})
})();