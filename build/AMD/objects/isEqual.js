(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree", "../types/type", "../types/isPlain", "../types/isHash", "../collections/array/isEqualArraySet", "../Logger" ], function(require, exports, module, _, isAgree) {
        var getProps, isEqual, isEqualArraySet, isHash, isPlain, l, type;
        type = require("../types/type");
        isPlain = require("../types/isPlain");
        isHash = require("../types/isHash");
        isEqualArraySet = require("../collections/array/isEqualArraySet");
        l = new (require("../Logger"))("uberscore/isEqual");
        isEqual = function(a, b, callback, ctx, options) {
            var aKeys, bKeys, cb, cbResult, isValueType, key, prop, _i, _len;
            if (options == null) {
                options = isEqual.defaults;
            }
            if (isHash(callback)) {
                options = _.defaults(callback, options);
            }
            if (options !== isEqual.defaults) {
                _.defaults(options || (options = {}), isEqual.defaults);
            }
            if (options.callback) {
                callback = options.callback;
            }
            if (options.ctx) {
                ctx = options.ctx;
            }
            if (_.isFunction(callback)) {
                if (!callback.optioned) {
                    cb = callback;
                    callback = function(a, b) {
                        return cb.call(this, a, b, options);
                    };
                    callback.optioned = true;
                    if (options.callback) {
                        options.callback = callback;
                    }
                }
                cbResult = callback.call(ctx, a, b);
                if (cbResult !== void 0) {
                    return cbResult ? true : false;
                }
            } else {
                callback = void 0;
                options.callback = void 0;
            }
            if (l.deb(20)) {
                l.debug("options = ", options);
            }
            if (a === b) {
                if (l.deb(40)) {
                    l.debug("return true - a is b");
                }
                return true;
            }
            if (_.isFunction(a != null ? a.isEqual : void 0)) {
                return a.isEqual(b);
            }
            if (_.isFunction(b != null ? b.isEqual : void 0)) {
                return b.isEqual(a);
            }
            if (_.isEqual(isEqual.defaults, _.pick(options, _.keys(isEqual.defaults)))) {
                if (l.deb(40)) {
                    l.debug("return _.isEqual a, b - no _B.isEqual options");
                }
                return _.isEqual(a, b, callback, ctx);
            }
            if (!(options.onlyProps && _.isObject(b) && (_.isObject(a) || options.like))) {
                if (type(a) !== type(b)) {
                    if (l.deb(40)) {
                        l.debug("return false - type(a) isnt type(b) and not options.onlyProps");
                    }
                    return false;
                }
                isValueType = function(x) {
                    return isPlain(x) || _.isFunction(x);
                };
                if (isValueType(a) || isValueType(b)) {
                    if (!_.isEqual(a, b, callback, ctx)) {
                        return false;
                    } else {
                        if (!options.allProps) {
                            return true;
                        }
                    }
                }
            }
            aKeys = getProps(a, options);
            bKeys = getProps(b, options);
            if (!options.like) {
                if (aKeys.length !== bKeys.length || !isEqualArraySet(aKeys, bKeys)) {
                    if (_.isArray(options.path)) {
                        if (!(key = _.difference(aKeys, bKeys)[0])) {
                            key = _.difference(bKeys, aKeys)[0];
                        }
                        options.path.push(key);
                    }
                    return false;
                }
            }
            for (_i = 0, _len = aKeys.length; _i < _len; _i++) {
                prop = aKeys[_i];
                if (_.isArray(options.path)) {
                    options.path.push(prop);
                }
                if (options.exact) {
                    if (a[prop] !== b[prop]) {
                        if (l.deb(40)) {
                            l.debug("return false - exact ref not same");
                        }
                        return false;
                    }
                }
                if (!isEqual(a[prop], b[prop], callback, ctx, options)) {
                    if (l.deb(40)) {
                        l.debug("return false - not isEqual nested for prop =", prop, "values = ", a[prop], b[prop]);
                    }
                    return false;
                }
                if (_.isArray(options.path)) {
                    options.path.pop();
                }
            }
            if (l.deb(40)) {
                l.debug("return true - all properties considered true");
            }
            return true;
        };
        isEqual.defaults = {
            inherited: false,
            exact: false,
            like: false,
            path: void 0,
            exclude: [],
            allProps: false,
            onlyProps: false
        };
        getProps = function(oa, options) {
            var i, isExcluded, pi, _i, _ref, _results, _results1;
            if (options == null) {
                options = {};
            }
            isExcluded = function(prop) {
                return _.any(options.exclude, function(p) {
                    return p + "" === prop + "";
                });
            };
            if (_.isArray(oa) && !(options.allProps || options.onlyProps)) {
                _results = [];
                for (i = _i = 0, _ref = oa.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
                    if (!isExcluded(i)) {
                        _results.push(i);
                    }
                }
                return _results;
            } else {
                _results1 = [];
                for (pi in oa) {
                    if (!isExcluded(pi) && (options.inherited || {}.hasOwnProperty.call(oa, pi))) {
                        _results1.push(pi);
                    }
                }
                return _results1;
            }
        };
        module.exports = isEqual;
        return module.exports;
    });
}).call(this);