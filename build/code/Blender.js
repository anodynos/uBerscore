// Generated by uRequire v0.3.0alpha18
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('Blender', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree', './type', './certain', './mutate', './go'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var Blender, certain, go, knownTypes, l, mutate, parentRE, prettify, type, _, __slice = [].slice, __hasProp = {}.hasOwnProperty;

_ = require("lodash");

l = console;

prettify = function(o) {
    return JSON.stringify(o, null, "");
};

type = require("./type");

certain = require("./certain");

mutate = require("./mutate");

go = require("./go");

knownTypes = [ "Array", "Arguments", "Function", "String", "Number", "Date", "RegExp", "Boolean", "Null", "Undefined", "Object" ];

parentRE = /\${\s*?_\s*?}/;

Blender = function(extenderBehavior) {
    var arrayToArrayPush, blend, blenderBehavior, certainExtenderBehavior, deepOverwrite, defaultBlenderBehavior, overwrite;
    overwrite = function(src, dst, prop) {
        if (parentRE.test(src[prop])) {
            if (_.isString(dst[prop])) {
                return src[prop].replace(parentRE, dst[prop]);
            } else {
                return dst[prop];
            }
        } else {
            return src[prop];
        }
    };
    deepOverwrite = function(src, dst, prop) {
        return blend(dst[prop], src[prop]);
    };
    arrayToArrayPush = function(src, dst, prop) {
        var s, _i, _len, _ref;
        _ref = src[prop];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            s = _ref[_i];
            dst[prop].push(s);
        }
        return dst[prop];
    };
    defaultBlenderBehavior = {
        Undefined: {
            "*": overwrite
        },
        String: {
            String: overwrite,
            Array: function(src, dst, prop) {
                var i;
                return "'" + dst[prop] + "' - the following Array landed on preceding String!\n" + function() {
                    var _i, _len, _ref, _results;
                    _ref = src[prop];
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        i = _ref[_i];
                        _results.push(i);
                    }
                    return _results;
                }().join("|");
            },
            Number: overwrite,
            "*": overwrite
        },
        Array: {
            Array: function() {
                var array;
                array = deepOverwrite.apply(null, arguments);
                return _.reject(array, function(v) {
                    return _.isNull(v);
                });
            },
            Undefined: function() {
                return [];
            },
            "*": overwrite
        },
        Object: {
            Object: deepOverwrite,
            "*": overwrite
        },
        "*": {
            "*": overwrite
        }
    };
    if (!blenderBehavior) {
        blenderBehavior = defaultBlenderBehavior;
    }
    certainExtenderBehavior = certain(mutate(blenderBehavior, certain));
    blend = function() {
        var action, dst, dstType, prop, sources, src, srcType, val, _i, _len;
        dst = arguments[0], sources = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        for (_i = 0, _len = sources.length; _i < _len; _i++) {
            src = sources[_i];
            for (prop in src) {
                if (!__hasProp.call(src, prop)) continue;
                srcType = type(src[prop]);
                dstType = type(dst[prop]);
                action = certainExtenderBehavior(dstType)(srcType);
                val = action(src, dst, prop);
                if (val === null && _.isPlainObject(dst)) {
                    delete dst[prop];
                } else {
                    dst[prop] = val;
                }
            }
        }
        return dst;
    };
    return blend;
};

module.exports = Blender;
// uRequire: end body of original nodejs module


return module.exports;
})
})();