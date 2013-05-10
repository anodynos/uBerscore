// Generated by uRequire v0.3.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/getInheritedPropertyNames', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var getInheritedPropertyNames, _, _getInheritedPropertyNames;

_ = require("lodash");

getInheritedPropertyNames = function(obj) {
    return _getInheritedPropertyNames(Object.getPrototypeOf(obj));
};

_getInheritedPropertyNames = function(obj) {
    var props;
    props = [];
    while (true) {
        if (!obj || obj === void 0 || _.isEmpty(obj) && !Object.getPrototypeOf(obj)) {
            break;
        }
        Object.getOwnPropertyNames(obj).forEach(function(prop) {
            if (props.indexOf(prop) === -1 && prop !== "constructor") {
                return props.push(prop);
            }
        });
        obj = Object.getPrototypeOf(obj);
    }
    return props;
};

module.exports = getInheritedPropertyNames;
// uRequire: end body of original nodejs module


return module.exports;
})
})();