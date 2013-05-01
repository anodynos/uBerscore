// Generated by uRequire v{NO_VERSION}
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('blending/DeepDefaultsBlender-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('chai'), nr.require('lodash'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'chai', 'lodash', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, chai, _, _B, data) {
  // uRequire: start body of original nodejs module
var Class3, assert, bundle, bundle_project_team, c3, earth, earth_laboratory_experiment, expect, expectedPropertyValues, experiment, experiment_laboratory_earth, laboratory, laboratory_experiment, objectWithProtoInheritedProps, project, team;

if (typeof chai !== "undefined" && chai !== null) {
    assert = chai.assert;
    expect = chai.expect;
    objectWithProtoInheritedProps = data.objectWithProtoInheritedProps, Class3 = data.Class3, c3 = data.c3, expectedPropertyValues = data.expectedPropertyValues, project = data.project, team = data.team, bundle = data.bundle, bundle_project_team = data.bundle_project_team, earth = data.earth, laboratory = data.laboratory, experiment = data.experiment, earth_laboratory_experiment = data.earth_laboratory_experiment, experiment_laboratory_earth = data.experiment_laboratory_earth, laboratory_experiment = data.laboratory_experiment;
}

describe("Defaults: The DeepDefaultsBlender, overwritting only null/undefined & merging all nested types", function() {
    describe("Default settings:", function() {
        var deepDefaultsBlender;
        deepDefaultsBlender = new _B.DeepDefaultsBlender;
        describe("bundle, project, team", function() {
            var result;
            result = deepDefaultsBlender.blend({}, bundle, project, team);
            it("_.isEqual result, bundle_project_team", function() {
                return expect(_.isEqual(result, bundle_project_team));
            });
            return it("_.isRefDisjoint result with each of bundle, project, team", function() {
                var o, _i, _len, _ref, _results;
                _ref = [ bundle, project, team ];
                _results = [];
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    o = _ref[_i];
                    _results.push(expect(_B.isRefDisjoint(result, o)));
                }
                return _results;
            });
        });
        describe("earth, laboratory, experiment", function() {
            var result;
            result = deepDefaultsBlender.blend({}, earth, laboratory, experiment);
            it("_.isEqual result, earth_laboratory_experiment", function() {
                return expect(_.isEqual(result, earth_laboratory_experiment));
            });
            return it("_.isRefDisjoint result with each of earth, laboratory, experiment", function() {
                var o, _i, _len, _ref, _results;
                _ref = [ bundle, project, team ];
                _results = [];
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    o = _ref[_i];
                    _results.push(expect(_B.isRefDisjoint(result, o)));
                }
                return _results;
            });
        });
        describe("experiment, laboratory, earth", function() {
            var result;
            result = deepDefaultsBlender.blend({}, experiment, laboratory, earth);
            it("_.isEqual result, experiment_laboratory_earth", function() {
                return expect(_.isEqual(result, experiment_laboratory_earth));
            });
            return it("_.isRefDisjoint result with each of experiment, laboratory, earth", function() {
                var o, _i, _len, _ref, _results;
                _ref = [ experiment, laboratory, earth ];
                _results = [];
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    o = _ref[_i];
                    _results.push(expect(_B.isRefDisjoint(result, o)));
                }
                return _results;
            });
        });
        return describe("laboratory, experiment", function() {
            var result;
            result = deepDefaultsBlender.blend({}, laboratory, experiment);
            it("_.isEqual result, laboratory_experiment", function() {
                return expect(_.isEqual(result, laboratory_experiment));
            });
            return it("_.isRefDisjoint result with each of laboratory, experiment", function() {
                var o, _i, _len, _ref, _results;
                _ref = [ laboratory, experiment ];
                _results = [];
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    o = _ref[_i];
                    _results.push(expect(_B.isRefDisjoint(result, o)));
                }
                return _results;
            });
        });
    });
    return describe("Using path in BlenderBehavior.order: ", function() {
        var peopleUniqueBlender, result;
        peopleUniqueBlender = new _B.DeepDefaultsBlender({
            order: [ "src", "path" ],
            Array: {
                life: {
                    people: {
                        "|": function(prop, src, dst, blender) {
                            var foundPerson, person, _i, _len, _ref;
                            _ref = src[prop];
                            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                                person = _ref[_i];
                                if (!_.isArray(dst[prop])) {
                                    dst[prop] = [];
                                } else {
                                    foundPerson = _.find(dst[prop], function(v) {
                                        return v.name === person.name;
                                    });
                                }
                                if (!foundPerson) {
                                    dst[prop].push(person);
                                } else {
                                    _.extend(foundPerson, person);
                                }
                            }
                            return dst[prop];
                        }
                    }
                }
            }
        });
        result = peopleUniqueBlender.blend(laboratory, experiment);
        return it("_.isEqual result, laboratory_experiment", function() {
            return expect(_.isEqual(result, {
                name: "laboratoryDefaults",
                environment: {
                    temperature: 35,
                    moisture: {
                        max: 40
                    },
                    gravity: 1.5
                },
                life: {
                    races: [ "Caucasian", "African", "Asian", "Mutant" ],
                    people: [ {
                        name: "moe",
                        age: 400
                    }, {
                        name: "larry",
                        age: 500
                    }, {
                        name: "blanka",
                        age: 20
                    }, {
                        name: "ken",
                        age: 25
                    }, {
                        name: "ryu",
                        age: 28
                    } ]
                },
                results: {
                    success: false
                }
            }));
        });
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();