// Generated by uRequire v0.7.0-beta.25 target: 'spec' template: 'UMDplain'
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;

var extend = function (child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key))
        child[key] = parent[key];
    }
    function ctor() {
      this.constructor = child;
    }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  }, hasProp = {}.hasOwnProperty;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('./specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', './specHelpers'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('spec-data.js');

var Class0, Class1, Class2, Class3, c3, earth, earth_laboratory_experiment, expectedPropertyValues, experiment, experiment_laboratory_earth, inheritedDeepClone, inheritedDeepCloneParent, inheritedShallowClone, inheritedShallowCloneParent, laboratory, laboratory_experiment, object, object1, object2, object3, objectDeepClone1, objectDeepClone2, objectShallowClone1, objectShallowClone2, objectWithProtoInheritedProps, prop1;
  prop1 = {
    "aProp1.1": "o1.aVal1.1",
    "aProp1.2": "o1.aVal1.2"
  };
  object1 = { aProp2: "o1.aVal2" };
  object1.aProp1 = Object.create(prop1);
  object2 = Object.create(object1);
  object2.aProp2 = "o2.aVal2-1";
  object3 = Object.create(object2);
  _.extend(object3, {
    aProp2: "o3.aVal2-2",
    aProp3: [
      1,
      "2",
      3,
      { aProp4: "o3.aVal3" }
    ]
  });
  objectWithProtoInheritedProps = Object.create(object3);
  objectWithProtoInheritedProps.aProp0 = "o0.aVal0";
  Class0 = function () {
    function Class0() {
      this.aProp0 = "o0.aVal0";
    }
    return Class0;
  }();
  Class1 = function (superClass) {
    extend(Class1, superClass);
    function Class1() {
      return Class1.__super__.constructor.apply(this, arguments);
    }
    Class1.prototype.aProp1 = prop1;
    Class1.prototype.aProp2 = "o1.aVal2";
    return Class1;
  }(Class0);
  Class2 = function (superClass) {
    extend(Class2, superClass);
    function Class2() {
      return Class2.__super__.constructor.apply(this, arguments);
    }
    Class2.prototype.aProp2 = "o2.aVal2-1";
    return Class2;
  }(Class1);
  Class3 = function (superClass) {
    extend(Class3, superClass);
    function Class3() {
      return Class3.__super__.constructor.apply(this, arguments);
    }
    Class3.prototype.aProp2 = "o3.aVal2-2";
    Class3.prototype.aProp3 = [
      1,
      "2",
      3,
      { aProp4: "o3.aVal3" }
    ];
    return Class3;
  }(Class2);
  c3 = new Class3();
  expectedPropertyValues = {
    aProp0: "o0.aVal0",
    aProp1: {
      "aProp1.1": "o1.aVal1.1",
      "aProp1.2": "o1.aVal1.2"
    },
    aProp2: "o3.aVal2-2",
    aProp3: [
      1,
      "2",
      3,
      { aProp4: "o3.aVal3" }
    ]
  };
  object = {
    p1: 1,
    p2: { p2_2: 3 }
  };
  objectShallowClone1 = {
    p1: 1,
    p2: object.p2
  };
  objectShallowClone2 = _.clone(object);
  objectDeepClone1 = {
    p1: 1,
    p2: { p2_2: 3 }
  };
  objectDeepClone2 = _.clone(object, true);
  inheritedShallowCloneParent = { p2: object.p2 };
  inheritedShallowClone = Object.create(inheritedShallowCloneParent);
  inheritedShallowClone.p1 = 1;
  inheritedDeepCloneParent = { p2: { p2_2: 3 } };
  inheritedDeepClone = Object.create(inheritedDeepCloneParent);
  inheritedDeepClone.p1 = 1;
  earth = {
    name: "earthDefaults",
    environment: {
      temperature: 20,
      gravity: 9.8,
      moisture: { min: 10 }
    },
    life: true
  };
  laboratory = {
    name: "laboratoryDefaults",
    environment: {
      temperature: 35,
      moisture: { max: 40 }
    },
    life: {
      races: [
        "Caucasian",
        "African",
        "Asian"
      ],
      people: [
        {
          "name": "moe",
          "age": 40
        },
        {
          "name": "larry",
          "age": 50
        }
      ]
    }
  };
  experiment = {
    name: "experimentDefaults",
    environment: {
      gravity: 1.5,
      temperature: null
    },
    life: {
      races: [
        "Kafkasian",
        "ApHriCan",
        "Azian",
        "Mutant"
      ],
      people: [
        {
          "name": "moe",
          "age": 400
        },
        {
          "name": "blanka",
          "age": 20
        },
        {
          "name": "ken",
          "age": 25
        },
        {
          "name": "ryu",
          "age": 28
        },
        {
          "name": "larry",
          "age": 500
        }
      ]
    },
    results: { success: false }
  };
  earth_laboratory_experiment = {
    name: "earthDefaults",
    environment: {
      temperature: 20,
      gravity: 9.8,
      moisture: {
        min: 10,
        max: 40
      }
    },
    life: true,
    results: { success: false }
  };
  experiment_laboratory_earth = {
    name: "experimentDefaults",
    environment: {
      gravity: 1.5,
      temperature: 35,
      moisture: {
        max: 40,
        min: 10
      }
    },
    life: {
      races: [
        "Kafkasian",
        "ApHriCan",
        "Azian",
        "Mutant"
      ],
      people: [
        {
          "name": "moe",
          "age": 400
        },
        {
          "name": "blanka",
          "age": 20
        },
        {
          "name": "ken",
          "age": 25
        },
        {
          "name": "ryu",
          "age": 28
        },
        {
          "name": "larry",
          "age": 500
        }
      ]
    },
    results: { success: false }
  };
  laboratory_experiment = {
    name: "laboratoryDefaults",
    environment: {
      gravity: 1.5,
      temperature: 35,
      moisture: { max: 40 }
    },
    life: {
      races: [
        "Caucasian",
        "African",
        "Asian",
        "Mutant"
      ],
      people: [
        {
          "name": "moe",
          "age": 40
        },
        {
          "name": "larry",
          "age": 50
        },
        {
          "name": "ken",
          "age": 25
        },
        {
          "name": "ryu",
          "age": 28
        },
        {
          "name": "larry",
          "age": 500
        }
      ]
    },
    results: { success: false }
  };
  return {
    objectWithProtoInheritedProps: objectWithProtoInheritedProps,
    Class3: Class3,
    c3: c3,
    expectedPropertyValues: expectedPropertyValues,
    object: object,
    objectShallowClone1: objectShallowClone1,
    objectShallowClone2: objectShallowClone2,
    objectDeepClone1: objectDeepClone1,
    objectDeepClone2: objectDeepClone2,
    inheritedShallowClone: inheritedShallowClone,
    inheritedDeepClone: inheritedDeepClone,
    obj: {
      ciba: 4,
      aaa: 7,
      b: 2,
      c: -1
    },
    arrInt: [
      4,
      7,
      2,
      -1
    ],
    arrInt2: [
      7,
      -1,
      3,
      5
    ],
    arrStr: [
      "Pikoulas",
      "Anodynos",
      "Babylon",
      "Agelos"
    ],
    earth: earth,
    laboratory: laboratory,
    experiment: experiment,
    earth_laboratory_experiment: earth_laboratory_experiment,
    experiment_laboratory_earth: experiment_laboratory_earth,
    laboratory_experiment: laboratory_experiment,
    team: {
      "enabled": true,
      "bundleRoot": "/team",
      "compilers": { "rjs-build": "team-rjs" }
    },
    project: {
      "bundleRoot": "/team/project",
      "compilers": { "rjs-build": "project-rjs-build" }
    },
    bundle: {
      "bundleRoot": "/team/project/bundle",
      "compilers": {
        "coffee-script": { "params": "w b" },
        "urequire": { "scanPrevent": true }
      }
    },
    bundle_project_team: {
      "enabled": true,
      "bundleRoot": "/team/project/bundle",
      "compilers": {
        "coffee-script": { "params": "w b" },
        "urequire": { "scanPrevent": true },
        "rjs-build": "project-rjs-build"
      }
    }
  };


});
}).call(this);