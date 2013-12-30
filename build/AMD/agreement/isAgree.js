(function() {
    define([ "require", "lodash" ], function(require, _) {
        return function(o, agreement) {
            if (_.isRegExp(agreement)) {
                return agreement.test(o + "");
            } else {
                if (_.isFunction(agreement)) {
                    return agreement(o);
                } else {
                    if (agreement === void 0) {
                        return true;
                    } else {
                        if (_.isEqual(o, agreement)) {
                            return true;
                        } else {
                            return o + "" === agreement + "";
                        }
                    }
                }
            }
        };
    });
}).call(this);