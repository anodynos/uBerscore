// Generated by uRequire v0.3.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/okv', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var okv, _, __slice = [].slice;

_ = require("lodash");

okv = function() {
    var idx, keyName, keyValPairs, obj, _i, _len;
    obj = arguments[0], keyValPairs = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    if (_.isObject(obj)) {
        for (idx = _i = 0, _len = keyValPairs.length; _i < _len; idx = _i += 2) {
            keyName = keyValPairs[idx];
            if (idx + 1 < keyValPairs.length) {
                obj[keyName] = keyValPairs[idx + 1];
            }
        }
        return obj;
    } else {
        return null;
    }
};

module.exports = okv;
// uRequire: end body of original nodejs module


return module.exports;
})
})();