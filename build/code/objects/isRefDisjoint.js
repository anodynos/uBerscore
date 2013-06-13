// Generated by uRequire v0.4.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/isRefDisjoint', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree', './getRefs', './isDisjoint'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var getRefs, isDisjoint, isRefDisjoint, isRefDisjointDefaults, _;

_ = require("lodash");

getRefs = require("./getRefs");

isDisjoint = require("./isDisjoint");

isRefDisjointDefaults = {
    deep: false,
    inherited: false
};

isRefDisjoint = function(oa1, oa2, options) {
    var refs1, refs2;
    if (options == null) {
        options = isRefDisjointDefaults;
    }
    if (options !== isRefDisjointDefaults) {
        _.defaults(options, isRefDisjointDefaults);
    }
    if (oa1 === oa2) {
        return false;
    } else {
        refs1 = getRefs(oa1, options);
        refs1.unshift(oa1);
        refs2 = getRefs(oa2, options);
        refs2.unshift(oa2);
        return isDisjoint(refs1, refs2);
    }
};

module.exports = isRefDisjoint;
// uRequire: end body of original nodejs module


return module.exports;
})
})();