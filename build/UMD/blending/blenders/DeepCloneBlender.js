// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;

// uRequire v0.6.0: START of preDefineIFIBody - statements/declarations before define(), enclosed in an IFI (function(){})().
  var __hasProp = {}.hasOwnProperty, __extends = function (child, parent) {
      for (var key in parent) {
        if (__hasProp.call(parent, key))
          child[key] = parent[key];
      }
      function ctor() {
        this.constructor = child;
      }
      ctor.prototype = parent.prototype;
      child.prototype = new ctor();
      child.__super__ = parent.prototype;
      return child;
    }, __indexOf = [].indexOf || function (item) {
      for (var i = 0, l = this.length; i < l; i++) {
        if (i in this && this[i] === item)
          return i;
      }
      return -1;
    };
// uRequire v0.6.0: END of preDefineIFIBody

(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/blenders/DeepCloneBlender', module, __dirname, '.');
   module.exports = factory(nr.require, nr.require('../../types/type'), nr.require('lodash'), nr.require('../../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', '../../types/type', 'lodash', '../../agreement/isAgree', '../Blender'], factory);
 }
}).call(this, this,function (require, type, _, isAgree) {
  
// uRequire v0.6.0: START body of original AMD module
var DeepCloneBlender, _ref;
    return DeepCloneBlender = function (_super) {
      __extends(DeepCloneBlender, _super);
      function DeepCloneBlender() {
        _ref = DeepCloneBlender.__super__.constructor.apply(this, arguments);
        return _ref;
      }
      DeepCloneBlender.behavior = {
        order: [
          "dst",
          "src"
        ],
        "*": {
          "[]": "deepCloneOverwrite",
          "{}": "deepCloneOverwrite",
          "->": function (prop, src) {
            return src[prop];
          },
          "Undefined": DeepCloneBlender.SKIP
        },
        deepCloneOverwrite: function (prop, src, dst) {
          var dstType, similarTypes, srcType;
          srcType = type(src[prop]);
          dstType = type(dst[prop]);
          if (dstType !== srcType) {
            similarTypes = [
              "Function",
              "Object"
            ];
            if (!(__indexOf.call(similarTypes, dstType) >= 0 && __indexOf.call(similarTypes, srcType) >= 0)) {
              dst[prop] = srcType === "Array" ? [] : {};
            }
          }
          return this.deepOverwrite(prop, src, dst);
        }
      };
      return DeepCloneBlender;
    }(require("../Blender"));
// uRequire v0.6.0: END body of original AMD module


})
}).call(this);