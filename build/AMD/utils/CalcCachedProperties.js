(function() {
    var __hasProp = {}.hasOwnProperty, __extends = function(child, parent) {
        for (var key in parent) {
            if (__hasProp.call(parent, key)) child[key] = parent[key];
        }
        function ctor() {
            this.constructor = child;
        }
        ctor.prototype = parent.prototype;
        child.prototype = new ctor();
        child.__super__ = parent.prototype;
        return child;
    }, __slice = [].slice;
    define([ "require", "./CoffeeUtils", "lodash", "../agreement/isAgree", "../Logger" ], function(require, CoffeeUtils, _, isAgree) {
        var CalcCachedProperties, l;
        l = new (require("../Logger"))("uberscore/utils/CalcCachedProperties");
        return CalcCachedProperties = function(_super) {
            var cUndefined, cacheKey, prefix;
            __extends(CalcCachedProperties, _super);
            prefix = function(prop) {
                return "__$$" + prop + "__$$";
            };
            cacheKey = prefix("cache");
            cUndefined = {
                cUndefined: true
            };
            CalcCachedProperties.prototype.getAllCalcProperties = function(instOrClass) {
                var aClass, cFunct, cProp, calcProps, _i, _len, _ref, _ref1;
                if (instOrClass == null) {
                    instOrClass = this;
                }
                calcProps = {};
                _ref = this.getClasses(instOrClass);
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    aClass = _ref[_i];
                    _ref1 = aClass.calcProperties;
                    for (cProp in _ref1) {
                        cFunct = _ref1[cProp];
                        calcProps[cProp] = cFunct;
                    }
                }
                return calcProps;
            };
            CalcCachedProperties.getAllCalcProperties = CalcCachedProperties.prototype.getAllCalcProperties;
            Object.defineProperties(CalcCachedProperties.prototype, {
                allCalcProperties: {
                    get: function() {
                        if (!this.constructor.prototype.hasOwnProperty("_allCalcProperties")) {
                            Object.defineProperty(this.constructor.prototype, "_allCalcProperties", {
                                value: this.getAllCalcProperties(),
                                enumerable: false
                            });
                        }
                        return this.constructor.prototype._allCalcProperties;
                    }
                },
                classes: {
                    get: function() {
                        if (!this.constructor.prototype.hasOwnProperty("_classes")) {
                            Object.defineProperty(this.constructor.prototype, "_classes", {
                                value: this.getClasses(),
                                enumerable: false
                            });
                        }
                        return this.constructor.prototype._classes;
                    }
                }
            });
            function CalcCachedProperties() {
                this.defineCalcProperties();
            }
            CalcCachedProperties.prototype.defineCalcProperties = function(isOverwrite) {
                var cPropFn, cPropName, _ref;
                Object.defineProperty(this, cacheKey, {
                    value: {},
                    enumerable: false,
                    configurable: false,
                    writeable: false
                });
                _ref = this.allCalcProperties;
                for (cPropName in _ref) {
                    cPropFn = _ref[cPropName];
                    this[cacheKey][cPropName] = cUndefined;
                    if (!this.constructor.prototype.hasOwnProperty(cPropName) || isOverwrite) {
                        (function(_this) {
                            return function(cPropName, cPropFn) {
                                if (l.deb(99)) {
                                    l.debug("...defining calculated property " + _this.constructor.name + "." + cPropName);
                                }
                                return Object.defineProperty(_this.constructor.prototype, cPropName, {
                                    enumerable: true,
                                    configurable: true,
                                    get: function() {
                                        if (l.deb(99)) {
                                            l.debug("...requesting calculated property " + this.constructor.name + "." + cPropName);
                                        }
                                        if (this[cacheKey][cPropName] === cUndefined) {
                                            if (l.deb(95)) {
                                                l.debug("...refreshing calculated property " + this.constructor.name + "." + cPropName);
                                            }
                                            this[cacheKey][cPropName] = cPropFn.call(this);
                                        }
                                        return this[cacheKey][cPropName];
                                    },
                                    set: function(v) {
                                        return this[cacheKey][cPropName] = v;
                                    }
                                });
                            };
                        })(this)(cPropName, cPropFn);
                    }
                }
                return null;
            };
            CalcCachedProperties.prototype.cleanProps = function() {
                var ca, cleanArgs, cleaned, p, propKeys, _i, _j, _len, _len1;
                cleanArgs = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
                if (_.isEmpty(cleanArgs)) {
                    cleanArgs = _.keys(this.allCalcProperties);
                }
                cleaned = [];
                for (_i = 0, _len = cleanArgs.length; _i < _len; _i++) {
                    ca = cleanArgs[_i];
                    if (ca) {
                        if (_.isFunction(ca)) {
                            if (!propKeys) {
                                propKeys = _.keys(this.allCalcProperties);
                            }
                            for (_j = 0, _len1 = propKeys.length; _j < _len1; _j++) {
                                p = propKeys[_j];
                                if (ca(p)) {
                                    if (this[cacheKey][p] !== cUndefined) {
                                        if (l.deb(100)) {
                                            l.debug("...delete (via fn) value of property " + this.constructor.name + "." + p);
                                        }
                                        this[cacheKey][p] = cUndefined;
                                        cleaned.push(p);
                                    }
                                }
                            }
                        } else {
                            if (this[cacheKey][ca] !== cUndefined) {
                                if (l.deb(100)) {
                                    l.debug("...delete value of property " + this.constructor.name + "." + ca);
                                }
                                this[cacheKey][ca] = cUndefined;
                                cleaned.push(ca);
                            }
                        }
                    }
                }
                return cleaned;
            };
            return CalcCachedProperties;
        }(CoffeeUtils);
    });
}).call(this);