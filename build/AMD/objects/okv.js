(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var okv, __slice = [].slice;
        okv = function() {
            var idx, keyName, keyValPairs, obj, _i, _len;
            obj = arguments[0], keyValPairs = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
            if (_.isString(obj)) {
                keyValPairs.unshift(obj);
                obj = {};
            }
            if (_.isObject(obj)) {
                for (idx = _i = 0, _len = keyValPairs.length; _i < _len; idx = _i += 2) {
                    keyName = keyValPairs[idx];
                    if (idx + 1 < keyValPairs.length) {
                        obj[keyName + ""] = keyValPairs[idx + 1];
                    }
                }
                return obj;
            } else {
                return null;
            }
        };
        module.exports = okv;
        return module.exports;
    });
}).call(this);