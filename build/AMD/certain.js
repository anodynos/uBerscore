(function() {
    define([ "require", "exports", "module", "lodash", "./agreement/isAgree", "./types/isHash" ], function(require, exports, module, _, isAgree) {
        var certain, isHash;
        isHash = require("./types/isHash");
        certain = function(o, defaultKey, defaultVal, isStrict) {
            if (isStrict == null) {
                isStrict = false;
            }
            if (!(isHash(o) || _.isFunction(o))) {
                throw "Error: _B.certain: o is neither an Object or Function.\no=" + JSON.stringify(o, null, "");
            }
            if (_.isUndefined(defaultKey)) {
                defaultKey = "*";
            }
            return function(key) {
                var val, _ref, _ref1;
                val = (_ref = (_ref1 = o[key]) != null ? _ref1 : o[defaultKey]) != null ? _ref : defaultVal;
                if (isStrict && _.isUndefined(val)) {
                    throw "Error: _B.certain: defaultKey is undefined.\n  defaultVal is also undefined.\n  key='" + key + "' (o[" + key + "] is obviously undefined too)\n  defaultKey='" + defaultKey + "'\n  o=" + JSON.stringify(o, null, "");
                }
                return val;
            };
        };
        module.exports = certain;
        return module.exports;
    });
}).call(this);