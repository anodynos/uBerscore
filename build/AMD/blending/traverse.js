(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree", "./Blender" ], function(require, exports, module, _, isAgree) {
        var Blender, traverse;
        Blender = require("./Blender");
        traverse = function(data, callback) {
            var dummy, recurse, traverseBlender;
            dummy = {};
            recurse = true;
            traverseBlender = new Blender([ {
                order: [ "src" ],
                "[]": "traverse",
                "{}": "traverse",
                "->": "traverse",
                "*": Blender.SKIP,
                traverse: function(prop, src, dst, blender) {
                    if (this.read(src, prop) !== data) {
                        recurse = callback.call(this, prop, src, blender);
                    }
                    if (recurse !== false) {
                        this.blend(dummy, this.read(src, prop));
                    }
                    return this.SKIP;
                }
            } ], {
                debugLevel: 0
            });
            return traverseBlender.blend(dummy, data);
        };
        module.exports = traverse;
        return module.exports;
    });
}).call(this);