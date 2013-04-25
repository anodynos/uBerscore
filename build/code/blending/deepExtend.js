// Generated by uRequire v0.3.0alpha23
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/deepExtend', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree', '../Logger'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var deepExtend, l, shadowed, _, __slice = [].slice, __hasProp = {}.hasOwnProperty;

_ = require("lodash");

l = new (require("../Logger"))("Blender", typeof debugLevel !== "undefined" && debugLevel !== null ? debugLevel : 0);

shadowed = [ "constructor", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "toLocaleString", "toString", "valueOf" ];

deepExtend = function() {
    var obj, parentRE, prop, source, sources, val, _i, _len;
    obj = arguments[0], sources = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    parentRE = /\${\s*?_\s*?}/;
    for (_i = 0, _len = sources.length; _i < _len; _i++) {
        source = sources[_i];
        for (prop in source) {
            if (!__hasProp.call(source, prop)) continue;
            if (_.isUndefined(obj[prop])) {
                obj[prop] = source[prop];
            } else {
                if (_.isString(source[prop]) && parentRE.test(source[prop])) {
                    if (_.isString(obj[prop])) {
                        obj[prop] = source[prop].replace(parentRE, obj[prop]);
                    }
                } else {
                    if (_.isArray(obj[prop]) || _.isArray(source[prop])) {
                        if (!_.isArray(obj[prop]) || !_.isArray(source[prop])) {
                            throw "deepExtend: Error: Trying to combine an array with a non-array.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(obj[prop]) + "\nsource[prop]: " + l.prettify(source[prop]);
                        } else {
                            obj[prop] = _.reject(deepExtend(obj[prop], source[prop]), function(item) {
                                return item === null || item === void 0;
                            });
                        }
                    } else {
                        if (_.isPlainObject(obj[prop]) || _.isPlainObject(source[prop])) {
                            if (!_.isPlainObject(obj[prop]) || !_.isPlainObject(source[prop])) {
                                throw "deepExtend: Error trying to combine a PlainObject with a non-PlainObject.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(obj[prop]) + "\nsource[prop]: " + l.prettify(source[prop]);
                            } else {
                                obj[prop] = deepExtend(obj[prop], source[prop]);
                            }
                        } else {
                            val = source[prop];
                            if ((val === null || val === void 0) && _.isPlainObject(obj)) {
                                delete obj[prop];
                            } else {
                                obj[prop] = val;
                            }
                        }
                    }
                }
            }
        }
    }
    return obj;
};

module.exports = deepExtend;
// uRequire: end body of original nodejs module


return module.exports;
})
})();