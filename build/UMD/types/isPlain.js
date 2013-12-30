// Generated by uRequire v0.6.10 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) {
    define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree', './type'], factory);
  }
}).call(this, function (require, exports, module, _, isAgree) {
  

var type, isPlain;
type = require("./type");
isPlain = function (o) {
  return in$(type(o), isPlain.PLAIN_TYPES);
};
isPlain.PLAIN_TYPES = [
  "String",
  "Date",
  "RegExp",
  "Number",
  "Boolean",
  "Null",
  "Undefined"
];
module.exports = isPlain;
function in$(x, xs) {
  var i = -1, l = xs.length >>> 0;
  while (++i < l)
    if (x === xs[i])
      return true;
  return false;
}

return module.exports;

})
}).call(this)