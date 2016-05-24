// Generated by uRequire v0.7.0-beta.28 target: 'AMD' template: 'AMD'
(function () {
  
var indexOf = [].indexOf || function (item) {
  for (var i = 0, l = this.length; i < l; i++) {
    if (i in this && this[i] === item)
      return i;
  }
  return -1;
};
define(['require', 'exports', 'module', '../../types/type', 'lodash', '../Blender'], function (require, exports, module, type, _) {
  

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
          if (!(indexOf.call(similarTypes, dstType) >= 0 && indexOf.call(similarTypes, srcType) >= 0)) {
            this.write(dst, prop, srcType === "Array" ? [] : {});
          }
        }
        return this.deepOverwrite(prop, src, dst);
      }
    }
  });


})
}).call(this);