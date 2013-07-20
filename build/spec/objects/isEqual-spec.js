// Generated by uRequire v0.5.0beta1
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('objects/isEqual-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var Class3, assert, c3, c3Clone, expect, expectedPropertyValues, inheritedDeepClone, inheritedShallowClone, oClone, object, objectDeepClone1, objectDeepClone2, objectShallowClone1, objectShallowClone2, objectWithProtoInheritedProps;

assert = chai.assert;

expect = chai.expect;

objectWithProtoInheritedProps = data.objectWithProtoInheritedProps, Class3 = data.Class3, c3 = data.c3, expectedPropertyValues = data.expectedPropertyValues, object = data.object, objectShallowClone1 = data.objectShallowClone1, objectShallowClone2 = data.objectShallowClone2, objectDeepClone1 = data.objectDeepClone1, objectDeepClone2 = data.objectDeepClone2, inheritedShallowClone = data.inheritedShallowClone, inheritedDeepClone = data.inheritedDeepClone;

oClone = _.clone(objectWithProtoInheritedProps);

c3Clone = _.clone(c3);

describe("isEqual:", function() {
    describe("lodash _.isEqual tests on _B.isEqual:", function() {
        it("should work with `arguments` objects (test in IE < 9)", function() {
            var args1, args2, args3;
            args1 = function() {
                return arguments;
            }(1, 2, 3);
            args2 = function() {
                return arguments;
            }(1, 2, 3);
            args3 = function() {
                return arguments;
            }(1, 2);
            expect(_B.isEqual(args1, args2)).to.be["true"];
            return expect(_B.isEqual(args1, args3)).to.be["false"];
        });
        it("should return `false` when comparing values with circular references to unlike values", function() {
            var array1, array2, object1, object2;
            array1 = [ "a", null, "c" ];
            array2 = [ "a", [], "c" ];
            object1 = {
                a: 1,
                b: null,
                c: 3
            };
            object2 = {
                a: 1,
                b: {},
                c: 3
            };
            array1[1] = array1;
            expect(_B.isEqual(array1, array2)).to.be["false"];
            object1.b = object1;
            return expect(_B.isEqual(object1, object2)).to.be["false"];
        });
        it("should pass the correct `callback` arguments", function() {
            var args;
            args = void 0;
            _B.isEqual("a", "b", function() {
                return args || (args = [].slice.call(arguments));
            });
            return expect(args).to.be.deep.equal([ "a", "b" ]);
        });
        it("should correct set the `this` binding", function() {
            var actual;
            actual = _B.isEqual("a", "b", function(a, b) {
                return this[a] === this[b];
            }, {
                a: 1,
                b: 1
            });
            return expect(actual).to.be["true"];
        });
        it("should handle comparisons if `callback` returns `undefined`", function() {
            var actual;
            actual = _B.isEqual("a", "a", function() {});
            return expect(actual).to.be["true"];
        });
        return it("should return a boolean value even if `callback` does not", function() {
            var actual;
            actual = _B.isEqual("a", "a", function() {
                return "a";
            });
            expect(actual).to.be["true"];
            return _.each([ "", 0, false, NaN, null, void 0 ], function(value) {
                actual = _B.isEqual("a", "b", function() {
                    return value;
                });
                return expect(actual).to.be["false"];
            });
        });
    });
    describe("rudimentary checks:", function() {
        describe("primitives:", function() {
            it("one undefined", function() {
                expect(_B.isEqual(void 0, objectWithProtoInheritedProps)).to.be["false"];
                return expect(_B.isEqual(objectWithProtoInheritedProps, void 0)).to.be["false"];
            });
            it("one null", function() {
                expect(_B.isEqual(null, objectWithProtoInheritedProps)).to.be["false"];
                return expect(_B.isEqual(objectWithProtoInheritedProps, null)).to.be["false"];
            });
            it("both undefined/null", function() {
                expect(_B.isEqual(void 0, void 0)).to.be["true"];
                return expect(_B.isEqual(null, null)).to.be["true"];
            });
            it("one undefined, other null", function() {
                expect(_B.isEqual(null, void 0)).to.be["false"];
                return expect(_B.isEqual(void 0, null)).to.be["false"];
            });
            it("Number", function() {
                expect(_B.isEqual(111, 111)).to.be["true"];
                expect(_B.isEqual(111.002, 111.002)).to.be["true"];
                expect(_B.isEqual(112, 111)).to.be["false"];
                return expect(_B.isEqual(111.002, 111.003)).to.be["false"];
            });
            describe("String", function() {
                it('as primitive ""', function() {
                    expect(_B.isEqual("AAA 111", "AAA 111")).to.be["true"];
                    return expect(_B.isEqual("AAA 112", "AAA 111")).to.be["false"];
                });
                return it("as String Object", function() {
                    expect(_B.isEqual(new String("AAA 111"), "AAA 111")).to.be["true"];
                    expect(_B.isEqual("AAA 111", new String("AAA 111"))).to.be["true"];
                    expect(_B.isEqual(new String("AAA 111"), new String("AAA 111"))).to.be["true"];
                    expect(_B.isEqual("AAA 112", new String("AAA 111"))).to.be["false"];
                    expect(_B.isEqual(new String("AAA 112"), "AAA 111")).to.be["false"];
                    return expect(_B.isEqual(new String("AAA 112"), new String("AAA 111"))).to.be["false"];
                });
            });
            it("Date", function() {
                expect(_B.isEqual(new Date("2012/12/12"), new Date("2012/12/12"))).to.be["true"];
                return expect(_B.isEqual(new Date("2012/12/13"), new Date("2012/12/12"))).to.be["false"];
            });
            it("RegExp", function() {
                expect(_B.isEqual(/abc/, /abc/)).to.be["true"];
                return expect(_B.isEqual(/abcd/, /abc/)).to.be["false"];
            });
            describe("Boolean", function() {
                it("as primitive", function() {
                    expect(_B.isEqual(true, true)).to.be["true"];
                    return expect(_B.isEqual(true, false)).to.be["false"];
                });
                return it("as Boolean {}", function() {
                    expect(_B.isEqual(new Boolean(true), true)).to.be["true"];
                    expect(_B.isEqual(new Boolean(true), false)).to.be["false"];
                    return expect(_B.isEqual(false, new Boolean(false))).to.be["true"];
                });
            });
            return describe("Mixed primitives", function() {
                it("boolean truthys", function() {
                    expect(_B.isEqual(true, 1)).to.be["false"];
                    return expect(_B.isEqual(true, "a string")).to.be["false"];
                });
                return it("boolean falsys", function() {
                    expect(_B.isEqual(false, 0)).to.be["false"];
                    return expect(_B.isEqual(false, "")).to.be["false"];
                });
            });
        });
        describe("Simple Objects & all functions", function() {
            it("empty objects & arrays", function() {
                expect(_B.isEqual([], [])).to.be["true"];
                expect(_B.isEqual({}, {})).to.be["true"];
                return expect(_B.isEqual({}, [])).to.be["false"];
            });
            return it("functions, with/without props", function() {
                var f1, f2;
                f1 = function() {};
                f2 = function() {};
                expect(_B.isEqual(f1, f2)).to.be["false"];
                expect(_B.isExact(f1, f2)).to.be["false"];
                expect(_B.isIqual(f1, f2)).to.be["false"];
                f1.p = "a";
                f2.p = "a";
                expect(_B.isEqual(f1, f2)).to.be["false"];
                expect(_B.isExact(f1, f2)).to.be["false"];
                return expect(_B.isIqual(f1, f2)).to.be["false"];
            });
        });
        return describe("callback:", function() {
            return it("returns true", function() {
                return expect(_B.isEqual(111, "111", function(a, b) {
                    return a + "" === b + "";
                })).to.be["true"];
            });
        });
    });
    describe("options.inherited - Objects with inherited properties:", function() {
        describe("object with __proro__ inherited properties:", function() {
            it("_B.isEqual is true", function() {
                expect(_B.isEqual(objectWithProtoInheritedProps, expectedPropertyValues, void 0, void 0, {
                    inherited: true
                })).to.be["true"];
                return expect(_B.isEqual(expectedPropertyValues, objectWithProtoInheritedProps, void 0, void 0, {
                    inherited: true
                })).to.be["true"];
            });
            it("_.isEqual fails", function() {
                expect(_.isEqual(objectWithProtoInheritedProps, expectedPropertyValues)).to.be["false"];
                return expect(_.isEqual(expectedPropertyValues, objectWithProtoInheritedProps)).to.be["false"];
            });
            describe("with _.clone: ", function() {
                it("_B.isIqual fails (imperfect _.clone)", function() {
                    expect(_B.isIqual(oClone, expectedPropertyValues)).to.be["false"];
                    return expect(_B.isIqual(expectedPropertyValues, oClone)).to.be["false"];
                });
                return it("_.isEqual fails", function() {
                    expect(_.isEqual(oClone, expectedPropertyValues)).to.be["false"];
                    return expect(_.isEqual(expectedPropertyValues, oClone)).to.be["false"];
                });
            });
            return describe("with _B.clone proto: ", function() {
                var oCloneProto;
                oCloneProto = _.clone(objectWithProtoInheritedProps);
                oCloneProto.__proto__ = objectWithProtoInheritedProps.__proto__;
                it("_B.isIqual succeeds (a perfect clone:-)", function() {
                    expect(_B.isIqual(oCloneProto, expectedPropertyValues)).to.be["true"];
                    return expect(_B.isIqual(expectedPropertyValues, oCloneProto)).to.be["true"];
                });
                return it("_.isEqual still fails", function() {
                    expect(_.isEqual(oCloneProto, expectedPropertyValues)).to.be["false"];
                    return expect(_.isEqual(expectedPropertyValues, oCloneProto)).to.be["false"];
                });
            });
        });
        return describe("coffeescript object with inherited properties:", function() {
            it("_B.isEqual is true", function() {
                expect(_B.isEqual(c3, expectedPropertyValues, {
                    inherited: true
                })).to.be["true"];
                return expect(_B.isIqual(expectedPropertyValues, c3)).to.be["true"];
            });
            it("_.isEqual fails", function() {
                expect(_.isEqual(c3, expectedPropertyValues)).to.be["false"];
                return expect(_.isEqual(expectedPropertyValues, c3)).to.be["false"];
            });
            describe("with _.clone:", function() {
                it("_B.isIqual fails (imperfect _.clone)", function() {
                    expect(_B.isEqual(c3Clone, expectedPropertyValues, void 0, void 0, {
                        inherited: true
                    })).to.be["false"];
                    return expect(_B.isIqual(expectedPropertyValues, c3Clone)).to.be["false"];
                });
                return it("_.isEqual fails", function() {
                    expect(_.isEqual(c3Clone, expectedPropertyValues)).to.be["false"];
                    return expect(_.isEqual(expectedPropertyValues, c3Clone)).to.be["false"];
                });
            });
            return describe("with _.clone proto: ", function() {
                var c3CloneProto;
                c3CloneProto = _.clone(c3);
                c3CloneProto.__proto__ = c3.__proto__;
                it("_B.isIqual is true", function() {
                    expect(_B.isEqual(c3CloneProto, expectedPropertyValues, void 0, void 0, {
                        inherited: true
                    })).to.be["true"];
                    return expect(_B.isIqual(expectedPropertyValues, c3CloneProto)).to.be["true"];
                });
                return it("_.isEqual fails", function() {
                    expect(_.isEqual(c3CloneProto, expectedPropertyValues)).to.be["false"];
                    return expect(_.isEqual(expectedPropertyValues, c3CloneProto)).to.be["false"];
                });
            });
        });
    });
    return describe("options.exact (Objects need to have exact refs) :", function() {
        describe("shallow cloned objects :", function() {
            it("_B.isExact(object, objectShallowClone1) is true", function() {
                expect(_B.isEqual(object, objectShallowClone1, void 0, void 0, {
                    exact: true
                })).to.be["true"];
                return expect(_B.isExact(objectShallowClone1, object)).to.be["true"];
            });
            it("_B.isExact(object, objectShallowClone2) with _.clone(object) is true", function() {
                expect(_B.isEqual(object, objectShallowClone2, {
                    exact: true
                })).to.be["true"];
                return expect(_B.isExact(objectShallowClone2, object)).to.be["true"];
            });
            return it("_.isEqual(object, shallowClone1 & 2) gives true", function() {
                expect(_.isEqual(object, objectShallowClone1)).to.be["true"];
                return expect(_.isEqual(object, objectShallowClone2)).to.be["true"];
            });
        });
        describe("deeply cloned objects:", function() {
            describe("objectDeepClone1 with hand configured __proto__:", function() {
                it("_B.isExact is false", function() {
                    expect(_B.isEqual(object, objectDeepClone1, {
                        exact: true
                    })).to.be["false"];
                    return expect(_B.isExact(objectDeepClone1, object)).to.be["false"];
                });
                return it("_B.isEqual is true", function() {
                    expect(_B.isEqual(object, objectDeepClone1)).to.be["true"];
                    return expect(_B.isEqual(objectDeepClone1, object)).to.be["true"];
                });
            });
            describe("objectDeepClone2 = _.clone(object):", function() {
                it("_B.isExact is false", function() {
                    expect(_B.isEqual(object, objectDeepClone2, void 0, void 0, {
                        exact: true
                    })).to.be["false"];
                    return expect(_B.isExact(objectDeepClone2, object)).to.be["false"];
                });
                return it("_B.isEqual is true", function() {
                    expect(_B.isEqual(object, objectDeepClone2)).to.be["true"];
                    return expect(_B.isEqual(objectDeepClone2, object)).to.be["true"];
                });
            });
            return it("_.isEqual(object, objectDeepClone1 & 2) gives true", function() {
                expect(_.isEqual(object, objectDeepClone1)).to.be["true"];
                return expect(_.isEqual(object, objectDeepClone2)).to.be["true"];
            });
        });
        return describe("isIxact : isEqual with inherited & exact :", function() {
            describe("shallow inherited clone: inheritedShallowClone:", function() {
                it("isIxact is true:", function() {
                    return expect(_B.isIxact(inheritedShallowClone, object)).to.be["true"];
                });
                return it("isIqual is true:", function() {
                    return expect(_B.isIqual(object, inheritedShallowClone)).to.be["true"];
                });
            });
            return describe("deep inherited clone : inheritedDeepClone:", function() {
                it("isIxact is true:", function() {
                    return expect(_B.isIxact(inheritedDeepClone, object)).to.be["false"];
                });
                return it("isIqual is true:", function() {
                    return expect(_B.isIqual(object, inheritedDeepClone)).to.be["true"];
                });
            });
        });
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();