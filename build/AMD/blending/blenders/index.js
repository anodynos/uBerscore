(function() {
    define([ "require", "exports", "module", "lodash", "../../agreement/isAgree", "./DeepCloneBlender", "./DeepExtendBlender", "./DeepDefaultsBlender", "./ArrayizeBlender" ], function(require, exports, module, _, isAgree) {
        module.exports = {
            DeepCloneBlender: require("./DeepCloneBlender"),
            DeepExtendBlender: require("./DeepExtendBlender"),
            DeepDefaultsBlender: require("./DeepDefaultsBlender"),
            ArrayizeBlender: require("./ArrayizeBlender")
        };
        return module.exports;
    });
}).call(this);