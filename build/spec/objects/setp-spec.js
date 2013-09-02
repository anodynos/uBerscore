// Generated by uRequire v0.6.0 - template: 'UMD'
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;


(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/setp-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../spec-data'], factory);
 }
}).call(this, this,function (require, exports, module, chai, _, _B, data) {
  
// uRequire v0.6.0: START body of original nodejs module
  var assert, expect;
  assert = chai.assert;
  expect = chai.expect;
  describe("objects/setp:", function () {
    var o;
    o = {
      "$": {
        bundle: {
          anArray: [
            "arrayItem1",
            2,
            { "arrayItem3": 3 }
          ],
          dependencies: { depsVars: "Bingo" }
        }
      }
    };
    describe("existent paths:", function () {
      it("primitive", function () {
        var isSet, oClone;
        oClone = _.clone(o, true);
        isSet = _B.setp(oClone, "$/bundle/dependencies/depsVars", "just_a_String");
        return expect(oClone).to.deep.equal({
          "$": {
            bundle: {
              anArray: [
                "arrayItem1",
                2,
                { "arrayItem3": 3 }
              ],
              dependencies: { depsVars: "just_a_String" }
            }
          }
        });
      });
      it("object, with sep at end & alt sep", function () {
        var isSet, oClone;
        oClone = _.clone(o, true);
        isSet = _B.setp(oClone, "$.bundle.dependencies.depsVars.", { property: "just_a_String" }, { separator: "." });
        expect(oClone).to.deep.equal({
          "$": {
            bundle: {
              anArray: [
                "arrayItem1",
                2,
                { "arrayItem3": 3 }
              ],
              dependencies: { depsVars: { property: "just_a_String" } }
            }
          }
        });
        return expect(isSet).to.be["true"];
      });
      it("object, overwriting object property", function () {
        var isSet, oClone;
        oClone = _.clone(o, true);
        isSet = _B.setp(oClone, "$.bundle.dependencies.", { property: "just_a_String" }, { separator: "." });
        expect(oClone).to.deep.equal({
          "$": {
            bundle: {
              anArray: [
                "arrayItem1",
                2,
                { "arrayItem3": 3 }
              ],
              dependencies: { property: "just_a_String" }
            }
          }
        });
        return expect(isSet).to.be["true"];
      });
      return it("array item, overwriting object property", function () {
        var isSet, oClone;
        oClone = _.clone(o, true);
        isSet = _B.setp(oClone, "$.bundle.anArray.2.arrayItem3", { "3_is_now": 33 }, { separator: "." });
        expect(oClone).to.deep.equal({
          "$": {
            bundle: {
              anArray: [
                "arrayItem1",
                2,
                { "arrayItem3": { "3_is_now": 33 } }
              ],
              dependencies: { depsVars: "Bingo" }
            }
          }
        });
        return expect(isSet).to.be["true"];
      });
    });
    return describe("inexistent key paths:", function () {
      it("not setting by default", function () {
        var isSet, oClone;
        oClone = _.clone(o, true);
        isSet = _B.setp(oClone, "$/bundle/dependencies/depsVars/hi", { joke: { joke2: "JOKER" } });
        expect(oClone).to.deep.equal(o);
        return expect(isSet).to.be["false"];
      });
      describe("options.create:", function () {
        it("create new objects for inexistent paths, adding object properties", function () {
          var isSet, oClone;
          oClone = _.clone(o, true);
          isSet = _B.setp(oClone, "$.bundle.dependencies.moreDeps.evenMoreDeps.", { property: "just_a_String" }, {
            create: true,
            separator: "."
          });
          expect(oClone).to.deep.equal({
            "$": {
              bundle: {
                anArray: [
                  "arrayItem1",
                  2,
                  { "arrayItem3": 3 }
                ],
                dependencies: {
                  depsVars: "Bingo",
                  moreDeps: { evenMoreDeps: { property: "just_a_String" } }
                }
              }
            }
          });
          return expect(isSet).to.be["true"];
        });
        return it("NOT overwritting primitives:", function () {
          var isSet, oClone;
          oClone = _.clone(o, true);
          isSet = _B.setp(oClone, "$/bundle/dependencies/depsVars/newKey/", { property: "just_a_String" }, { create: true });
          expect(oClone).to.deep.equal({
            "$": {
              bundle: {
                anArray: [
                  "arrayItem1",
                  2,
                  { "arrayItem3": 3 }
                ],
                dependencies: { depsVars: "Bingo" }
              }
            }
          });
          return expect(isSet).to.be["false"];
        });
      });
      return describe("options.overwrite:", function () {
        it("create new objects, overwritting primitives:", function () {
          var isSet, oClone;
          oClone = _.clone(o, true);
          isSet = _B.setp(oClone, "$/bundle/dependencies/depsVars/newKey", { joke: { joke2: "JOKER" } }, { overwrite: true });
          expect(oClone).to.deep.equal({
            "$": {
              bundle: {
                anArray: [
                  "arrayItem1",
                  2,
                  { "arrayItem3": 3 }
                ],
                dependencies: { depsVars: { newKey: { joke: { joke2: "JOKER" } } } }
              }
            }
          });
          return expect(isSet).to.be["true"];
        });
        return it("create new objects, preserving `oldValue`", function () {
          var isSet, oClone;
          oClone = _.clone(o, true);
          isSet = _B.setp(oClone, "$/bundle/dependencies/depsVars/newKey/anotherNewKey", { joke: { joke2: "JOKER" } }, { overwrite: "_oldValue" });
          expect(oClone).to.deep.equal({
            "$": {
              bundle: {
                anArray: [
                  "arrayItem1",
                  2,
                  { "arrayItem3": 3 }
                ],
                dependencies: {
                  depsVars: {
                    _oldValue: "Bingo",
                    newKey: { anotherNewKey: { joke: { joke2: "JOKER" } } }
                  }
                }
              }
            }
          });
          return expect(isSet).to.be["true"];
        });
      });
    });
  });
// uRequire v0.6.0: END body of original nodejs module


return module.exports;
})
}).call(this);