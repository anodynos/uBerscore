// Generated by uRequire v0.7.0-beta.28 target: 'UMD' template: 'UMDplain'
(function () {
  
var extend = function (child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key))
        child[key] = parent[key];
    }
    function ctor() {
      this.constructor = child;
    }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  }, hasProp = {}.hasOwnProperty;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('../Blender'), require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', '../Blender', 'lodash', '../../Logger'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, Blender, _) {
  

var DeepExtendBlender, l;
  l = new (require("../../Logger"))("uberscore/DeepExtendBlender");
  return DeepExtendBlender = function (superClass) {
    extend(DeepExtendBlender, superClass);
    function DeepExtendBlender() {
      return DeepExtendBlender.__super__.constructor.apply(this, arguments);
    }
    DeepExtendBlender.behavior = {
      order: [
        "src",
        "dst"
      ],
      String: { "*": "overwriteOrReplace" },
      "[]": {
        "[]": function (prop, src, dst) {
          return _.reject(this.deepOverwrite(prop, src, dst), function (v) {
            return v === null || v === void 0;
          });
        },
        "*": function (prop, src, dst) {
          throw "deepExtend: Error: Trying to combine an array with a non-array.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(dst[prop]) + "\nsource[prop]: " + l.prettify(src[prop]);
        }
      },
      "{}": {
        "{}": function (prop, src, dst) {
          var deepBlended, key, ref, val;
          ref = deepBlended = this.getAction("deepOverwrite")(prop, src, dst);
          for (key in ref) {
            val = ref[key];
            if (val === null || val === void 0) {
              delete deepBlended[key];
            }
          }
          return deepBlended;
        },
        "*": function (prop, src, dst) {
          throw "deepExtend: Error trying to combine a PlainObject with a non-PlainObject.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(dst[prop]) + "\nsource[prop]: " + l.prettify(src[prop]);
        }
      },
      overwriteOrReplace: function (prop, src, dst) {
        var replaceRE;
        replaceRE = /\${\s*?_\s*?}/;
        if (_.isString(src[prop]) && replaceRE.test(src[prop])) {
          if (_.isString(dst[prop])) {
            return src[prop].replace(replaceRE, dst[prop]);
          } else {
            return dst[prop];
          }
        } else {
          return src[prop];
        }
      }
    };
    return DeepExtendBlender;
  }(Blender);


});
}).call(this);