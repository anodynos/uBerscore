// Generated by uRequire v0.7.0-beta.25 target: 'AMD' template: 'AMD'
(function () {
  define(['require', 'exports', 'module', 'lodash', './getRefs', './isDisjoint'], function (require, exports, module, _) {
  

var getRefs, isDisjoint, isRefDisjoint, isRefDisjointDefaults;
getRefs = require("./getRefs");
isDisjoint = require("./isDisjoint");
isRefDisjointDefaults = {
  deep: false,
  inherited: false
};
isRefDisjoint = function (oa1, oa2, options) {
  var refs1, refs2;
  if (options == null) {
    options = isRefDisjointDefaults;
  }
  if (options !== isRefDisjointDefaults) {
    _.defaults(options, isRefDisjointDefaults);
  }
  if (oa1 === oa2) {
    return false;
  } else {
    refs1 = getRefs(oa1, options);
    refs1.unshift(oa1);
    refs2 = getRefs(oa2, options);
    refs2.unshift(oa2);
    return isDisjoint(refs1, refs2);
  }
};
module.exports = isRefDisjoint;

return module.exports;

})
}).call(this);