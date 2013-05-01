// Generated by uRequire v0.3.0alpha23
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/blenders/DeepExtendBlender', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('../../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', '../../agreement/isAgree', '../../Logger', '../Blender'], factory);
 }
})(this,function (require, exports, module, _, isAgree) {
  // uRequire: start body of original nodejs module
var Blender, DeepExtendBlender, l, _, __hasProp = {}.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) {
        if (__hasProp.call(parent, key)) child[key] = parent[key];
    }
    function ctor() {
        this.constructor = child;
    }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
}, __slice = [].slice;

l = new (require("../../Logger"))("DeepExtendBlender");

Blender = require("../Blender");

_ = require("lodash");

DeepExtendBlender = function(_super) {
    __extends(DeepExtendBlender, _super);
    function DeepExtendBlender() {
        var blenderBehaviors;
        blenderBehaviors = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        this.blenderBehaviors = blenderBehaviors;
        (this.defaultBlenderBehaviors || (this.defaultBlenderBehaviors = [])).push(this.DeepExtendBlenderBehavior);
        DeepExtendBlender.__super__.constructor.apply(this, arguments);
    }
    DeepExtendBlender.prototype.DeepExtendBlenderBehavior = {
        order: [ "src", "dst" ],
        String: {
            "*": "overwriteOrReplace"
        },
        Array: {
            "[]": function(prop, src, dst, blender) {
                return _.reject(blender.deepOverwrite(prop, src, dst, blender), function(v) {
                    return v === null || v === void 0;
                });
            },
            "*": function(prop, src, dst) {
                throw "deepExtend: Error: Trying to combine an array with a non-array.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(dst[prop]) + "\nsource[prop]: " + l.prettify(src[prop]);
            }
        },
        Object: {
            "{}": function(prop, src, dst, blender) {
                var deepBlended, key, val, _ref;
                _ref = deepBlended = blender.getAction("deepOverwrite")(prop, src, dst, blender);
                for (key in _ref) {
                    val = _ref[key];
                    if (val === null || val === void 0) {
                        delete deepBlended[key];
                    }
                }
                return deepBlended;
            },
            "*": function(prop, src, dst) {
                throw "deepExtend: Error trying to combine a PlainObject with a non-PlainObject.\n\nProperty: " + prop + "\ndestination[prop]: " + l.prettify(dst[prop]) + "\nsource[prop]: " + l.prettify(src[prop]);
            }
        },
        overwriteOrReplace: function(prop, src, dst) {
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

module.exports = DeepExtendBlender;
// uRequire: end body of original nodejs module


return module.exports;
})
})();