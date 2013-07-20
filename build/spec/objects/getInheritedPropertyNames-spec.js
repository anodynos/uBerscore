// Generated by uRequire v0.5.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/getInheritedPropertyNames-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var Class3, assert, expect, objectWithProtoInheritedProps;

assert = chai.assert;

expect = chai.expect;

objectWithProtoInheritedProps = data.objectWithProtoInheritedProps, Class3 = data.Class3;

describe("getInheritedPropertyNames: ", function() {
    it("reads property names of __proro__ linked object hierarchy", function() {
        var inheritedProps;
        inheritedProps = _B.getInheritedPropertyNames(objectWithProtoInheritedProps);
        return expect(_B.isEqualArraySet(inheritedProps, [ "aProp1", "aProp2", "aProp3" ])).to.be["true"];
    });
    return it("reads property names of coffeescript class-inherited objects", function() {
        return expect(_B.isEqualArraySet(_B.getInheritedPropertyNames(new Class3), [ "aProp3", "aProp2", "aProp1" ])).to.be["true"];
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();