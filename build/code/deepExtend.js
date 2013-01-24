// Generated by uRequire v0.3.0alpha16
(function (root, factory) {
  if (typeof exports === 'object') {
    var nr = new (require('urequire').NodeRequirer) ('deepExtend', __dirname, '.');
    module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
  } else if (typeof define === 'function' && define.amd) {
      define(['require', 'exports', 'module', 'lodash', './agreement/isAgree'], factory);
  }
})(this, function (require, exports, module, _, isAgree) {
 var isWeb = (typeof define === 'function' && define.amd), isNode = !isWeb;

// uRequire: start body of original nodejs module
var deepExtend, __slice = [].slice, __hasProp = {}.hasOwnProperty;

deepExtend = function() {
    var obj, parentRE, prop, source, sources, _i, _len;
    obj = arguments[0], sources = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    parentRE = /#{\s*?_\s*?}/;
    for (_i = 0, _len = sources.length; _i < _len; _i++) {
        source = sources[_i];
        for (prop in source) {
            if (!__hasProp.call(source, prop)) continue;
            if (_.isUndefined(obj[prop])) {
                obj[prop] = source[prop];
            } else if (_.isString(source[prop]) && parentRE.test(source[prop])) {
                if (_.isString(obj[prop])) {
                    obj[prop] = source[prop].replace(parentRE, obj[prop]);
                }
            } else if (_.isArray(obj[prop]) || _.isArray(source[prop])) {
                if (!_.isArray(obj[prop]) || !_.isArray(source[prop])) {
                    throw "Error: Trying to combine an array with a non-array (" + prop + ")";
                } else {
                    obj[prop] = _.reject(deepExtend(obj[prop], source[prop]), function(item) {
                        return _.isNull(item);
                    });
                }
            } else if (_.isObject(obj[prop]) || _.isObject(source[prop])) {
                if (!_.isObject(obj[prop]) || !_.isObject(source[prop])) {
                    throw "Error: Trying to combine an object with a non-object (" + prop + ")";
                } else {
                    obj[prop] = deepExtend(obj[prop], source[prop]);
                }
            } else {
                obj[prop] = source[prop];
            }
        }
    }
    return obj;
};

module.exports = deepExtend;
// uRequire: end body of original nodejs module


return module.exports; 
});