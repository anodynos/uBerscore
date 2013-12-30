(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var getRefs, getRefsDefaults, __hasProp = {}.hasOwnProperty;
        getRefsDefaults = {
            deep: false,
            inherited: false
        };
        getRefs = function(oa, options, refsArray) {
            var key, keys, v, _i, _len;
            if (options == null) {
                options = getRefsDefaults;
            }
            if (refsArray == null) {
                refsArray = [];
            }
            if (options !== getRefsDefaults) {
                _.defaults(options, getRefsDefaults);
            }
            keys = options.inherited ? function() {
                var _results;
                _results = [];
                for (key in oa) {
                    _results.push(key);
                }
                return _results;
            }() : function() {
                var _results;
                _results = [];
                for (key in oa) {
                    if (!__hasProp.call(oa, key)) continue;
                    _results.push(key);
                }
                return _results;
            }();
            for (_i = 0, _len = keys.length; _i < _len; _i++) {
                key = keys[_i];
                v = oa[key];
                if (_.isObject(v)) {
                    refsArray.push(v);
                    if (options.deep) {
                        getRefs(v, options, refsArray);
                    }
                }
            }
            return refsArray;
        };
        module.exports = getRefs;
        return module.exports;
    });
}).call(this);