// Generated by uRequire v0.6.10 - template: 'AMD' 
(function () {
  define(['require', 'exports', 'module', 'underscore', '../agreement/isAgree', '../collections/go'], function (require, exports, module, _, isAgree) {
  

var go = require("../collections/go");
var mutate = function (oa, mutator, fltr) {
  if (_.isFunction(mutator)) {
    go(oa, {
      iter: function (v, k) {
        if (isAgree(v, fltr)) {
          return oa[k] = mutator(v);
        }
      }
    });
  }
  return oa;
};
module.exports = mutate;

return module.exports;

})
}).call(this)