(function() {
    define([ "require", "exports", "module", "lodash", "./isAgree", "../collections/array/arrayize" ], function(require, exports, module, _, isAgree) {
        var arrayize;
        arrayize = require("../collections/array/arrayize");
        module.exports = function(o, agreements) {
            var agr, _i, _len;
            agreements = arrayize(agreements);
            if (_.isEmpty(agreements)) {
                return false;
            } else {
                for (_i = 0, _len = agreements.length; _i < _len; _i++) {
                    agr = agreements[_i];
                    if (isAgree(o, agr)) {
                        return true;
                    }
                }
            }
            return false;
        };
        return module.exports;
    });
}).call(this);