(function() {
    define([ "require", "exports", "module", "lodash", "../../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var isAgree, arrayize;
        isAgree = require("../../agreement/isAgree");
        arrayize = function(item) {
            if (_.isArray(item)) {
                return item;
            } else {
                if (_.isUndefined(item) || _.isNull(item)) {
                    return [];
                } else {
                    return [ item ];
                }
            }
        };
        module.exports = arrayize;
        return module.exports;
    });
}).call(this);