// Generated by uRequire v0.3.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('isPlain', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree', './type'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var isPlain, type, _, __indexOf = [].indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
        if (i in this && this[i] === item) return i;
    }
    return -1;
};

_ = require("lodash");

type = require("./type");

isPlain = function(o) {
    var _ref;
    return _ref = type(o), __indexOf.call(isPlain.PLAIN_TYPES, _ref) >= 0;
};

isPlain.PLAIN_TYPES = [ "String", "Date", "RegExp", "Number", "Boolean", "Null", "Undefined" ];

module.exports = isPlain;
// uRequire: end body of original nodejs module


return module.exports;
})
})();