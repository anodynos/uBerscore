(function() {
    var loggerPath, __slice = [].slice, __hasProp = {}.hasOwnProperty;
    loggerPath = "./../";
    define([ "require", "exports", "module", loggerPath + "Logger", "lodash", "../agreement/isAgree", "../uberscore", "../types/isHash" ], function(require, exports, module, Logger, _, isAgree) {
        var deepExtend, isHash, isHash2, isHash3, l, shadowed, uberscore, _lodash_;
        _lodash_ = require("lodash");
        uberscore = require("../uberscore");
        isHash = require("../types/isHash");
        isHash2 = require("../types/isHash");
        isHash3 = require("../types/isHash");
        l = new Logger("uberscore/Blender");
        shadowed = [ "constructor", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "toLocaleString", "toString", "valueOf" ];
        return deepExtend = function() {
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
                                if (isHash(obj[prop]) || isHash(source[prop])) {
                                    if (!isHash(obj[prop]) || !isHash(source[prop])) {
                                        throw "deepExtend: Error trying to combine a PlainObject with a non-PlainObject.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(obj[prop]) + "\nsource[prop]: " + l.prettify(source[prop]);
                                    } else {
                                        obj[prop] = deepExtend(obj[prop], source[prop]);
                                    }
                                } else {
                                    val = source[prop];
                                    if ((val === null || val === void 0) && isHash(obj)) {
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
    });
}).call(this);