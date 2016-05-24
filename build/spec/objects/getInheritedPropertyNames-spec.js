// Generated by uRequire v0.7.0-beta.28 target: 'spec' template: 'UMDplain'
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('../spec-data'), require('../specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', '../spec-data', '../specHelpers'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('objects/getInheritedPropertyNames-spec.js');

var Class3, objectWithProtoInheritedProps;
objectWithProtoInheritedProps = data.objectWithProtoInheritedProps, Class3 = data.Class3;
describe("getInheritedPropertyNames: ", function () {
  it("reads property names of __proro__ linked object hierarchy", function () {
    var inheritedProps;
    inheritedProps = _B.getInheritedPropertyNames(objectWithProtoInheritedProps);
    return equalSet(inheritedProps, [
      "aProp1",
      "aProp2",
      "aProp3"
    ]);
  });
  return it("reads property names of coffeescript class-inherited objects", function () {
    return equalSet(_B.getInheritedPropertyNames(new Class3()), [
      "aProp3",
      "aProp2",
      "aProp1"
    ]);
  });
});

return module.exports;

});
}).call(this);