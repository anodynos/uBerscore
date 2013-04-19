// Generated by uRequire v0.3.0alpha22
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/getValueAtPath-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var assert, expect;

assert = chai.assert;

expect = chai.expect;

describe("objects/getValueAtPath ", function() {
    var o;
    o = {
        $: {
            bundle: {
                anArray: [ "arrayItem1", 2, {
                    arrayItem3: 3
                } ],
                dependencies: {
                    variableNames: "Bingo"
                }
            }
        }
    };
    return describe("retrieving value: ", function() {
        it("primitive", function() {
            return expect(_B.getValueAtPath(o, "$/bundle/dependencies/variableNames")).to.deep.equal("Bingo");
        });
        it("object", function() {
            return expect(_B.getValueAtPath(o, "$/bundle/dependencies")).to.deep.equal({
                variableNames: "Bingo"
            });
        });
        it("object, with sep at end", function() {
            return expect(_B.getValueAtPath(o, "$/bundle/dependencies/")).to.deep.equal({
                variableNames: "Bingo"
            });
        });
        it("array item (3rd)", function() {
            return expect(_B.getValueAtPath(o, "$/bundle/anArray/2/")).to.deep.equal({
                arrayItem3: 3
            });
        });
        it("property of (3rd) array item ", function() {
            return expect(_B.getValueAtPath(o, "$/bundle/anArray/2/arrayItem3")).to.deep.equal(3);
        });
        it("object, with alternative sep", function() {
            return expect(_B.getValueAtPath(o, "$.bundle.dependencies.", ".")).to.deep.equal({
                variableNames: "Bingo"
            });
        });
        it("undefined, for non existent key", function() {
            return expect(_B.getValueAtPath(o, "$/bundle/dependencies/variableNames/notfound")).to.deep.equal(void 0);
        });
        return it("undefined, for path of inexistent keys, with alt sep", function() {
            return expect(_B.getValueAtPath(o, "$>bundle>dependencies>variableNames>notfound>stillNotFound>", ">")).to.deep.equal(void 0);
        });
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();