(function() {
    define([ "require", "../../types/type", "./DeepCloneBlender", "lodash", "../../agreement/isAgree" ], function(require, type, DeepCloneBlender, _, isAgree) {
        var DeepDefaultsBlender;
        return DeepDefaultsBlender = DeepCloneBlender.subclass({}, {
            behavior: {
                order: [ "dst", "src" ],
                Undefined: function() {
                    return this.NEXT;
                },
                Null: function() {
                    return this.NEXT;
                },
                "{}": {
                    "{}": function() {
                        return this.NEXT;
                    },
                    "->": function() {
                        return this.NEXT;
                    },
                    "*": function() {
                        return this.SKIP;
                    }
                },
                "->": {
                    "{}": function() {
                        return this.NEXT;
                    },
                    "->": function() {
                        return this.NEXT;
                    },
                    "*": function() {
                        return this.SKIP;
                    }
                },
                "[]": {
                    "[]": function() {
                        return this.NEXT;
                    },
                    "*": function() {
                        return this.SKIP;
                    }
                },
                "*": function() {
                    return this.SKIP;
                }
            }
        });
    });
}).call(this);