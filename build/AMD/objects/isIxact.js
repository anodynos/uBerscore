(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree", "./isIqual" ], function(require, exports, module, _, isAgree) {
        var isIqual, isIxact;
        isIqual = require("./isIqual");
        isIxact = function(a, b, callback, ctx, options) {
            if (options == null) {
                options = {};
            }
            options.exact = true;
            return isIqual(a, b, callback, ctx, options);
        };
        module.exports = isIxact;
        return module.exports;
    });
}).call(this);