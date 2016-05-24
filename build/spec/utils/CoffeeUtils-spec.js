// Generated by uRequire v0.7.0-beta.28 target: 'spec' template: 'UMDplain'
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


var l = new _B.Logger('utils/CoffeeUtils-spec.js');

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
describe("Get classes of inherited classes", function () {
  var OtherClass, SubClass, SubSubClass, sc, ssc;
  OtherClass = function (superClass) {
    extend(OtherClass, superClass);
    function OtherClass() {
      return OtherClass.__super__.constructor.apply(this, arguments);
    }
    return OtherClass;
  }(_B.CoffeeUtils);
  SubClass = function (superClass) {
    extend(SubClass, superClass);
    function SubClass() {
      return SubClass.__super__.constructor.apply(this, arguments);
    }
    return SubClass;
  }(OtherClass);
  SubSubClass = function (superClass) {
    extend(SubSubClass, superClass);
    function SubSubClass() {
      return SubSubClass.__super__.constructor.apply(this, arguments);
    }
    return SubSubClass;
  }(SubClass);
  sc = new SubClass();
  ssc = new SubSubClass();
  return describe("Get extending classes in descenting order, including the own as last:", function () {
    var scClasses, sscClasses;
    scClasses = [
      _B.CoffeeUtils,
      OtherClass,
      SubClass
    ];
    sscClasses = [
      _B.CoffeeUtils,
      OtherClass,
      SubClass,
      SubSubClass
    ];
    describe("without params:", function () {
      describe("called on target instance:", function () {
        it("#1", function () {
          return expect(ssc.getClasses()).to.deep.equal(sscClasses);
        });
        return it("#2", function () {
          return expect(sc.getClasses()).to.deep.equal(scClasses);
        });
      });
      return describe("called staticically (on target class):", function () {
        it("#1", function () {
          return expect(SubSubClass.getClasses()).to.deep.equal(sscClasses);
        });
        return it("#2", function () {
          return expect(SubClass.getClasses()).to.deep.equal(scClasses);
        });
      });
    });
    describe("with instance as param:", function () {
      describe("called on (any) instance:", function () {
        it("#1", function () {
          return expect(sc.getClasses(ssc)).to.deep.equal(sscClasses);
        });
        return it("#2", function () {
          return expect(ssc.getClasses(sc)).to.deep.equal(scClasses);
        });
      });
      return describe("called statically (on any class):", function () {
        it("#1", function () {
          expect(_B.CoffeeUtils.getClasses(ssc)).to.deep.equal(sscClasses);
          expect(SubClass.getClasses(ssc)).to.deep.equal(sscClasses);
          return expect(SubSubClass.getClasses(ssc)).to.deep.equal(sscClasses);
        });
        return it("#2", function () {
          expect(_B.CoffeeUtils.getClasses(sc)).to.deep.equal(scClasses);
          expect(SubClass.getClasses(sc)).to.deep.equal(scClasses);
          return expect(SubSubClass.getClasses(sc)).to.deep.equal(scClasses);
        });
      });
    });
    return describe("with class as param:", function () {
      describe("called on (any) instance:", function () {
        it("#1", function () {
          return expect(sc.getClasses(SubSubClass)).to.deep.equal(sscClasses);
        });
        return it("#2", function () {
          return expect(ssc.getClasses(SubClass)).to.deep.equal(scClasses);
        });
      });
      return describe("called staticically (on any class):", function () {
        it("#1", function () {
          return expect(SubClass.getClasses(SubSubClass)).to.deep.equal(sscClasses);
        });
        return it("#2", function () {
          return expect(SubSubClass.getClasses(SubClass)).to.deep.equal(scClasses);
        });
      });
    });
  });
});

return module.exports;

});
}).call(this);