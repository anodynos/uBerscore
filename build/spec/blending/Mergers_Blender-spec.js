// Generated by uRequire v0.7.0-beta.25 target: 'spec' template: 'UMDplain'
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


var l = new _B.Logger('blending/Mergers_Blender-spec.js');

var Class3, c3, expectedPropertyValues, objectWithProtoInheritedProps;
objectWithProtoInheritedProps = data.objectWithProtoInheritedProps, Class3 = data.Class3, c3 = data.c3, expectedPropertyValues = data.expectedPropertyValues;
describe("Mergers_Blender-spec", function () {
  describe("'Blender.blend' Default settings: {inherited:false, copyProto:false}", function () {
    var defaultBlender;
    defaultBlender = new _B.Blender();
    describe("clones POJSO Object (no inheritance)", function () {
      return describe("(shallowClone = defaultBlender.blend {}, expectedPropertyValues)", function () {
        var shallowClone;
        shallowClone = defaultBlender.blend(expectedPropertyValues);
        return describe("is a shallow clone and compared to source: ", function () {
          it("is not RefDisjoint - (there is at least one common reference))", function () {
            return expect(_B.isRefDisjoint(shallowClone, expectedPropertyValues, {
              deep: true,
              inherited: true
            })).to.be["false"];
          });
          it("has common references of all nested objects", function () {
            var cRefs, sRefs;
            sRefs = _B.getRefs(expectedPropertyValues, {
              deep: true,
              inherited: true
            });
            cRefs = _B.getRefs(shallowClone, {
              deep: true,
              inherited: true
            });
            return equalSet(sRefs, cRefs);
          });
          it("has a nested object copied by reference", function () {
            equal(shallowClone.aProp1, expectedPropertyValues.aProp1);
            return expect(shallowClone.aProp1).to.not.be.an("undefined");
          });
          it("_.isEqual true (soft equality, same values/JSON)", function () {
            return expect(_.isEqual(shallowClone, expectedPropertyValues)).to.be["true"];
          });
          it("_B.isEqual true (soft equality, same values/JSON)", function () {
            return deepEqual(shallowClone, expectedPropertyValues);
          });
          return it("_B.isExact true (strict references equality)", function () {
            return exact(shallowClone, expectedPropertyValues);
          });
        });
      });
    });
    return describe("clones objectWithProtoInheritedProps (with inheritance)", function () {
      return describe("(shallowClone = defaultBlender.blend {}, objectWithProtoInheritedProps)", function () {
        var shallowIncompleteClone;
        shallowIncompleteClone = defaultBlender.blend({}, objectWithProtoInheritedProps);
        return describe("is an incomplete shallow clone, not copied inherited props: ", function () {
          it("has NOT common references of all nested objects", function () {
            var cRefs, sRefs;
            sRefs = _B.getRefs(objectWithProtoInheritedProps, {
              deep: true,
              inherited: true
            });
            cRefs = _B.getRefs(shallowIncompleteClone, {
              deep: true,
              inherited: true
            });
            return expect(_B.isDisjoint(sRefs, cRefs)).to.be["true"];
          });
          it("has NOT copied inherited nested object", function () {
            return expect(shallowIncompleteClone.aProp1 === void 0).to.be["true"];
          });
          it("_.isEqual true (soft equality, same values/JSON)", function () {
            return expect(_.isEqual(shallowIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
          });
          it("_B.isEqual true (soft equality, same values/JSON)", function () {
            return deepEqual(shallowIncompleteClone, objectWithProtoInheritedProps);
          });
          it("_B.isExact true (strict references equality, no inherited props)", function () {
            return exact(shallowIncompleteClone, objectWithProtoInheritedProps);
          });
          it("_B.isIqual false (inherited props, soft object equality)", function () {
            return notIqual(shallowIncompleteClone, objectWithProtoInheritedProps);
          });
          return it("_B.isIxact false (inherited props equality + strict references equality)", function () {
            return notIxact(shallowIncompleteClone, objectWithProtoInheritedProps);
          });
        });
      });
    });
  });
  describe("Default 'Blender.blend' with inherited:true", function () {
    var defaultBlenderInheritedCopier;
    defaultBlenderInheritedCopier = new _B.Blender([], { inherited: true });
    return describe("clones objectWithProtoInheritedProps (with inheritance)", function () {
      return describe("(shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend {}, objectWithProtoInheritedProps)", function () {
        var shallowCloneInheritedCopied;
        shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend(objectWithProtoInheritedProps);
        return describe("is a complete shallow clone, having shallow copied all inherited props: ", function () {
          it("has common references of all nested objects", function () {
            var cRefs, sRefs;
            sRefs = _B.getRefs(objectWithProtoInheritedProps, {
              deep: true,
              inherited: true
            });
            cRefs = _B.getRefs(shallowCloneInheritedCopied, {
              deep: true,
              inherited: true
            });
            return equalSet(sRefs, cRefs);
          });
          it("has copied inherited nested object", function () {
            equal(shallowCloneInheritedCopied.aProp1, objectWithProtoInheritedProps.aProp1);
            return expect(shallowCloneInheritedCopied.aProp1).to.not.be.an("undefined");
          });
          it("_.isEqual is false (soft equality, not looking at inherited props of source)", function () {
            return expect(_.isEqual(shallowCloneInheritedCopied, objectWithProtoInheritedProps)).to.be["false"];
          });
          it("_B.isEqual is false (soft equality, not looking at inherited props of source)", function () {
            return notDeepEqual(shallowCloneInheritedCopied, objectWithProtoInheritedProps);
          });
          it("_B.isExact is false (strict references equality, no inherited props of source)", function () {
            return notExact(shallowCloneInheritedCopied, objectWithProtoInheritedProps);
          });
          it("_B.isIqual is true (inherited props, soft object equality)", function () {
            return iqual(shallowCloneInheritedCopied, objectWithProtoInheritedProps);
          });
          return it("_B.isIxact true (inherited props, strict references equality)", function () {
            return ixact(shallowCloneInheritedCopied, objectWithProtoInheritedProps);
          });
        });
      });
    });
  });
  return describe("Default 'Blender.blend' with copyProto:true", function () {
    var defaultBlenderProtoCopier;
    defaultBlenderProtoCopier = new _B.Blender([], { copyProto: true });
    return describe("clones objectWithProtoInheritedProps (with inheritance)", function () {
      return describe("(shallowClone = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps)", function () {
        var shallowCloneProtoCopied;
        shallowCloneProtoCopied = defaultBlenderProtoCopier.blend({}, objectWithProtoInheritedProps);
        return describe("is a complete shallow clone, having shallow copied only own props & __proto__: ", function () {
          it("has ALL common references of all nested objects", function () {
            var cRefs, sRefs;
            sRefs = _B.getRefs(objectWithProtoInheritedProps, {
              deep: true,
              inherited: true
            });
            cRefs = _B.getRefs(shallowCloneProtoCopied, {
              deep: true,
              inherited: true
            });
            return equalSet(sRefs, cRefs);
          });
          it("has not copied inherited nested object, but can access it through __proto__ inheritance", function () {
            equal(shallowCloneProtoCopied.aProp1, objectWithProtoInheritedProps.aProp1);
            expect(shallowCloneProtoCopied.aProp1).to.not.be.an("undefined");
            expect(objectWithProtoInheritedProps.hasOwnProperty("aProp1")).to.be["false"];
            return expect(shallowCloneProtoCopied.hasOwnProperty("aProp1")).to.be["false"];
          });
          it("_.isEqual is true (soft equality, not looking at inherited props of either)", function () {
            return expect(_.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps)).to.be["true"];
          });
          it("_B.isEqual is true (soft equality, not looking at inherited props of either)", function () {
            return deepEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps);
          });
          it("_B.isExact is true (strict references equality, no inherited props of either)", function () {
            return exact(shallowCloneProtoCopied, objectWithProtoInheritedProps);
          });
          it("_B.isIqual is true (inherited props, soft object equality)", function () {
            return iqual(shallowCloneProtoCopied, objectWithProtoInheritedProps);
          });
          return it("_B.isIxact true (inherited props, strict references equality)", function () {
            return ixact(shallowCloneProtoCopied, objectWithProtoInheritedProps);
          });
        });
      });
    });
  });
});
describe("DeepCloneBlender .blend:", function () {
  describe("Default settings: with inherited:false, copyProto:false", function () {
    var deepCloneBlender;
    deepCloneBlender = new _B.DeepCloneBlender();
    describe("clones POJSO Object (no inheritance)", function () {
      return describe("(deepClone = deepCloneBlender.blend {}, expectedPropertyValues)", function () {
        var deepClone;
        deepClone = deepCloneBlender.blend(expectedPropertyValues);
        return describe("is a deep clone", function () {
          it("_B.isDisjoint true, NO common references in objects", function () {
            return expect(_B.isRefDisjoint(deepClone, expectedPropertyValues, {
              deep: true,
              inherited: true
            })).to.be["true"];
          });
          it("nested object is a clone it self - NOT the same reference", function () {
            return notEqual(deepClone.aProp1, expectedPropertyValues.aProp1);
          });
          it("_.isEqual true (soft equality, same values/JSON)", function () {
            return expect(_.isEqual(deepClone, expectedPropertyValues)).to.be["true"];
          });
          it("_B.isEqual true (soft equality, same values/JSON)", function () {
            return deepEqual(deepClone, expectedPropertyValues);
          });
          return it("_B.isExact is false (strict references equality)", function () {
            return notExact(deepClone, expectedPropertyValues);
          });
        });
      });
    });
    return describe("clones objectWithProtoInheritedProps (with inheritance)", function () {
      return describe("(deepIncompleteClone = deepCloneBlender.blend {}, objectWithProtoInheritedProps)", function () {
        var deepIncompleteClone;
        deepIncompleteClone = deepCloneBlender.blend({}, objectWithProtoInheritedProps);
        return describe("is an incomplete deep clone, not copied inherited props: ", function () {
          it("_B.isDisjoint true, has NO common references of all nested objects", function () {
            return expect(_B.isRefDisjoint(objectWithProtoInheritedProps, deepIncompleteClone, {
              deep: true,
              inherited: true
            })).to.be["true"];
          });
          it("has NOT copied inherited nested object", function () {
            return expect(deepIncompleteClone.aProp1 === void 0).to.be["true"];
          });
          describe("equality of deepIncompleteClone, objectWithProtoInheritedProps", function () {
            it("_.isEqual true (soft equality, same values/JSON)", function () {
              return expect(_.isEqual(deepIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
            });
            it("_B.isEqual true (soft equality, same values/JSON)", function () {
              return deepEqual(deepIncompleteClone, objectWithProtoInheritedProps);
            });
            it("_B.isIqual false (inherited props)", function () {
              return notIqual(deepIncompleteClone, objectWithProtoInheritedProps);
            });
            it("_B.isExact true (strict references equality)", function () {
              return exact(deepIncompleteClone, objectWithProtoInheritedProps);
            });
            return it("_B.isIxact false (inherited props, scrict references equality)", function () {
              return notIxact(deepIncompleteClone, objectWithProtoInheritedProps);
            });
          });
          return describe("equality of deepInheritedClone, expectedPropertyValues", function () {
            it("_.isEqual false (soft equality, same values/JSON)", function () {
              return expect(_.isEqual(deepIncompleteClone, expectedPropertyValues)).to.be["false"];
            });
            it("_B.isEqual false (soft equality, same values/JSON)", function () {
              return notDeepEqual(deepIncompleteClone, expectedPropertyValues);
            });
            it("_B.isIqual false (inherited props)", function () {
              return notIqual(deepIncompleteClone, expectedPropertyValues);
            });
            it("_B.isExact false (strict references equality)", function () {
              return notExact(deepIncompleteClone, expectedPropertyValues);
            });
            return it("_B.isIxact false (inherited props, scrict references equality)", function () {
              return notIxact(deepIncompleteClone, expectedPropertyValues);
            });
          });
        });
      });
    });
  });
  return describe("with inherited:true :", function () {
    var deepCloneInheritedBlender;
    deepCloneInheritedBlender = new _B.DeepCloneBlender([], { inherited: true });
    describe("clones objectWithProtoInheritedProps (with inheritance)", function () {
      return describe("(deepInheritedClone = deepCloneInheritedBlender .blend {}, objectWithProtoInheritedProps)", function () {
        var deepInheritedClone;
        deepInheritedClone = deepCloneInheritedBlender.blend(objectWithProtoInheritedProps);
        return describe("is a complete deep clone, having deep cloned all inherited props as its own: ", function () {
          it("_B.isDisjoint true, has NO common references of all nested objects", function () {
            return expect(_B.isRefDisjoint(objectWithProtoInheritedProps, deepInheritedClone, {
              deep: true,
              inherited: true
            })).to.be["true"];
          });
          describe("equality of deepInheritedClone, objectWithProtoInheritedProps", function () {
            it("_.isEqual false (soft equality, not looking at inherited props of either)", function () {
              return expect(_.isEqual(deepInheritedClone, objectWithProtoInheritedProps)).to.be["false"];
            });
            it("_B.isEqual false (soft equality, not looking at inherited props of either)", function () {
              return notDeepEqual(deepInheritedClone, objectWithProtoInheritedProps);
            });
            it("_B.isIqual true (soft equality, inherited props)", function () {
              return iqual(deepInheritedClone, objectWithProtoInheritedProps);
            });
            it("_B.isExact false (strict references equality)", function () {
              return notExact(deepInheritedClone, objectWithProtoInheritedProps);
            });
            return it("_B.isIxact false (inherited props, scrict references equality)", function () {
              return notIxact(deepInheritedClone, objectWithProtoInheritedProps);
            });
          });
          return describe("equality of deepInheritedClone, expectedPropertyValues", function () {
            it("_.isEqual true (soft equality, all props are equal )", function () {
              return deepEqual(deepInheritedClone, expectedPropertyValues);
            });
            it("_B.isEqual true (soft equality, all props are equal)", function () {
              return deepEqual(deepInheritedClone, expectedPropertyValues);
            });
            it("_B.isIqual true (soft equality, inherited props, all props are equal)", function () {
              return iqual(deepInheritedClone, expectedPropertyValues);
            });
            it("_B.isExact false (strict references equality)", function () {
              return notExact(deepInheritedClone, expectedPropertyValues);
            });
            return it("_B.isIxact false (inherited props, scrict references equality)", function () {
              return notIxact(deepInheritedClone, expectedPropertyValues);
            });
          });
        });
      });
    });
    return describe("Using ['path'] orders in BlenderBehavior:", function () {
      var bi, blender, blenders, expected, i, len, o1, o2, results;
      blenders = [];
      blenders.push(new _B.DeepCloneBlender([{
          order: [
            "dst",
            "path",
            "src"
          ],
          String: {
            bundle: {
              basics: {
                "|": {
                  String: function (prop, src, dst, blender) {
                    return _B.Blender.SKIP;
                  }
                }
              }
            }
          }
        }], { isExactPath: false }));
      blenders.push(new _B.DeepCloneBlender([{
          order: [
            "path",
            "src",
            "dst"
          ],
          bundle: {
            basics: {
              "|": {
                String: {
                  String: function (prop, src, dst, blender) {
                    return _B.Blender.SKIP;
                  }
                }
              }
            }
          }
        }], { isExactPath: false }));
      blenders.push(new _B.DeepCloneBlender([{
          order: [
            "path",
            "src",
            "dst"
          ],
          "bundle : basics": {
            "|": {
              String: {
                String: function (prop, src, dst, blender) {
                  return _B.Blender.SKIP;
                }
              }
            }
          }
        }], { isExactPath: false }));
      blenders.push(new _B.DeepCloneBlender([{
          order: [
            "src",
            "dst",
            "path"
          ],
          String: {
            String: {
              " bundle: basics": {
                "|": function (prop, src, dst, blender) {
                  return _B.Blender.SKIP;
                }
              }
            }
          }
        }], { isExactPath: false }));
      blenders.push(new _B.DeepCloneBlender([{
          order: [
            "src",
            "dst",
            "path"
          ],
          String: {
            String: {
              bundle: {
                basics: {
                  "|": function (prop, src, dst, blender) {
                    return _B.Blender.SKIP;
                  }
                }
              }
            }
          }
        }], { isExactPath: false }));
      o1 = {
        bundle: {
          someOkString: "OLD String#1",
          someOkStrings: [
            "OLD [String]#1",
            "OLD [String]#2"
          ],
          basics: {
            newString2: 665,
            someObject: { skippedString: "OLD string #2" },
            skippedString: "OLD string #3",
            skippedStrings: [
              "OLD [String]#3",
              "OLD [String]#4"
            ],
            anIntAsString: "665",
            anInt: 8
          }
        }
      };
      o2 = {
        bundle: {
          someOkString: "OVERWRITTEN String#1",
          someOkStrings: [
            "OVERWRITTEN [String]#1",
            "OVERWRITTEN [String]#2"
          ],
          basics: {
            newString: "I am a OVERWRITTEN String, but on `undefined <-- String`, so I am ok!",
            newString2: "I am a OVERWRITTEN String, but on `Number <-- String`, so I am ok!",
            someObject: { skippedString: "SKIPed string #2" },
            skippedString: "SKIPed string #3",
            skippedStrings: [
              "SKIPed [String]#3",
              "SKIPed [String]#4"
            ],
            anIntAsString: 77,
            anInt: "18"
          }
        }
      };
      expected = {
        bundle: {
          someOkString: "OVERWRITTEN String#1",
          someOkStrings: [
            "OVERWRITTEN [String]#1",
            "OVERWRITTEN [String]#2"
          ],
          basics: {
            newString: "I am a OVERWRITTEN String, but on `undefined <-- String`, so I am ok!",
            newString2: "I am a OVERWRITTEN String, but on `Number <-- String`, so I am ok!",
            someObject: { skippedString: "OLD string #2" },
            skippedString: "OLD string #3",
            skippedStrings: [
              "OLD [String]#3",
              "OLD [String]#4"
            ],
            anIntAsString: 77,
            anInt: "18"
          }
        }
      };
      results = [];
      for (bi = i = 0, len = blenders.length; i < len; bi = ++i) {
        blender = blenders[bi];
        results.push(it("_.isEqual is true for blender #" + bi, function () {
          var result;
          result = blender.blend({}, o1, o2);
          return expect(_.isEqual(result, expected)).to.be["true"];
        }));
      }
      return results;
    });
  });
});

return module.exports;

});
}).call(this);