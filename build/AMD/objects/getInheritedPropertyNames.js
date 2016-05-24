// Generated by uRequire v0.7.0-beta.28 target: 'AMD' template: 'AMD'
(function () {
  define(['require', 'exports', 'module', 'lodash'], function (require, exports, module, _) {
  

var _getInheritedPropertyNames, getInheritedPropertyNames;
getInheritedPropertyNames = function (obj) {
  return _getInheritedPropertyNames(Object.getPrototypeOf(obj));
};
_getInheritedPropertyNames = function (obj) {
  var props;
  props = [];
  while (true) {
    if (!obj || obj === void 0 || _.isEmpty(obj) && !Object.getPrototypeOf(obj)) {
      break;
    }
    Object.getOwnPropertyNames(obj).forEach(function (prop) {
      if (props.indexOf(prop) === -1 && prop !== "constructor") {
        return props.push(prop);
      }
    });
    obj = Object.getPrototypeOf(obj);
  }
  return props;
};
module.exports = getInheritedPropertyNames;

return module.exports;

})
}).call(this);