// Generated by uRequire v0.7.0-beta4 - template: 'UMDplain' 
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('../agreement/isAgree'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', '../agreement/isAgree'], factory) } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, isAgree) {
  

var subclass;
subclass = module.exports = function (protoProps, staticProps) {
  var Surrogate, child, parent;
  parent = this;
  child = void 0;
  if (protoProps && _.has(protoProps, "constructor")) {
    child = protoProps.constructor;
  } else {
    child = function () {
      return parent.apply(this, arguments);
    };
  }
  _.extend(child, parent, staticProps);
  Surrogate = function () {
    this.constructor = child;
    return this;
  };
  Surrogate.prototype = parent.prototype;
  child.prototype = new Surrogate();
  if (protoProps) {
    _.extend(child.prototype, protoProps);
  }
  child.__super__ = parent.prototype;
  return child;
};

return module.exports;

})
}).call(this)