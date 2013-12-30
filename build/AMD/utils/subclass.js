(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var subclass;
        subclass = module.exports = function(protoProps, staticProps) {
            var Surrogate, child, parent;
            parent = this;
            child = void 0;
            if (protoProps && _.has(protoProps, "constructor")) {
                child = protoProps.constructor;
            } else {
                child = function() {
                    return parent.apply(this, arguments);
                };
            }
            _.extend(child, parent, staticProps);
            Surrogate = function() {
                this.constructor = child;
                return this;
            };
            Surrogate.prototype = parent.prototype;
            child.prototype = new Surrogate();
            if (protoProps) {
                _.extend(child.prototype, protoProps);
            }
            child.__super__ = parent.prototype;
            return child;
        };
        return module.exports;
    });
}).call(this);