// Generated by uRequire v0.3.0alpha22
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('Logger', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree', './agreement/inAgreements'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var Logger, inAgreements, _, __slice = [].slice;

_ = require("lodash");

inAgreements = require("./agreement/inAgreements");

Logger = function() {
    var key, val, _ref;
    Logger.debugLevel = 0;
    Logger.prototype.VERSION = typeof VERSION !== "undefined" && VERSION !== null ? VERSION : "{NO_VERSION}";
    function Logger(title, debugLevel, newLine) {
        this.title = title;
        this.debugLevel = debugLevel != null ? debugLevel : 0;
        this.newLine = newLine != null ? newLine : true;
        Logger.loggerCount = (Logger.loggerCount || 0) + 1;
    }
    Logger.getALog = function(baseMsg, color, cons) {
        return function() {
            var arg, args, retString, title, _i, _len;
            args = function() {
                var _i, _len, _ref, _results;
                _ref = Array.prototype.slice.call(arguments);
                _results = [];
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    arg = _ref[_i];
                    _results.push(this.prettify(arg));
                }
                return _results;
            }.apply(this, arguments);
            title = "" + (!this.title ? "Logger" + Logger.loggerCount + " " : "[" + this.title + "] ") + baseMsg;
            if (title) {
                title = title + ":";
            }
            args.unshift(title);
            if (!(typeof __isWeb !== "undefined" && __isWeb !== null && __isWeb)) {
                args.unshift("" + color);
            }
            if (this.newLine) {
                args.unshift("\n");
            }
            if (!(typeof __isWeb !== "undefined" && __isWeb !== null && __isWeb)) {
                args.push("[0m");
            }
            cons.apply(null, args);
            try {
                return args.join("");
            } catch (err) {
                retString = "";
                for (_i = 0, _len = args.length; _i < _len; _i++) {
                    arg = args[_i];
                    retString += Object.prototype.toString(arg);
                }
                return retString;
            }
        };
    };
    Logger.prototype.err = Logger.getALog("ERROR", "[31m", console.error);
    Logger.prototype.log = Logger.getALog("", "[0m", console.log);
    Logger.prototype.verbose = Logger.getALog("", "[34m", console.log);
    Logger.prototype.ok = Logger.getALog("", "[32m", console.log);
    Logger.prototype.warn = Logger.getALog("WARNING", "[33m", console.log);
    Logger.prototype.debug = function() {
        var log;
        log = Logger.getALog("DEBUG", "[36m", console.log);
        return function() {
            var level, msgs;
            level = arguments[0], msgs = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
            if (_.isString(level)) {
                msgs.unshift(level);
                msgs.unshift("(-)");
                level = 1;
            } else {
                msgs.unshift("(" + level + ")");
            }
            if (Logger.debugLevel >= 0 && level <= (this === Logger.logger || this.debugLevel === void 0 ? Logger.debugLevel : this.debugLevel) || Logger.debugLevel >= 999) {
                return log.apply(this, msgs);
            }
        };
    }();
    Logger.prototype.prettify = typeof __isNode !== "undefined" && __isNode !== null && __isNode || !(typeof __isNode !== "undefined" && __isNode !== null) ? function(inspect) {
        return function(o) {
            var pretty;
            pretty = "[0m" + inspect(o, false, null, true);
            if (_.isArray(o)) {
                pretty.replace(/\n/g, "");
            }
            if (inAgreements(o, [ _.isObject ])) {
                return pretty;
            } else {
                return o;
            }
        };
    }(require("util").inspect) : function(o) {
        return o;
    };
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
// uRequire: end body of original nodejs module


return module.exports;
})
})();