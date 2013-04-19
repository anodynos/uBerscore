// Generated by uRequire v0.3.0alpha22
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('uberscore', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree', './blending/Blender', './blending/blenders/DeepCloneBlender', './blending/blenders/DeepExtendBlender', './blending/deepExtend', './blending/deepCloneDefaults', './objects/okv', './objects/mutate', './objects/setValueAtPath', './objects/getValueAtPath', './objects/isDisjoint', './objects/isRefDisjoint', './objects/getRefs', './objects/getInheritedPropertyNames', './objects/isEqual', './objects/isIqual', './objects/isExact', './objects/isIxact', './collections/go', './collections/array/isEqualArraySet', './collections/array/arrayize', './agreement/inAgreements', './type', './isPlain', './Logger', './certain'], function (require, exports, module, _, isAgree) {
  var m = factory(require, exports, module, _, isAgree);
var old__B = root._B,
    old_uberscore = root.uberscore;

root._B = m;
root.uberscore = m;
m.noConflict = function () {
    root._B = old__B;
  root.uberscore = old_uberscore;
return m;
}
return m;
});
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var uberscore;

({
    urequire: {
        rootExports: [ "_B", "uberscore" ],
        noConflict: true
    }
});

uberscore = function() {
    function uberscore() {}
    uberscore.prototype.Blender = require("./blending/Blender");
    uberscore.prototype.DeepCloneBlender = require("./blending/blenders/DeepCloneBlender");
    uberscore.prototype.DeepExtendBlender = require("./blending/blenders/DeepExtendBlender");
    uberscore.prototype.deepExtend = require("./blending/deepExtend");
    uberscore.prototype.deepCloneDefaults = require("./blending/deepCloneDefaults");
    uberscore.prototype.okv = require("./objects/okv");
    uberscore.prototype.mutate = require("./objects/mutate");
    uberscore.prototype.setValueAtPath = require("./objects/setValueAtPath");
    uberscore.prototype.getValueAtPath = require("./objects/getValueAtPath");
    uberscore.prototype.isDisjoint = require("./objects/isDisjoint");
    uberscore.prototype.isRefDisjoint = require("./objects/isRefDisjoint");
    uberscore.prototype.getRefs = require("./objects/getRefs");
    uberscore.prototype.getInheritedPropertyNames = require("./objects/getInheritedPropertyNames");
    uberscore.prototype.isEqual = require("./objects/isEqual");
    uberscore.prototype.isIqual = require("./objects/isIqual");
    uberscore.prototype.isExact = require("./objects/isExact");
    uberscore.prototype.isIxact = require("./objects/isIxact");
    uberscore.prototype.go = require("./collections/go");
    uberscore.prototype.isEqualArraySet = require("./collections/array/isEqualArraySet");
    uberscore.prototype.arrayize = require("./collections/array/arrayize");
    uberscore.prototype.isAgree = require("./agreement/isAgree");
    uberscore.prototype.inAgreements = require("./agreement/inAgreements");
    uberscore.prototype.type = require("./type");
    uberscore.prototype.isPlain = require("./isPlain");
    uberscore.prototype.Logger = require("./Logger");
    uberscore.prototype.certain = require("./certain");
    return uberscore;
}();

module.exports = new uberscore;
// uRequire: end body of original nodejs module


return module.exports;
})
})();