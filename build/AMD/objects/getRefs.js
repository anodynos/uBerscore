// Generated by uRequire v0.7.0-beta.28 target: 'AMD' template: 'AMD'
(function () {
  define(['require', 'exports', 'module', 'lodash'], function (require, exports, module, _) {
  

var getRefs, getRefsDefaults, hasProp = {}.hasOwnProperty;
getRefsDefaults = {
  deep: false,
  inherited: false
};
getRefs = function (oa, options, refsArray) {
  var i, key, keys, len, v;
  if (options == null) {
    options = getRefsDefaults;
  }
  if (refsArray == null) {
    refsArray = [];
  }
  if (options !== getRefsDefaults) {
    _.defaults(options, getRefsDefaults);
  }
  keys = options.inherited ? function () {
    var results;
    results = [];
    for (key in oa) {
      results.push(key);
    }
    return results;
  }() : function () {
    var results;
    results = [];
    for (key in oa) {
      if (!hasProp.call(oa, key))
        continue;
      results.push(key);
    }
    return results;
  }();
  for (i = 0, len = keys.length; i < len; i++) {
    key = keys[i];
    v = oa[key];
    if (_.isObject(v)) {
      refsArray.push(v);
      if (options.deep) {
        getRefs(v, options, refsArray);
      }
    }
  }
  return refsArray;
};
module.exports = getRefs;

return module.exports;

})
}).call(this);