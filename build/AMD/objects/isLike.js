(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree", "./isEqual" ], function(require, exports, module, _, isAgree) {
        var isEqual, isLike;
        isEqual = require("./isEqual");
        isLike = function(a, b, callback, ctx, options) {
            if (options == null) {
                options = {};
            }
            options.like = true;
            return isEqual(a, b, callback, ctx, options);
        };
        module.exports = isLike;
        return module.exports;
    });
}).call(this);