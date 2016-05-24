// Generated by uRequire v0.7.0-beta.28 target: 'UMD' template: 'UMDplain'
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', './type'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

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

});
}).call(this);