// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;


(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('utils/CoffeeUtils', module, __dirname, '.');
   module.exports = factory(nr.require, nr.require('lodash'), nr.require('../agreement/isAgree'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'lodash', '../agreement/isAgree'], factory);
 }
}).call(this, this,function (require, _, isAgree) {
  
// uRequire v0.6.0: START body of original AMD module
var CoffeeUtils;
    return CoffeeUtils = function () {
      function CoffeeUtils() {
      }
      CoffeeUtils.prototype.getClasses = function (instOrClass, _classes) {
        if (_classes == null) {
          _classes = [];
        }
        if (!instOrClass) {
          instOrClass = this;
        }
        if (typeof instOrClass !== "function") {
          instOrClass = instOrClass.constructor;
        }
        _classes.unshift(instOrClass);
        if (instOrClass.__super__) {
          return this.getClasses(instOrClass.__super__.constructor, _classes);
        } else {
          return _classes;
        }
      };
      CoffeeUtils.getClasses = CoffeeUtils.prototype.getClasses;
      return CoffeeUtils;
    }();
// uRequire v0.6.0: END body of original AMD module


})
}).call(this);