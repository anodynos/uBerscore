(function() {
    var __isAMD = !!(typeof define === "function" && define.amd), __isNode = typeof exports === "object", __isWeb = !__isNode;
    define([ "require", "exports", "module", "lodash", "./agreement/isAgree", "./agreement/inAgreements", "./objects/setp", "./objects/getp" ], function(require, exports, module, _, isAgree) {
        var Logger, getp, inAgreements, setp, __slice = [].slice;
        inAgreements = require("./agreement/inAgreements");
        setp = require("./objects/setp");
        getp = require("./objects/getp");
        Logger = function() {
            var arrayizeDebugPath, countNewLines, getALog, key, val, _ref;
            function Logger(debugPath, debugLevel) {
                if (debugPath == null) {
                    debugPath = [];
                }
                this.debugLevel = debugLevel;
                this.setDebugPath(debugPath);
                Logger.loggerCount = (Logger.loggerCount || 0) + 1;
            }
            getALog = function(baseMsg, color, cons) {
                return function() {
                    var arg, args, err, i, newLines, retString, title, _i, _len;
                    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
                    if (_.isString(args[0])) {
                        newLines = countNewLines(args[0]);
                        args[0] = args[0].slice(newLines);
                    }
                    args = function() {
                        var _i, _len, _results;
                        _results = [];
                        for (_i = 0, _len = args.length; _i < _len; _i++) {
                            arg = args[_i];
                            _results.push(Logger.prettify(arg));
                        }
                        return _results;
                    }();
                    title = "" + (_.isEmpty(typeof this !== "undefined" && this !== null ? this.debugPath : void 0) ? "Logger" + Logger.loggerCount + " " : "[" + this.debugPath.join("/") + "] ") + baseMsg;
                    if (title) {
                        title = title + ":";
                    }
                    args.unshift(title);
                    if (!(typeof __isWeb !== "undefined" && __isWeb !== null && __isWeb)) {
                        args.unshift("" + color);
                    }
                    args.unshift(function() {
                        var _i, _results;
                        _results = [];
                        for (i = _i = 1; _i <= newLines; i = _i += 1) {
                            _results.push("\n");
                        }
                        return _results;
                    }().join(""));
                    if (!(typeof __isWeb !== "undefined" && __isWeb !== null && __isWeb)) {
                        args.push("[0m");
                    }
                    cons.apply(console, args);
                    try {
                        return args.join("");
                    } catch (_error) {
                        err = _error;
                        retString = "";
                        for (_i = 0, _len = args.length; _i < _len; _i++) {
                            arg = args[_i];
                            retString += Object.prototype.toString(arg);
                        }
                        return retString;
                    }
                };
            };
            countNewLines = function(str) {
                var newLines;
                newLines = 0;
                while (str[newLines] === "\n") {
                    newLines++;
                }
                return newLines;
            };
            arrayizeDebugPath = function(debugPath) {
                var path, _i, _len, _ref, _results;
                if (_.isString(debugPath)) {
                    _ref = debugPath.split("/");
                    _results = [];
                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        path = _ref[_i];
                        if (path) {
                            _results.push(path);
                        }
                    }
                    return _results;
                } else if (_.isUndefined(debugPath)) {
                    return [];
                } else if (_.isArray(debugPath)) {
                    return debugPath;
                } else {
                    return [ debugPath ];
                }
            };
            Logger.prototype.setDebugPath = function(debugPath) {
                return this.debugPath = arrayizeDebugPath(debugPath);
            };
            Logger.addDebugPathLevel = function(debugPath, debugLevel) {
                if (!_.isNaN(debugLevel * 1)) {
                    debugPath = _.clone(arrayizeDebugPath(debugPath));
                    debugPath.unshift("debugPathsLevels");
                    debugPath.push("_level");
                    return setp(Logger, debugPath, debugLevel * 1, {
                        create: true
                    });
                } else {
                    throw new Error("debugLevel '" + debugLevel + "' isNaN (Not a Number or not Number parsable)");
                }
            };
            Logger.prototype.getDebugPathLevel = function(levelPath) {
                var lastPath, levPaths, val;
                if (levelPath == null) {
                    levelPath = this.debugPath;
                }
                levPaths = _.clone(levelPath);
                val = getp(Logger.debugPathsLevels, levPaths);
                lastPath = levPaths.pop();
                while (_.isUndefined(val != null ? val._level : void 0) && lastPath) {
                    val = getp(Logger.debugPathsLevels, levPaths);
                    lastPath = levPaths.pop();
                }
                return val != null ? val._level : void 0;
            };
            Logger.prototype.isDebug = function(level) {
                var pathLevel;
                if (_.isNumber(Logger.maxDebugLevel)) {
                    if (level > Logger.maxDebugLevel) {
                        return false;
                    }
                }
                if (_.isNumber(this.debugLevel)) {
                    if (level > this.debugLevel) {
                        return false;
                    }
                } else {
                    if (_.isNumber(pathLevel = this.getDebugPathLevel())) {
                        if (level > pathLevel) {
                            return false;
                        }
                    } else {
                        if (level > 1) {
                            return false;
                        }
                    }
                }
                return true;
            };
            Logger.prototype.deb = function() {
                var debugLog;
                debugLog = getALog("DEBUG", "[35m", console.log);
                return function() {
                    var i, level, msgs, newLines, _ref;
                    level = arguments[0], msgs = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
                    if (_.isEmpty(msgs) && _.isNumber(level)) {
                        return this.isDebug(this.lastDebugLevelCheck = level);
                    }
                    if (!_.isNumber(level)) {
                        msgs.unshift(level);
                        level = (_ref = this.lastDebugLevelCheck) != null ? _ref : 1;
                        msgs.unshift(this.lastDebugLevelCheck ? "(?" + this.lastDebugLevelCheck + ")" : "(!1)");
                    } else {
                        msgs.unshift("(" + level + ")");
                    }
                    if (_.isString(msgs[1])) {
                        newLines = countNewLines(msgs[1]);
                        msgs[1] = msgs[1].slice(newLines);
                        msgs[0] = function() {
                            var _i, _results;
                            _results = [];
                            for (i = _i = 1; _i <= newLines; i = _i += 1) {
                                _results.push("\n");
                            }
                            return _results;
                        }().join("") + msgs[0];
                    }
                    delete this.lastDebugLevelCheck;
                    if (this.isDebug(level)) {
                        return debugLog.apply(this, msgs);
                    }
                };
            }();
            Logger.prototype.debug = Logger.prototype.deb;
            Logger.prettify = typeof __isNode !== "undefined" && __isNode !== null && __isNode ? function(inspect) {
                var nodeVerLE_092;
                nodeVerLE_092 = function() {
                    var i, v, x, _i, _len, _ref;
                    v = [];
                    _ref = process.version.slice(1).split(".");
                    for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
                        x = _ref[i];
                        v[i] = x * 1;
                    }
                    if (v[0] > 0 || v[1] > 9) {
                        return false;
                    } else {
                        if (v[1] === 9) {
                            if (v[2] <= 2) {
                                return true;
                            } else {
                                return false;
                            }
                        } else {
                            return true;
                        }
                    }
                }();
                return function(o) {
                    var pretty;
                    pretty = nodeVerLE_092 ? "[0m" + inspect(o, false, null, true) : "[0m" + inspect(o, {
                        showHidden: false,
                        depth: null,
                        colors: true
                    });
                    if (_.isArray(o)) {
                        pretty.replace(/\n/g, "");
                    }
                    if (inAgreements(o, [ _.isObject, _.isRegExp ])) {
                        return pretty;
                    } else {
                        return o;
                    }
                };
            }(require("util").inspect) : function(o) {
                return o;
            };
            Logger.prototype.prettify = Logger.prettify;
            Logger.prototype.err = getALog("ERROR", "[31m", console.error);
            Logger.prototype.er = getALog("ERRor", "[31m", console.log);
            Logger.prototype.warn = getALog("WARNING", "[33m", console.log);
            Logger.prototype.verbose = getALog("", "[36m", console.log);
            Logger.prototype.ver = Logger.prototype.verbose;
            Logger.prototype.ok = getALog("", "[32m", console.log);
            Logger.prototype.log = getALog("", "[0m", console.log);
            Logger.logger = new Logger("DefaultLogger");
            _ref = Logger.prototype;
            for (key in _ref) {
                val = _ref[key];
                if (_.isFunction(val)) {
                    Logger[key] = _.bind(val, Logger.logger);
                } else {
                    Logger[key] = val;
                }
            }
            return Logger;
        }();
        module.exports = Logger;
        return module.exports;
    });
}).call(this);