// Generated by uRequire v0.3.0alpha16
(function (root, factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('uBerscore', __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
  } else if (typeof define === 'function' && define.amd) {
      define(['require', 'exports', 'module', 'lodash', './agreement/isAgree', './go', './deepExtend', './deepCloneDefaults', './okv', './arrayize', './agreement/inAgreements', './certain', './mutate'], function (require, exports, module, _, isAgree) {

var m = factory(require, exports, module, _, isAgree);
var old__B = root._B,
    old_uBerscore = root.uBerscore;

root._B = m;
root.uBerscore = m;


m.noConflict = function(){
  root._B = old__B;
  root.uBerscore = old_uBerscore;
  return m;
};
return m;});
  }
})(this, function (require, exports, module, _, isAgree) {
 var isWeb = (typeof define === 'function' && define.amd), isNode = !isWeb;

// uRequire: start body of original nodejs module
var ao, uBerscore;

({
    urequire: {
        rootExports: [ "_B", "uBerscore" ],
        noConflict: true
    }
});

uBerscore = function() {
    function uBerscore() {}
    uBerscore.prototype.go = require("./go");
    uBerscore.prototype.deepExtend = require("./deepExtend");
    uBerscore.prototype.deepCloneDefaults = require("./deepCloneDefaults");
    uBerscore.prototype.okv = require("./okv");
    uBerscore.prototype.arrayize = require("./arrayize");
    uBerscore.prototype.isAgree = require("./agreement/isAgree");
    uBerscore.prototype.inAgreements = require("./agreement/inAgreements");
    uBerscore.prototype.certain = require("./certain");
    uBerscore.prototype.mutate = require("./mutate");
    return uBerscore;
}();

module.exports = new uBerscore;

ao = {
    a: 1,
    b: 2,
    c: -1
};

ao = module.exports.go(ao, {
    fltr: "a"
});
// uRequire: end body of original nodejs module


return module.exports; 
});