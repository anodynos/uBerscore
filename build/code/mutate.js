// Generated by uRequire v0.3.0alpha16
(function (root, factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('mutate', __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
  } else if (typeof define === 'function' && define.amd) {
      define(['require', 'exports', 'module', 'lodash', './agreement/isAgree', './go'], factory);
  }
})(this, function (require, exports, module, _, isAgree) {
 var isWeb = (typeof define === 'function' && define.amd), isNode = !isWeb;

// uRequire: start body of original nodejs module
var go, mutate;

go = require("./go");

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
});