(function() {
    define([ "require", "exports", "module", "lodash", "../agreement/isAgree" ], function(require, exports, module, _, isAgree) {
        var defaultOptions, setp;
        defaultOptions = {
            separator: "/",
            create: true,
            overwrite: false
        };
        setp = function(o, path, val, options) {
            var newObj, p, pi, _i, _len;
            if (options == null) {
                options = defaultOptions;
            }
            if (options !== defaultOptions) {
                _.defaults(options, defaultOptions);
            }
            if (!_.isArray(path)) {
                if (_.isString(path)) {
                    path = path.split(options.separator);
                    path = function() {
                        var _i, _len, _results;
                        _results = [];
                        for (_i = 0, _len = path.length; _i < _len; _i++) {
                            p = path[_i];
                            if (p) {
                                _results.push(p);
                            }
                        }
                        return _results;
                    }();
                } else {
                    throw "_B.setp Error: invalid path: " + path + ".\nUse either an Array, eg ['path1', 'path2']\nor `separator`-ed String, eg 'path1.path2'";
                }
            }
            if (!_.isObject(o)) {
                throw "_B.setp Error: invalid object: " + o;
            }
            for (pi = _i = 0, _len = path.length; _i < _len; pi = ++_i) {
                p = path[pi];
                if (!_.isObject(o[p])) {
                    if (options.create || options.overwrite) {
                        newObj = null;
                        if (_.isUndefined(o[p])) {
                            newObj = {};
                        } else {
                            if (options.overwrite) {
                                newObj = {};
                                if (_.isString(options.overwrite)) {
                                    newObj[options.overwrite] = o[p];
                                }
                            }
                        }
                        if (newObj) {
                            o[p] = newObj;
                        }
                    } else {
                        if (_.isUndefined(o[p])) {
                            return false;
                        }
                    }
                }
                if (pi < path.length - 1) {
                    o = o[p];
                }
            }
            if (_.isObject(o)) {
                o[p] = val;
                return true;
            } else {
                return false;
            }
        };
        module.exports = setp;
        return module.exports;
    });
}).call(this);