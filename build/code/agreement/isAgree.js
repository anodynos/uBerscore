// Generated by uRequire v0.3.0alpha16
(function (root, factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('agreement/isAgree', __dirname, '.');
    module.exports = factory(nr.require, nr.require('lodash'), nr.require('./isAgree'));
  } else if (typeof define === 'function' && define.amd) {
      define(['require', 'lodash', './isAgree'], factory);
  }
})(this, function (require, _, isAgree) {
 var isWeb = (typeof define === 'function' && define.amd), isNode = !isWeb;

// uRequire: start body of original AMD module
return function(o, agreement) {
        if (_.isRegExp(agreement)) {
            return agreement.test(o + "");
        } else {
            if (_.isFunction(agreement)) {
                return agreement(o);
            } else {
                if (agreement === void 0) {
                    return true;
                } else {
                    if (_.isEqual(o, agreement)) {
                        return true;
                    } else {
                        return o + "" === agreement + "";
                    }
                }
            }
        }
    };
// uRequire: end body of original AMD module

 
});