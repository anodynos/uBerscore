// Generated by uRequire v0.7.0-beta.28 target: 'UMD' template: 'UMDplain'
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', './blenders/DeepCloneBlender'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

var DeepCloneBlender, clone;
DeepCloneBlender = require("./blenders/DeepCloneBlender");
clone = function (obj, options) {
  if (!options) {
    return _.clone(obj, options);
  } else {
    if (!(options === true || options.deep)) {
      return new DeepCloneBlender([{ "*": { "*": "overwrite" } }], options).blend(obj);
    } else {
      return new DeepCloneBlender([], options).blend(obj);
    }
  }
};
module.exports = clone;

return module.exports;

});
}).call(this);