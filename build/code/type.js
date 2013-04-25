// Generated by uRequire v0.3.0alpha23
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('type', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('./agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', './agreement/isAgree'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var type, _, __indexOf = [].indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
        if (i in this && this[i] === item) return i;
    }
    return -1;
};

_ = require("lodash");

type = function(o, isShort) {
    var long, shorts, _ref;
    if (isShort == null) {
        isShort = false;
    }
    _ref = type.TYPES;
    for (long in _ref) {
        shorts = _ref[long];
        if (_["is" + long](o)) {
            if (isShort) {
                return shorts[0];
            } else {
                return long;
            }
        }
    }
    return "UNKNOWN";
};

type.toShort = function(aType) {
    var longType, shorts, _ref;
    if (type.TYPES[aType]) {
        return type.TYPES[aType][0];
    } else {
        _ref = type.TYPES;
        for (longType in _ref) {
            shorts = _ref[longType];
            if (__indexOf.call(shorts, aType) >= 0) {
                return shorts[0];
            }
        }
    }
};

type.toLong = function(aType) {
    var longType, shorts, _ref;
    if (type.TYPES[aType]) {
        return aType;
    } else {
        _ref = type.TYPES;
        for (longType in _ref) {
            shorts = _ref[longType];
            if (__indexOf.call(shorts, aType) >= 0) {
                return longType;
            }
        }
    }
};

type.areEqual = function(aType, bType) {
    return type.toShort(aType) === type.toShort(bType);
};

type.isType = function(aType) {
    var _ref;
    return _ref = type.toLong(aType), __indexOf.call(_.keys(type.TYPES), _ref) >= 0;
};

type.TYPES = {
    Arguments: [ "args", ".." ],
    Array: [ "[]", "A" ],
    Function: [ "->", "F" ],
    String: [ "''", "S", '""' ],
    Date: [ "D" ],
    RegExp: [ "//", "R" ],
    Number: [ "N" ],
    Boolean: [ "B" ],
    Object: [ "{}", "O" ],
    Null: [ "null", "-" ],
    Undefined: [ "U", "?" ]
};

module.exports = type;
// uRequire: end body of original nodejs module


return module.exports;
})
})();