(function() {
    var __indexOf = [].indexOf || function(item) {
        for (var i = 0, l = this.length; i < l; i++) {
            if (i in this && this[i] === item) return i;
        }
        return -1;
    };
    define([ "require", "../../types/type", "lodash", "../../agreement/isAgree", "../Blender" ], function(require, type, _, isAgree) {
        var DeepCloneBlender;
        return DeepCloneBlender = require("../Blender").subclass({}, {
            behavior: {
                order: [ "dst", "src" ],
                "*": {
                    "[]": "deepCloneOverwrite",
                    "{}": "deepCloneOverwrite",
                    "->": function(prop, src) {
                        return this.read(src, prop);
                    },
                    Undefined: function() {
                        return this.SKIP;
                    }
                },
                deepCloneOverwrite: function(prop, src, dst) {
                    var dstType, similarTypes, srcType;
                    srcType = type(this.read(src, prop));
                    dstType = type(this.read(dst, prop));
                    if (dstType !== srcType) {
                        similarTypes = [ "Function", "Object" ];
                        if (!(__indexOf.call(similarTypes, dstType) >= 0 && __indexOf.call(similarTypes, srcType) >= 0)) {
                            this.write(dst, prop, srcType === "Array" ? [] : {});
                        }
                    }
                    return this.deepOverwrite(prop, src, dst);
                }
            }
        });
    });
}).call(this);