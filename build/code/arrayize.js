// Generated by uRequire v0.3.0alpha15
(function (root, factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('arrayize', __dirname, '.');
    module.exports = factory(nr.require, nr.require('./agreement/isAgree'), nr.require('lodash'));
  } else if (typeof define === 'function' && define.amd) {
      define(['require', './agreement/isAgree', 'lodash'], factory);
  }
})(this, function (require, isAgree, _) {
 var isWeb = (typeof define === 'function' && define.amd), isNode = !isWeb;

// uRequire: start body of original AMD module
return function(item, fltr) {
        if (isAgree(item, fltr)) {
            if (_.isArray(item)) {
                return item;
            } else {
                if (_.isUndefined(item) || _.isNull(item)) {
                    return [];
                } else {
                    return [ item ];
                }
            }
        } else {
            return item;
        }
    };
// uRequire: end body of original AMD module

 
});