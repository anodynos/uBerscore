// Generated by uRequire v0.4.2
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/mutate', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree', '../collections/go'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var go, isAgree, mutate, _;

_ = require("lodash");

isAgree = require("../agreement/isAgree");

go = require("../collections/go");

mutate = function(oa, mutator, fltr) {
    if (_.isFunction(mutator)) {
        go(oa, {
            iter: function(v, k) {
                if (isAgree(v, fltr)) {
                    return oa[k] = mutator(v);
                }
            }
        });
    }
    return oa;
};

module.exports = mutate;
// uRequire: end body of original nodejs module


return module.exports;
})
})();