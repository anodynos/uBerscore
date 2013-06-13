// Generated by uRequire v0.4.0alpha21
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/mutate-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var assert, expect;

assert = chai.assert;

expect = chai.expect;

describe("mutate :", function() {
    var simpleCalc;
    simpleCalc = function(v) {
        if (v < 0) {
            return v + 10;
        } else {
            return v + 20;
        }
    };
    it("mutate Object values", function() {
        var o;
        o = {
            a: 1,
            b: 2,
            c: -1
        };
        return expect(_B.mutate(o, simpleCalc)).to.deep.equal({
            a: 21,
            b: 22,
            c: 9
        });
    });
    it("arrayize if string", function() {
        var o;
        o = {
            key1: "lalakis",
            key2: [ "ok", "yes" ]
        };
        return expect(_B.mutate(o, _B.arrayize, _.isString)).to.deep.equal({
            key1: [ "lalakis" ],
            key2: [ "ok", "yes" ]
        });
    });
    return describe("mutate arrays :", function() {
        var a;
        a = [ 1, 2, -1 ];
        it("mutate array with simplecalc ", function() {
            return expect(_B.mutate(a, simpleCalc)).to.deep.equal([ 21, 22, 9 ]);
        });
        return it("mutate array again with fltr", function() {
            return expect(_B.mutate(a, simpleCalc, function(v) {
                return v > 10;
            })).to.deep.equal([ 41, 42, 9 ]);
        });
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();