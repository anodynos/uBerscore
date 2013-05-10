// Generated by uRequire v0.3.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/isDisjoint', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var isDisjoint, _;

_ = require("lodash");

isDisjoint = function(oa1, oa2, equality) {
    var found;
    if (equality == null) {
        equality = function(v1, v2) {
            return v1 === v2;
        };
    }
    found = false;
    _.each(oa1, function(v1) {
        if (_.any(oa2, function(v2) {
            return equality(v1, v2);
        })) {
            found = true;
            return false;
        }
    });
    return !found;
};

module.exports = isDisjoint;
// uRequire: end body of original nodejs module


return module.exports;
})
})();