// Generated by uRequire v0.7.0-beta.28 target: 'AMD' template: 'AMD'
(function () {
  define(['require', 'exports', 'module', 'lodash', './type'], function (require, exports, module, _) {
  

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
}).call(this);