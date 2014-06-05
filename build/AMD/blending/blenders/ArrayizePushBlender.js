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
    }, __indexOf = [].indexOf || function(item) {
        for (var i = 0, l = this.length; i < l; i++) {
            if (i in this && this[i] === item) return i;
        }
        return -1;
    };
    define([ "require", "exports", "module", "../../collections/array/arrayize", "lodash", "../../agreement/isAgree", "./DeepCloneBlender" ], function(require, exports, module, arrayize, _, isAgree) {
        var ArrayizePushBlender;
        return ArrayizePushBlender = function(_super) {
            __extends(ArrayizePushBlender, _super);
            function ArrayizePushBlender() {
                return ArrayizePushBlender.__super__.constructor.apply(this, arguments);
            }
            ArrayizePushBlender.behavior = {
                order: [ "src" ],
                unique: false,
                "*": "pushToArray",
                pushToArray: function(prop, src, dst) {
                    var dstArray, itemsToPush, srcArray, v, _i, _len;
                    dstArray = this.write(dst, prop, arrayize(this.read(dst, prop)));
                    srcArray = arrayize(this.read(src, prop));
                    if (_.isEqual(srcArray[0], [ null ])) {
                        dstArray = this.write(dst, prop, []);
                        srcArray = srcArray.slice(1);
                    }
                    itemsToPush = this.unique ? function() {
                        var _i, _len, _results;
                        _results = [];
                        for (_i = 0, _len = srcArray.length; _i < _len; _i++) {
                            v = srcArray[_i];
                            if (__indexOf.call(dstArray, v) < 0) {
                                _results.push(v);
                            }
                        }
                        return _results;
                    }() : srcArray;
                    for (_i = 0, _len = itemsToPush.length; _i < _len; _i++) {
                        v = itemsToPush[_i];
                        dstArray.push(v);
                    }
                    return dstArray;
                }
            };
            return ArrayizePushBlender;
        }(require("./DeepCloneBlender"));
    });
}).call(this);