// Generated by uRequire v0.3.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('arrayize', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var isAgree, _;

_ = require("lodash");

isAgree = require("./agreement/isAgree");

module.exports = function(item) {
    if (_.isArray(item)) {
        return item;
    } else {
        if (_.isUndefined(item) || _.isNull(item)) {
            return [];
        } else {
            return [ item ];
        }
    }
};
// uRequire: end body of original nodejs module


return module.exports;
})
})();