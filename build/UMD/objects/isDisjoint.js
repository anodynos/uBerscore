// Generated by uRequire v0.7.0-beta.25 target: 'UMD' template: 'UMDplain'
(function () {
  (function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _) {
  

var isDisjoint;
isDisjoint = function (oa1, oa2, equality) {
  var found;
  if (equality == null) {
    equality = function (v1, v2) {
      return v1 === v2;
    };
  }
  found = false;
  _.each(oa1, function (v1) {
    if (_.any(oa2, function (v2) {
        return equality(v1, v2);
      })) {
      found = true;
      return false;
    }
  });
  return !found;
};
module.exports = isDisjoint;

return module.exports;

});
}).call(this);