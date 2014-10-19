// Generated by uRequire v0.7.0-beta5 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, isAgree) {
  

var defaultOptions, getp;
defaultOptions = {
  separator: "/",
  stopKey: "#",
  terminateKey: void 0,
  defaultKey: "*",
  isReturnLast: false
};
getp = function (o, path, options) {
  var lastO, op, p, returnWithTerminator, _i, _len;
  if (options == null) {
    options = defaultOptions;
  }
  if (options !== defaultOptions) {
    _.defaults(options, defaultOptions);
  }
  if (!_.isArray(path)) {
    if (_.isString(path)) {
      path = path.split(options.separator);
    } else {
      if (_.isNumber(path)) {
        path = [path + ""];
      } else {
        if (path === void 0) {
          return o;
        } else {
          throw "_B.getp Error: invalid path: " + path;
        }
      }
    }
  }
  for (_i = 0, _len = path.length; _i < _len; _i++) {
    p = path[_i];
    if (!(p + "")) {
      continue;
    }
    if (o !== void 0) {
      lastO = o;
    }
    if (!_.isObject(o)) {
      o = void 0;
      break;
    }
    if (options.terminateKey) {
      if (o[options.terminateKey]) {
        returnWithTerminator = {};
        returnWithTerminator[options.terminateKey] = o[options.terminateKey];
        o = returnWithTerminator;
        break;
      }
    }
    if ((op = o[p]) !== void 0) {
      o = op;
    } else {
      if (options.stopKey && o[options.stopKey] !== void 0) {
        o = o[options.stopKey];
        break;
      } else {
        o = options.defaultKey && o[options.defaultKey] ? o[options.defaultKey] : void 0;
      }
    }
  }
  if (o === void 0) {
    if (options.isReturnLast) {
      return lastO;
    } else {
      return o;
    }
  } else {
    return o;
  }
};
module.exports = getp;

return module.exports;

})
}).call(this)