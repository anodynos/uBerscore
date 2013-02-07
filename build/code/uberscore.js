// Generated by uRequire v0.3.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('uberscore', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree', './go', './blending/deepExtend', './blending/deepCloneDefaults', './blending/Blender', './okv', './arrayize', './agreement/inAgreements', './certain', './mutate', './type', './isPlain', './Logger'], function (require, exports, module, _, isAgree) {
  
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
    uberscore.prototype.go = require("./go");
    uberscore.prototype.deepExtend = require("./blending/deepExtend");
    uberscore.prototype.deepCloneDefaults = require("./blending/deepCloneDefaults");
    uberscore.prototype.Blender = require("./blending/Blender");
    uberscore.prototype.okv = require("./okv");
    uberscore.prototype.arrayize = require("./arrayize");
    uberscore.prototype.isAgree = require("./agreement/isAgree");
    uberscore.prototype.inAgreements = require("./agreement/inAgreements");
    uberscore.prototype.certain = require("./certain");
    uberscore.prototype.mutate = require("./mutate");
    uberscore.prototype.type = require("./type");
    uberscore.prototype.isPlain = require("./isPlain");
    uberscore.prototype.Logger = require("./Logger");
    return uberscore;
}();

module.exports = new uberscore;
// uRequire: end body of original nodejs module


return module.exports;
})
})();