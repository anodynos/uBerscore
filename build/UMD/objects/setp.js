// Generated by uRequire v0.7.0-beta.28 target: 'UMD' template: 'UMDplain'
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

var defaultOptions, setp;
defaultOptions = {
  separator: "/",
  create: true,
  overwrite: false
};
setp = function (o, path, val, options) {
  var i, len, newObj, p, pi;
  if (options == null) {
    options = defaultOptions;
  }
  if (options !== defaultOptions) {
    _.defaults(options, defaultOptions);
  }
  if (!_.isArray(path)) {
    if (_.isString(path)) {
      path = path.split(options.separator);
      path = function () {
        var i, len, results;
        results = [];
        for (i = 0, len = path.length; i < len; i++) {
          p = path[i];
          if (p) {
            results.push(p);
          }
        }
        return results;
      }();
    } else {
      throw "_B.setp Error: invalid path: " + path + ".\nUse either an Array, eg ['path1', 'path2']\nor `separator`-ed String, eg 'path1.path2'";
    }
  }
  if (!_.isObject(o)) {
    throw "_B.setp Error: invalid object: " + o;
  }
  for (pi = i = 0, len = path.length; i < len; pi = ++i) {
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