(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var go, __indexOf = [].indexOf || function(item) {
            for (var i = 0, l = this.length; i < l; i++) {
                if (i in this && this[i] === item) return i;
            }
            return -1;
        };
        go = function(oa, actions, context) {
            var arrItem, fixForObj, fltr, grab, isObj, iter, keysOrder, newOA, resetResult, result, resultPush, sort, _i, _len;
            if (actions) {
                fltr = actions.fltr, iter = actions.iter, sort = actions.sort, grab = actions.grab;
            }
            isObj = !_.isArray(oa);
            newOA = function() {
                if (isObj) {
                    return {};
                } else {
                    return [];
                }
            };
            oa = _.clone(oa);
            result = null;
            resetResult = function() {
                return result = grab === void 0 ? newOA() : _.isFunction(grab) ? newOA() : _.isArray(grab) ? [] : _.isObject(grab) ? {} : _.isString(grab) ? grab === "[]" || grab === "array" || grab === "Array" || grab === "a" || grab === "A" ? [] : grab === "{}" || grab === "object" || grab === "Object" || grab === "o" || grab === "O" ? {} : newOA() : newOA();
            };
            resultPush = function(val, key) {
                if (!_.isArray(result)) {
                    return result[key] = val;
                } else {
                    return result.push(val);
                }
            };
            fixForObj = function(val, key) {
                if (isObj) {
                    key = val;
                    val = oa[key];
                }
                return [ val, key ];
            };
            if (!(fltr === void 0)) {
                resetResult();
                _.each(oa, function(val, key) {
                    var f;
                    if (_.isFunction(fltr)) {
                        if (fltr.call(context, val, key, oa)) {
                            return resultPush(val, key);
                        }
                    } else {
                        if (isObj) {
                            if (_.isString(fltr)) {
                                fltr = [ fltr ];
                            }
                            if (_.isArray(fltr)) {
                                if (__indexOf.call(function() {
                                    var _i, _len, _results;
                                    _results = [];
                                    for (_i = 0, _len = fltr.length; _i < _len; _i++) {
                                        f = fltr[_i];
                                        _results.push(f.toString());
                                    }
                                    return _results;
                                }(), key) >= 0) {
                                    return resultPush(val, key);
                                }
                            }
                        }
                    }
                });
                oa = result;
            }
            if (!(sort === void 0)) {
                resetResult();
                keysOrder = [];
                _(oa).map(function(val, key) {
                    if (isObj) {
                        return key;
                    } else {
                        return val;
                    }
                }).sortBy(_.isFunction(sort) ? function(val, key) {
                    return sort.apply(context, fixForObj(val, key));
                } : _.isString(sort) ? function(val) {
                    return val;
                } : _.isBoolean(sort) ? sort ? function() {
                    return true;
                } : function() {
                    return false;
                } : sort).each(function(val, key) {
                    return resultPush.apply(null, fixForObj(val, key));
                });
                oa = result;
            }
            if (_.isFunction(iter)) {
                if (sort === void 0) {
                    _.each(oa, function(val, key) {
                        return iter.call(context, val, key, oa);
                    });
                } else {
                    _.each(oa, function(val, key) {
                        return iter.call(context, val, key, oa);
                    });
                }
            }
            if (grab) {
                if (_.isFunction(grab)) {
                    _.each(oa, function(val, key) {
                        return grab.call(context, val, key, oa);
                    });
                } else {
                    if (_.isArray(grab)) {
                        for (_i = 0, _len = oa.length; _i < _len; _i++) {
                            arrItem = oa[_i];
                            grab.push(arrItem);
                        }
                    } else {
                        if (_.isObject(grab)) {
                            _.extend(grab, oa);
                        }
                    }
                }
            }
            return oa;
        };
        module.exports = go;
        return module.exports;
    });
}).call(this);