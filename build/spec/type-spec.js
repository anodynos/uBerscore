// Generated by uRequire v0.3.0alpha22
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('type-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('./spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', './spec-data'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var assert, chai, expect, oOs, _, _B;

chai = require("chai");

assert = chai.assert;

expect = chai.expect;

_ = require("lodash");

_B = require("uberscore");

oOs = {
    Array: [ "this", "is", 1, "array" ],
    Function: function(x) {
        return x;
    },
    String: "I am a String!",
    Number: 667,
    Date: new Date,
    RegExp: /./g,
    Boolean: true,
    Null: null,
    Undefined: void 0,
    Object: {
        a: 1,
        b: 2,
        toString: function() {
            return "I am not a String, I am an Object...";
        }
    }
};

describe("type :", function() {
    var typeName, value, _results;
    _results = [];
    for (typeName in oOs) {
        value = oOs[typeName];
        _results.push(function(typeName, value, longType, shortType) {
            return it("recognises type '" + typeName + "', both as long='" + longType + "' & short='" + shortType + "'", function() {
                expect(longType).to.equal(_B.type.toLong(typeName));
                expect(_B.type.isType(longType)).to.be["true"];
                expect(shortType).to.equal(_B.type.toShort(typeName));
                expect(_B.type.isType(shortType)).to.be["true"];
                return expect(_B.type.areEqual(longType, shortType)).to.be["true"];
            });
        }(typeName, value, _B.type(value), _B.type(value, true)));
    }
    return _results;
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();