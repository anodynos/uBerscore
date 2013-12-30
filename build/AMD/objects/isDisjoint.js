(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var isDisjoint;
        isDisjoint = function(oa1, oa2, equality) {
            var found;
            if (equality == null) {
                equality = function(v1, v2) {
                    return v1 === v2;
                };
            }
            found = false;
            _.each(oa1, function(v1) {
                if (_.any(oa2, function(v2) {
                    return equality(v1, v2);
                })) {
                    found = true;
                    return false;
                }
            });
            return !found;
        };
        module.exports = isDisjoint;
        return module.exports;
    });
}).call(this);