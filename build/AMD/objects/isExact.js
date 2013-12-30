(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree", "./isEqual" ], function(require, exports, module, _, isAgree) {
        var isEqual, isExact;
        isEqual = require("./isEqual");
        isExact = function(a, b, callback, ctx, options) {
            if (options == null) {
                options = {};
            }
            options.exact = true;
            return isEqual(a, b, callback, ctx, options);
        };
        module.exports = isExact;
        return module.exports;
    });
}).call(this);