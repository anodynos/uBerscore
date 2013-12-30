(function() {
    var __hasProp = {}.hasOwnProperty, __extends = function(child, parent) {
        for (var key in parent) {
            if (__hasProp.call(parent, key)) child[key] = parent[key];
        }
        function ctor() {
            this.constructor = child;
        }
        ctor.prototype = parent.prototype;
        child.prototype = new ctor();
        child.__super__ = parent.prototype;
        return child;
    };
    define([ "require", "../Blender", "lodash", "../../agreement/isAgree", "../../Logger" ], function(require, Blender, _, isAgree) {
        var DeepExtendBlender, l, _ref;
        l = new (require("../../Logger"))("uberscore/DeepExtendBlender");
        return DeepExtendBlender = function(_super) {
            __extends(DeepExtendBlender, _super);
            function DeepExtendBlender() {
                _ref = DeepExtendBlender.__super__.constructor.apply(this, arguments);
                return _ref;
            }
            DeepExtendBlender.behavior = {
                order: [ "src", "dst" ],
                String: {
                    "*": "overwriteOrReplace"
                },
                "[]": {
                    "[]": function(prop, src, dst) {
                        return _.reject(this.deepOverwrite(prop, src, dst), function(v) {
                            return v === null || v === void 0;
                        });
                    },
                    "*": function(prop, src, dst) {
                        throw "deepExtend: Error: Trying to combine an array with a non-array.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(dst[prop]) + "\nsource[prop]: " + l.prettify(src[prop]);
                    }
                },
                "{}": {
                    "{}": function(prop, src, dst) {
                        var deepBlended, key, val, _ref1;
                        _ref1 = deepBlended = this.getAction("deepOverwrite")(prop, src, dst);
                        for (key in _ref1) {
                            val = _ref1[key];
                            if (val === null || val === void 0) {
                                delete deepBlended[key];
                            }
                        }
                        return deepBlended;
                    },
                    "*": function(prop, src, dst) {
                        throw "deepExtend: Error trying to combine a PlainObject with a non-PlainObject.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(dst[prop]) + "\nsource[prop]: " + l.prettify(src[prop]);
                    }
                },
                overwriteOrReplace: function(prop, src, dst) {
                    var replaceRE;
                    replaceRE = /\${\s*?_\s*?}/;
                    if (_.isString(src[prop]) && replaceRE.test(src[prop])) {
                        if (_.isString(dst[prop])) {
                            return src[prop].replace(replaceRE, dst[prop]);
                        } else {
                            return dst[prop];
                        }
                    } else {
                        return src[prop];
                    }
                }
            };
            return DeepExtendBlender;
        }(Blender);
    });
}).call(this);