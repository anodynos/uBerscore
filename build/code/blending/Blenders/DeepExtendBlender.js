// Generated by uRequire v0.3.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/Blenders/DeepExtendBlender', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../../agreement/isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var DeepExtendBlender;

module.exports = DeepExtendBlender = function() {
    function DeepExtendBlender() {}
    return DeepExtendBlender;
}();
// uRequire: end body of original nodejs module


return module.exports;
})
})();