(function() {
    define([ "require", "lodash", "../agreement/isAgree" ], function(require, _, isAgree) {
        return function(val) {
            return _.isEqual(val, false);
        };
    });
}).call(this);