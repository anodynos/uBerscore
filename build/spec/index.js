// Generated by uRequire v0.3.0alpha17
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('index', __dirname, '.');
   module.exports = factory(nr.require, exports, module);
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', './arrayize-spec', './deepCloneDefaults-spec', './deepExtend-spec', './go-spec', './okv-spec', './mutate-spec', './spec-data', './uberscore-spec'], factory);
 }
})(this,function (require, exports, module) {
  // uRequire: start body of original nodejs module
require("./arrayize-spec");

require("./deepCloneDefaults-spec");

require("./deepExtend-spec");

require("./go-spec");

require("./okv-spec");

require("./mutate-spec");

require("./spec-data");

require("./uberscore-spec");
// uRequire: end body of original nodejs module


return module.exports;
})
})();