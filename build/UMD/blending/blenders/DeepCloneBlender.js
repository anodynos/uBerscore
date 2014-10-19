// Generated by uRequire v0.7.0-beta5 - template: 'UMDplain' 
(function () {
  
var __indexOf = [].indexOf || function (item) {
  for (var i = 0, l = this.length; i < l; i++) {
    if (i in this && this[i] === item)
      return i;
  }
  return -1;
};
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, require('../../types/type'), require('lodash'), require('../../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) { define(['require', '../../types/type', 'lodash', '../../agreement/isAgree', '../Blender'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, type, _, isAgree) {
  

var DeepCloneBlender;
  return DeepCloneBlender = require("../Blender").subclass({}, {
    behavior: {
      order: [
        "dst",
        "src"
      ],
      "*": {
        "[]": "deepCloneOverwrite",
        "{}": "deepCloneOverwrite",
        "->": function (prop, src) {
          return this.read(src, prop);
        },
        "Undefined": function () {
          return this.SKIP;
        }
      },
      deepCloneOverwrite: function (prop, src, dst) {
        var dstType, similarTypes, srcType;
        srcType = type(this.read(src, prop));
        dstType = type(this.read(dst, prop));
        if (dstType !== srcType) {
          similarTypes = [
            "Function",
            "Object"
          ];
          if (!(__indexOf.call(similarTypes, dstType) >= 0 && __indexOf.call(similarTypes, srcType) >= 0)) {
            this.write(dst, prop, srcType === "Array" ? [] : {});
          }
        }
        return this.deepOverwrite(prop, src, dst);
      }
    }
  });


})
}).call(this)