(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree", "./isEqual" ], function(require, exports, module, _, isAgree) {
        var isEqual, isIqual;
        isEqual = require("./isEqual");
        isIqual = function(a, b, callback, ctx, options) {
            if (options == null) {
                options = {};
            }
            options.inherited = true;
            (options.exclude || (options.exclude = [])).push("constructor");
            return isEqual(a, b, callback, ctx, options);
        };
        module.exports = isIqual;
        return module.exports;
    });
}).call(this);