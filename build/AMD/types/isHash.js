(function() {
    define([ "require", "./type", "lodash", "../agreement/isAgree" ], function(require, type, _, isAgree) {
        return function(o) {
            return type(o) === "Object";
        };
    });
}).call(this);