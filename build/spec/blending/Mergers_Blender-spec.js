// Generated by uRequire v0.3.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/Mergers_Blender-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var Class3, assert, c3, expect, expectedPropertyValues, objectWithProtoInheritedProps;

assert = chai.assert;

expect = chai.expect;

objectWithProtoInheritedProps = data.objectWithProtoInheritedProps, Class3 = data.Class3, c3 = data.c3, expectedPropertyValues = data.expectedPropertyValues;

describe("Default 'Blender.blend'", function() {
    describe("Default settings: with inherited:false, copyProto:false", function() {
        var defaultBlender;
        defaultBlender = new _B.Blender;
        describe("clones POJSO Object (no inheritance)", function() {
            return describe("(shallowClone = defaultBlender.blend {}, expectedPropertyValues)", function() {
                var shallowClone;
                shallowClone = defaultBlender.blend(expectedPropertyValues);
                return describe("is a shallow clone and compared to source: ", function() {
                    it("is not RefDisjoint - (there is at least one common reference))", function() {
                        return expect(_B.isRefDisjoint(shallowClone, expectedPropertyValues, {
                            deep: true,
                            inherited: true
                        })).to.be["false"];
                    });
                    it("has common references of all nested objects", function() {
                        var cRefs, sRefs;
                        sRefs = _B.getRefs(expectedPropertyValues, {
                            deep: true,
                            inherited: true
                        });
                        cRefs = _B.getRefs(shallowClone, {
                            deep: true,
                            inherited: true
                        });
                        return expect(_B.isEqualArraySet(sRefs, cRefs)).to.be["true"];
                    });
                    it("has a nested object copied by reference", function() {
                        expect(shallowClone.aProp1 === expectedPropertyValues.aProp1);
                        return expect(shallowClone.aProp1).to.not.be.an("undefined");
                    });
                    it("_.isEqual true (soft equality, same values/JSON)", function() {
                        return expect(_.isEqual(shallowClone, expectedPropertyValues)).to.be["true"];
                    });
                    it("_B.isEqual true (soft equality, same values/JSON)", function() {
                        return expect(_B.isEqual(shallowClone, expectedPropertyValues)).to.be["true"];
                    });
                    return it("_B.isExact true (strict references equality)", function() {
                        return expect(_B.isExact(shallowClone, expectedPropertyValues)).to.be["true"];
                    });
                });
            });
        });
        return describe("clones objectWithProtoInheritedProps (with inheritance)", function() {
            return describe("(shallowClone = defaultBlender.blend {}, objectWithProtoInheritedProps)", function() {
                var shallowIncompleteClone;
                shallowIncompleteClone = defaultBlender.blend({}, objectWithProtoInheritedProps);
                return describe("is an incomplete shallow clone, not copied inherited props: ", function() {
                    it("has NOT common references of all nested objects", function() {
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
                    it("has NOT copied inherited nested object", function() {
                        return expect(shallowIncompleteClone.aProp1 === void 0).to.be["true"];
                    });
                    it("_.isEqual true (soft equality, same values/JSON)", function() {
                        return expect(_.isEqual(shallowIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    it("_B.isEqual true (soft equality, same values/JSON)", function() {
                        return expect(_B.isEqual(shallowIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    it("_B.isExact true (strict references equality, no inherited props)", function() {
                        return expect(_B.isExact(shallowIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    it("_B.isIqual false (inherited props, soft object equality)", function() {
                        return expect(!_B.isIqual(shallowIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    return it("_B.isIxact false (inherited props equality + strict references equality)", function() {
                        return expect(!_B.isIxact(shallowIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                    });
                });
            });
        });
    });
    describe("Default 'Blender.blend' with inherited:true", function() {
        var defaultBlenderInheritedCopier;
        defaultBlenderInheritedCopier = new _B.Blender([], {
            inherited: true
        });
        return describe("clones objectWithProtoInheritedProps (with inheritance)", function() {
            return describe("(shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend {}, objectWithProtoInheritedProps)", function() {
                var shallowCloneInheritedCopied;
                shallowCloneInheritedCopied = defaultBlenderInheritedCopier.blend(objectWithProtoInheritedProps);
                return describe("is a complete shallow clone, having shallow copied all inherited props: ", function() {
                    it("has common references of all nested objects", function() {
                        var cRefs, sRefs;
                        sRefs = _B.getRefs(objectWithProtoInheritedProps, {
                            deep: true,
                            inherited: true
                        });
                        cRefs = _B.getRefs(shallowCloneInheritedCopied, {
                            deep: true,
                            inherited: true
                        });
                        return expect(_B.isEqualArraySet(sRefs, cRefs)).to.be["true"];
                    });
                    it("has copied inherited nested object", function() {
                        expect(shallowCloneInheritedCopied.aProp1).to.equal(objectWithProtoInheritedProps.aProp1);
                        return expect(shallowCloneInheritedCopied.aProp1).to.not.be.an("undefined");
                    });
                    it("_.isEqual is false (soft equality, not looking at inherited props of source)", function() {
                        return expect(_.isEqual(shallowCloneInheritedCopied, objectWithProtoInheritedProps)).to.be["false"];
                    });
                    it("_B.isEqual is false (soft equality, not looking at inherited props of source)", function() {
                        return expect(_B.isEqual(shallowCloneInheritedCopied, objectWithProtoInheritedProps)).to.be["false"];
                    });
                    it("_B.isExact is false (strict references equality, no inherited props of source)", function() {
                        return expect(_B.isExact(shallowCloneInheritedCopied, objectWithProtoInheritedProps)).to.be["false"];
                    });
                    it("_B.isIqual is true (inherited props, soft object equality)", function() {
                        return expect(_B.isIqual(shallowCloneInheritedCopied, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    return it("_B.isIxact true (inherited props, strict references equality)", function() {
                        return expect(_B.isIxact(shallowCloneInheritedCopied, objectWithProtoInheritedProps)).to.be["true"];
                    });
                });
            });
        });
    });
    return describe("Default 'Blender.blend' with copyProto:true", function() {
        var defaultBlenderProtoCopier;
        defaultBlenderProtoCopier = new _B.Blender([], {
            copyProto: true
        });
        return describe("clones objectWithProtoInheritedProps (with inheritance)", function() {
            return describe("(shallowClone = defaultBlenderProtoCopier.blend {}, objectWithProtoInheritedProps)", function() {
                var shallowCloneProtoCopied;
                shallowCloneProtoCopied = defaultBlenderProtoCopier.blend({}, objectWithProtoInheritedProps);
                return describe("is a complete shallow clone, having shallow copied only own props & __proto__: ", function() {
                    it("has ALL common references of all nested objects", function() {
                        var cRefs, sRefs;
                        sRefs = _B.getRefs(objectWithProtoInheritedProps, {
                            deep: true,
                            inherited: true
                        });
                        cRefs = _B.getRefs(shallowCloneProtoCopied, {
                            deep: true,
                            inherited: true
                        });
                        return expect(_B.isEqualArraySet(sRefs, cRefs)).to.be["true"];
                    });
                    it("has not copied inherited nested object, but can access it through __proto__ inheritance", function() {
                        expect(shallowCloneProtoCopied.aProp1).to.equal(objectWithProtoInheritedProps.aProp1);
                        expect(shallowCloneProtoCopied.aProp1).to.not.be.an("undefined");
                        expect(objectWithProtoInheritedProps.hasOwnProperty("aProp1")).to.be["false"];
                        return expect(shallowCloneProtoCopied.hasOwnProperty("aProp1")).to.be["false"];
                    });
                    it("_.isEqual is true (soft equality, not looking at inherited props of either)", function() {
                        return expect(_.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    it("_B.isEqual is true (soft equality, not looking at inherited props of either)", function() {
                        return expect(_B.isEqual(shallowCloneProtoCopied, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    it("_B.isExact is true (strict references equality, no inherited props of either)", function() {
                        return expect(_B.isExact(shallowCloneProtoCopied, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    it("_B.isIqual is true (inherited props, soft object equality)", function() {
                        return expect(_B.isIqual(shallowCloneProtoCopied, objectWithProtoInheritedProps)).to.be["true"];
                    });
                    return it("_B.isIxact true (inherited props, strict references equality)", function() {
                        return expect(_B.isIxact(shallowCloneProtoCopied, objectWithProtoInheritedProps)).to.be["true"];
                    });
                });
            });
        });
    });
});

describe("DeepCloneBlender .blend:", function() {
    describe("Default settings: with inherited:false, copyProto:false", function() {
        var deepCloneBlender;
        deepCloneBlender = new _B.DeepCloneBlender;
        describe("clones POJSO Object (no inheritance)", function() {
            return describe("(deepClone = deepCloneBlender.blend {}, expectedPropertyValues)", function() {
                var deepClone;
                deepClone = deepCloneBlender.blend(expectedPropertyValues);
                return describe("is a deep clone", function() {
                    it("_B.isDisjoint true, NO common references in objects", function() {
                        return expect(_B.isRefDisjoint(deepClone, expectedPropertyValues, {
                            deep: true,
                            inherited: true
                        })).to.be["true"];
                    });
                    it("nested object is a clone it self - NOT the same reference", function() {
                        return expect(deepClone.aProp1).to.not.equal(expectedPropertyValues.aProp1);
                    });
                    it("_.isEqual true (soft equality, same values/JSON)", function() {
                        return expect(_.isEqual(deepClone, expectedPropertyValues)).to.be["true"];
                    });
                    it("_B.isEqual true (soft equality, same values/JSON)", function() {
                        return expect(_B.isEqual(deepClone, expectedPropertyValues)).to.be["true"];
                    });
                    return it("_B.isExact is false (strict references equality)", function() {
                        return expect(_B.isExact(deepClone, expectedPropertyValues)).to.be["false"];
                    });
                });
            });
        });
        return describe("clones objectWithProtoInheritedProps (with inheritance)", function() {
            return describe("(deepIncompleteClone = deepCloneBlender.blend {}, objectWithProtoInheritedProps)", function() {
                var deepIncompleteClone;
                deepIncompleteClone = deepCloneBlender.blend({}, objectWithProtoInheritedProps);
                return describe("is an incomplete deep clone, not copied inherited props: ", function() {
                    it("_B.isDisjoint true, has NO common references of all nested objects", function() {
                        return expect(_B.isRefDisjoint(objectWithProtoInheritedProps, deepIncompleteClone, {
                            deep: true,
                            inherited: true
                        })).to.be["true"];
                    });
                    it("has NOT copied inherited nested object", function() {
                        return expect(deepIncompleteClone.aProp1).to.be.an("undefined");
                    });
                    describe("equality of deepIncompleteClone, objectWithProtoInheritedProps", function() {
                        it("_.isEqual true (soft equality, same values/JSON)", function() {
                            return expect(_.isEqual(deepIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                        });
                        it("_B.isEqual true (soft equality, same values/JSON)", function() {
                            return expect(_B.isEqual(deepIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                        });
                        it("_B.isIqual false (inherited props)", function() {
                            return expect(_B.isIqual(deepIncompleteClone, objectWithProtoInheritedProps)).to.be["false"];
                        });
                        it("_B.isExact true (strict references equality)", function() {
                            return expect(_B.isExact(deepIncompleteClone, objectWithProtoInheritedProps)).to.be["true"];
                        });
                        return it("_B.isIxact false (inherited props, scrict references equality)", function() {
                            return expect(_B.isIxact(deepIncompleteClone, objectWithProtoInheritedProps)).to.be["false"];
                        });
                    });
                    return describe("equality of deepInheritedClone, expectedPropertyValues", function() {
                        it("_.isEqual false (soft equality, same values/JSON)", function() {
                            return expect(_.isEqual(deepIncompleteClone, expectedPropertyValues)).to.be["false"];
                        });
                        it("_B.isEqual false (soft equality, same values/JSON)", function() {
                            return expect(_B.isEqual(deepIncompleteClone, expectedPropertyValues)).to.be["false"];
                        });
                        it("_B.isIqual false (inherited props)", function() {
                            return expect(_B.isIqual(deepIncompleteClone, expectedPropertyValues)).to.be["false"];
                        });
                        it("_B.isExact false (strict references equality)", function() {
                            return expect(_B.isExact(deepIncompleteClone, expectedPropertyValues)).to.be["false"];
                        });
                        return it("_B.isIxact false (inherited props, scrict references equality)", function() {
                            return expect(_B.isIxact(deepIncompleteClone, expectedPropertyValues)).to.be["false"];
                        });
                    });
                });
            });
        });
    });
    return describe("with inherited:true :", function() {
        var deepCloneInheritedBlender;
        deepCloneInheritedBlender = new _B.DeepCloneBlender([], {
            inherited: true
        });
        describe("clones objectWithProtoInheritedProps (with inheritance)", function() {
            return describe("(deepInheritedClone = deepCloneInheritedBlender .blend {}, objectWithProtoInheritedProps)", function() {
                var deepInheritedClone;
                deepInheritedClone = deepCloneInheritedBlender.blend({}, objectWithProtoInheritedProps);
                return describe("is a complete deep clone, having deep cloned all inherited props as its own: ", function() {
                    it("_B.isDisjoint true, has NO common references of all nested objects", function() {
                        return expect(_B.isRefDisjoint(objectWithProtoInheritedProps, deepInheritedClone, {
                            deep: true,
                            inherited: true
                        })).to.be["true"];
                    });
                    describe("equality of deepInheritedClone, objectWithProtoInheritedProps", function() {
                        it("_.isEqual false (soft equality, not looking at inherited props of either)", function() {
                            return expect(_.isEqual(deepInheritedClone, objectWithProtoInheritedProps)).to.be["false"];
                        });
                        it("_B.isEqual false (soft equality, not looking at inherited props of either)", function() {
                            return expect(_B.isEqual(deepInheritedClone, objectWithProtoInheritedProps)).to.be["false"];
                        });
                        it("_B.isIqual true (soft equality, inherited props)", function() {
                            return expect(_B.isIqual(deepInheritedClone, objectWithProtoInheritedProps)).to.be["true"];
                        });
                        it("_B.isExact false (strict references equality)", function() {
                            return expect(_B.isExact(deepInheritedClone, objectWithProtoInheritedProps)).to.be["false"];
                        });
                        return it("_B.isIxact false (inherited props, scrict references equality)", function() {
                            return expect(_B.isIxact(deepInheritedClone, objectWithProtoInheritedProps)).to.be["false"];
                        });
                    });
                    return describe("equality of deepInheritedClone, expectedPropertyValues", function() {
                        it("_.isEqual true (soft equality, all props are equal )", function() {
                            return expect(_.isEqual(deepInheritedClone, expectedPropertyValues)).to.be["true"];
                        });
                        it("_B.isEqual true (soft equality, all props are equal)", function() {
                            return expect(_B.isEqual(deepInheritedClone, expectedPropertyValues)).to.be["true"];
                        });
                        it("_B.isIqual true (soft equality, inherited props, all props are equal)", function() {
                            return expect(_B.isIqual(deepInheritedClone, expectedPropertyValues)).to.be["true"];
                        });
                        it("_B.isExact false (strict references equality)", function() {
                            return expect(_B.isExact(deepInheritedClone, expectedPropertyValues)).to.be["false"];
                        });
                        return it("_B.isIxact false (inherited props, scrict references equality)", function() {
                            return expect(_B.isIxact(deepInheritedClone, expectedPropertyValues)).to.be["false"];
                        });
                    });
                });
            });
        });
        return describe("Using ['path'] orders in BlenderBehavior:", function() {
            var bi, blender, blenders, expected, o1, o2, _i, _len, _results;
            blenders = [];
            blenders.push(new _B.DeepCloneBlender([ {
                order: [ "dst", "path", "src" ],
                String: {
                    bundle: {
                        basics: {
                            "|": {
                                String: function(prop, src, dst, blender) {
                                    return _B.Blender.SKIP;
                                }
                            }
                        }
                    }
                }
            } ], {
                isExactPath: false
            }));
            blenders.push(new _B.DeepCloneBlender([ {
                order: [ "path", "src", "dst" ],
                bundle: {
                    basics: {
                        "|": {
                            String: {
                                String: function(prop, src, dst, blender) {
                                    return _B.Blender.SKIP;
                                }
                            }
                        }
                    }
                }
            } ], {
                isExactPath: false
            }));
            blenders.push(new _B.DeepCloneBlender([ {
                order: [ "path", "src", "dst" ],
                "bundle : basics": {
                    "|": {
                        String: {
                            String: function(prop, src, dst, blender) {
                                return _B.Blender.SKIP;
                            }
                        }
                    }
                }
            } ], {
                isExactPath: false
            }));
            blenders.push(new _B.DeepCloneBlender([ {
                order: [ "src", "dst", "path" ],
                String: {
                    String: {
                        " bundle: basics": {
                            "|": function(prop, src, dst, blender) {
                                return _B.Blender.SKIP;
                            }
                        }
                    }
                }
            } ], {
                isExactPath: false
            }));
            blenders.push(new _B.DeepCloneBlender([ {
                order: [ "src", "dst", "path" ],
                String: {
                    String: {
                        bundle: {
                            basics: {
                                "|": function(prop, src, dst, blender) {
                                    return _B.Blender.SKIP;
                                }
                            }
                        }
                    }
                }
            } ], {
                isExactPath: false
            }));
            o1 = {
                bundle: {
                    someOkString: "OLD String#1",
                    someOkStrings: [ "OLD [String]#1", "OLD [String]#2" ],
                    basics: {
                        newString2: 665,
                        someObject: {
                            skippedString: "OLD string #2"
                        },
                        skippedString: "OLD string #3",
                        skippedStrings: [ "OLD [String]#3", "OLD [String]#4" ],
                        anIntAsString: "665",
                        anInt: 8
                    }
                }
            };
            o2 = {
                bundle: {
                    someOkString: "OVERWRITTEN String#1",
                    someOkStrings: [ "OVERWRITTEN [String]#1", "OVERWRITTEN [String]#2" ],
                    basics: {
                        newString: "I am a OVERWRITTEN String, but on `undefined <-- String`, so I am ok!",
                        newString2: "I am a OVERWRITTEN String, but on `Number <-- String`, so I am ok!",
                        someObject: {
                            skippedString: "SKIPed string #2"
                        },
                        skippedString: "SKIPed string #3",
                        skippedStrings: [ "SKIPed [String]#3", "SKIPed [String]#4" ],
                        anIntAsString: 77,
                        anInt: "18"
                    }
                }
            };
            expected = {
                bundle: {
                    someOkString: "OVERWRITTEN String#1",
                    someOkStrings: [ "OVERWRITTEN [String]#1", "OVERWRITTEN [String]#2" ],
                    basics: {
                        newString: "I am a OVERWRITTEN String, but on `undefined <-- String`, so I am ok!",
                        newString2: "I am a OVERWRITTEN String, but on `Number <-- String`, so I am ok!",
                        someObject: {
                            skippedString: "OLD string #2"
                        },
                        skippedString: "OLD string #3",
                        skippedStrings: [ "OLD [String]#3", "OLD [String]#4" ],
                        anIntAsString: 77,
                        anInt: "18"
                    }
                }
            };
            _results = [];
            for (bi = _i = 0, _len = blenders.length; _i < _len; bi = ++_i) {
                blender = blenders[bi];
                _results.push(it("_.isEqual is true for blender #" + bi, function() {
                    var result;
                    result = blender.blend({}, o1, o2);
                    return expect(_.isEqual(result, expected)).to.be["true"];
                }));
            }
            return _results;
        });
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();