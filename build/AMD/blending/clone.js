(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree", "./blenders/DeepCloneBlender" ], function(require, exports, module, _, isAgree) {
        var DeepCloneBlender, clone;
        DeepCloneBlender = require("./blenders/DeepCloneBlender");
        clone = function(obj, options) {
            if (!options) {
                return _.clone(obj, options);
            } else {
                if (!(options === true || options.deep)) {
                    return new DeepCloneBlender([ {
                        "*": {
                            "*": "overwrite"
                        }
                    } ], options).blend(obj);
                } else {
                    return new DeepCloneBlender([], options).blend(obj);
                }
            }
        };
        module.exports = clone;
        return module.exports;
    });
}).call(this);