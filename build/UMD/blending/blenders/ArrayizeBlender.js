// Generated by uRequire v0.7.0-beta.25 target: 'UMD' template: 'UMDplain'
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
  }, hasProp = {}.hasOwnProperty, indexOf = [].indexOf || function (item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (i in this && this[i] === item)
        return i;
    }
    return -1;
  };
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('../../collections/array/arrayize'), require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', '../../collections/array/arrayize', 'lodash', './DeepCloneBlender'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, arrayize, _) {
  

var ArrayizeBlender;
  return ArrayizeBlender = function (superClass) {
    extend(ArrayizeBlender, superClass);
    function ArrayizeBlender() {
      return ArrayizeBlender.__super__.constructor.apply(this, arguments);
    }
    ArrayizeBlender.prototype.addMethod = "push";
    ArrayizeBlender.prototype.unique = false;
    ArrayizeBlender.prototype.reverse = false;
    ArrayizeBlender.behavior = {
      order: ["src"],
      "*": "addToArray",
      addToArray: function (prop, src, dst) {
        var dstArray, i, itemsToAdd, len, srcArray, v;
        dstArray = this.write(dst, prop, arrayize(this.read(dst, prop)));
        srcArray = arrayize(this.read(src, prop));
        if (_.isEqual(srcArray[0], [null])) {
          dstArray = this.write(dst, prop, []);
          srcArray = srcArray.slice(1);
        }
        itemsToAdd = this.unique ? function () {
          var i, len, results;
          results = [];
          for (i = 0, len = srcArray.length; i < len; i++) {
            v = srcArray[i];
            if (indexOf.call(dstArray, v) < 0) {
              results.push(v);
            }
          }
          return results;
        }() : _.clone(srcArray);
        if (this.reverse) {
          itemsToAdd.reverse();
        }
        for (i = 0, len = itemsToAdd.length; i < len; i++) {
          v = itemsToAdd[i];
          dstArray[this.addMethod](v);
        }
        return dstArray;
      }
    };
    return ArrayizeBlender;
  }(require("./DeepCloneBlender"));


});
}).call(this);