// Generated by uRequire v0.4.0
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/isEqual', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree', '../type', '../isPlain', '../collections/array/isEqualArraySet', '../Logger'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var isEqual, isEqualArraySet, isEqualDefaults, isPlain, l, type, _, __indexOf = [].indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
        if (i in this && this[i] === item) return i;
    }
    return -1;
}, __hasProp = {}.hasOwnProperty;

_ = require("lodash");

type = require("../type");

isPlain = require("../isPlain");

isEqualArraySet = require("../collections/array/isEqualArraySet");

l = new (require("../Logger"))("uberscore/isEqual", 0);

isEqualDefaults = {
    inherited: false,
    exact: false,
    exclude: [ "constructor" ],
    functionAsObject: false,
    allKeys: false
};

isEqual = function(a, b, callback, thisArg, options) {
    var aKeys, aType, bKeys, bType, cbResult, p, prop, _i, _j, _len, _len1, _ref;
    if (options == null) {
        options = isEqualDefaults;
    }
    if (_.isPlainObject(callback) && _.isUndefined(thisArg) && options === isEqualDefaults) {
        options = _.clone(options, true);
        _ref = _.keys(isEqualDefaults);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            p = _ref[_i];
            options[p] || (options[p] = callback[p]);
        }
    }
    if (options.callback) {
        callback = options.callback;
    }
    if (options.thisArg) {
        thisArg = options.thisArg;
    }
    if (options !== isEqualDefaults) {
        _.defaults(options, isEqualDefaults);
    }
    if (_.isFunction(callback)) {
        cbResult = callback.apply(thisArg, [ a, b ]);
        if (cbResult !== void 0) {
            return cbResult ? true : false;
        }
    } else {
        callback = void 0;
    }
    if (l.deb(20)) {
        l.debug("options = ", options);
    }
    aType = type(a);
    bType = type(b);
    if (!(options.exact || options.inherited) && (_.isObject(a) || _.isObject(b))) {
        if (_.isEqual(a, b, callback, thisArg)) {
            if (l.deb(40)) {
                l.debug("return true - non exact _.isEqual");
            }
            return true;
        }
    }
    if (a === b) {
        if (l.deb(40)) {
            l.debug("return true - a is b");
        }
        return true;
    } else {
        if (isPlain(a) || isPlain(b) || _.isFunction(a) || _.isFunction(b)) {
            if (l.deb(40)) {
                l.debug("return  _.isEqual a, b");
            }
            return _.isEqual(a, b);
        }
    }
    if (options.inherited || options.exact) {
        if (options.inherited) {
            aKeys = function() {
                var _results;
                _results = [];
                for (p in a) {
                    if (__indexOf.call(options.exclude, p) < 0) {
                        _results.push(p);
                    }
                }
                return _results;
            }();
            bKeys = function() {
                var _results;
                _results = [];
                for (p in b) {
                    if (__indexOf.call(options.exclude, p) < 0) {
                        _results.push(p);
                    }
                }
                return _results;
            }();
        } else {
            aKeys = function() {
                var _results;
                _results = [];
                for (p in a) {
                    if (!__hasProp.call(a, p)) continue;
                    if (__indexOf.call(options.exclude, p) < 0) {
                        _results.push(p);
                    }
                }
                return _results;
            }();
            bKeys = function() {
                var _results;
                _results = [];
                for (p in b) {
                    if (!__hasProp.call(b, p)) continue;
                    if (__indexOf.call(options.exclude, p) < 0) {
                        _results.push(p);
                    }
                }
                return _results;
            }();
        }
        if (aKeys.length !== bKeys.length || !isEqualArraySet(aKeys, bKeys)) {
            return false;
        }
        for (_j = 0, _len1 = aKeys.length; _j < _len1; _j++) {
            prop = aKeys[_j];
            if (options.exact) {
                if (a[prop] !== b[prop]) {
                    if (l.deb(40)) {
                        l.debug("return false - exact ref not same");
                    }
                    return false;
                }
            }
            if (!_.isEqual(a[prop], b[prop], callback, thisArg)) {
                if (!isEqual(a[prop], b[prop], callback, thisArg, options)) {
                    if (l.deb(40)) {
                        l.debug("return false - not isEqual nested for prop =", prop, "values = ", a[prop], b[prop]);
                    }
                    return false;
                }
            }
        }
        if (l.deb(40)) {
            l.debug("return true - all properties considered true");
        }
        return true;
    }
    if (l.deb(40)) {
        l.debug("return false - nothing left to check!");
    }
    return false;
};

module.exports = isEqual;
// uRequire: end body of original nodejs module


return module.exports;
})
})();