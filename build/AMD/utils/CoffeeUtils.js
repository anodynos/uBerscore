(function() {
    define([ "require", "lodash", "../agreement/isAgree" ], function(require, _, isAgree) {
        var CoffeeUtils;
        return CoffeeUtils = function() {
            function CoffeeUtils() {}
            CoffeeUtils.prototype.getClasses = function(instOrClass, _classes) {
                if (_classes == null) {
                    _classes = [];
                }
                if (!instOrClass) {
                    instOrClass = this;
                }
                if (typeof instOrClass !== "function") {
                    instOrClass = instOrClass.constructor;
                }
                _classes.unshift(instOrClass);
                if (instOrClass.__super__) {
                    return this.getClasses(instOrClass.__super__.constructor, _classes);
                } else {
                    return _classes;
                }
            };
            CoffeeUtils.getClasses = CoffeeUtils.prototype.getClasses;
            return CoffeeUtils;
        }();
    });
}).call(this);