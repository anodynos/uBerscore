(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var getInheritedPropertyNames, _getInheritedPropertyNames;
        getInheritedPropertyNames = function(obj) {
            return _getInheritedPropertyNames(Object.getPrototypeOf(obj));
        };
        _getInheritedPropertyNames = function(obj) {
            var props;
            props = [];
            while (true) {
                if (!obj || obj === void 0 || _.isEmpty(obj) && !Object.getPrototypeOf(obj)) {
                    break;
                }
                Object.getOwnPropertyNames(obj).forEach(function(prop) {
                    if (props.indexOf(prop) === -1 && prop !== "constructor") {
                        return props.push(prop);
                    }
                });
                obj = Object.getPrototypeOf(obj);
            }
            return props;
        };
        module.exports = getInheritedPropertyNames;
        return module.exports;
    });
}).call(this);