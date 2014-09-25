(function() {
    define([ "require", "exports", "module", "lodash", "../../agreement/isAgree", "./DeepCloneBlender", "./DeepExtendBlender", "./DeepDefaultsBlender", "./ArrayizePushBlender" ], function(require, exports, module, _, isAgree) {
        module.exports = {
            DeepCloneBlender: require("./DeepCloneBlender"),
            DeepExtendBlender: require("./DeepExtendBlender"),
            DeepDefaultsBlender: require("./DeepDefaultsBlender"),
            ArrayizePushBlender: require("./ArrayizePushBlender")
        };
        return module.exports;
    });
}).call(this);