// Generated by uRequire v0.3.0alpha23
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('certain', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var certain, _;

_ = require("lodash");

certain = function(o, defaultKey, defaultVal, isStrict) {
    if (isStrict == null) {
        isStrict = false;
    }
    if (!(_.isPlainObject(o) || _.isFunction(o))) {
        throw "Error: _B.certain: o is neither an Object or Function.\no=" + JSON.stringify(o, null, "");
    }
    if (_.isUndefined(defaultKey)) {
        defaultKey = "*";
    }
    return function(key) {
        var val, _ref, _ref1;
        val = (_ref = (_ref1 = o[key]) != null ? _ref1 : o[defaultKey]) != null ? _ref : defaultVal;
        if (isStrict && _.isUndefined(val)) {
            throw "Error: _B.certain: defaultKey is undefined.\n  defaultVal is also undefined.\n  key='" + key + "' (o[" + key + "] is obviously undefined too)\n  defaultKey='" + defaultKey + "'\n  o=" + JSON.stringify(o, null, "");
        }
        return val;
    };
};

module.exports = certain;
// uRequire: end body of original nodejs module


return module.exports;
})
})();