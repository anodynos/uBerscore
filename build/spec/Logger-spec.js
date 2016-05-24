// Generated by uRequire v0.7.0-beta.28 target: 'spec' template: 'UMDplain'
(function () {
  
var __isAMD = !!(typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (factory) {
  if (typeof exports === 'object') {
    module.exports = factory(require, exports, module, require('lodash'), require('chai'), require('uberscore'), require('./spec-data'), require('./specHelpers'));
} else if (typeof define === 'function' && define.amd) { define(['require', 'exports', 'module', 'lodash', 'chai', 'uberscore', './spec-data', './specHelpers'], factory); } else throw new Error('uRequire: Loading UMD module as <script>, without `build.noLoaderUMD`');
}).call(this, function (require, exports, module, _, chai, _B, data, spH) {
  

var equal = spH["equal"],notEqual = spH["notEqual"],ok = spH["ok"],notOk = spH["notOk"],tru = spH["tru"],fals = spH["fals"],deepEqual = spH["deepEqual"],notDeepEqual = spH["notDeepEqual"],exact = spH["exact"],notExact = spH["notExact"],iqual = spH["iqual"],notIqual = spH["notIqual"],ixact = spH["ixact"],notIxact = spH["notIxact"],like = spH["like"],notLike = spH["notLike"],likeBA = spH["likeBA"],notLikeBA = spH["notLikeBA"],equalSet = spH["equalSet"],notEqualSet = spH["notEqualSet"];
var expect = chai["expect"];


var l = new _B.Logger('Logger-spec.js');

describe("Logger debug():", function () {
  describe("simple cases, no maxDebugLevel or pathLevels", function () {
    before(function () {
      delete _B.Logger.debugPathsLevels;
      return delete _B.Logger.maxDebugLevel;
    });
    describe("default instance debugLevel = 1:", function () {
      var l;
      l = new _B.Logger();
      describe("test debug() :", function () {
        it("default debug() level is also 1:", function () {
          return expect(l.deb("something")).to.be.not.undefined;
        });
        it("does debug() for level 0 or 1:", function () {
          expect(l.deb(0, "something")).to.be.not.undefined;
          return expect(l.deb(1, "something")).to.be.not.undefined;
        });
        return it("not debug() for level > 1:", function () {
          return expect(l.deb(2, "something")).to.be.undefined;
        });
      });
      return describe("test deb(level) on default debugLevel :", function () {
        it("is true for ded(0) or deb(1):", function () {
          expect(l.deb(0)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(1)).to.be["true"];
          return expect(l.deb("something")).to.be.not.undefined;
        });
        return it("not debug() for level > 1:", function () {
          expect(l.deb(2)).to.be["false"];
          return expect(l.deb("something")).to.be.undefined;
        });
      });
    });
    describe("set debugLevel instance level = 0:", function () {
      var l;
      l = new _B.Logger("title", 0);
      it("not debug() for default level = 1 :", function () {
        return expect(l.deb("something")).to.be.undefined;
      });
      it("does debug() for explicit level = 0 :", function () {
        return expect(l.deb(0, "something")).to.be.not.undefined;
      });
      return it("not debug() for default level >= 1 :", function () {
        expect(l.deb(1, "something")).to.be.undefined;
        return expect(l.deb(2, "something")).to.be.undefined;
      });
    });
    return describe("test deb(level) on user set debugLevel = 30:", function () {
      var l;
      l = new _B.Logger("title", 30);
      it("is true for ded(0) or deb(1):", function () {
        expect(l.deb(0)).to.be["true"];
        expect(l.deb("something")).to.be.not.undefined;
        expect(l.deb(30)).to.be["true"];
        return expect(l.deb("something")).to.be.not.undefined;
      });
      return it("not debug() for level > 30:", function () {
        expect(l.deb(31)).to.be["false"];
        return expect(l.deb("something")).to.be.undefined;
      });
    });
  });
  return describe("With debug Path Levels, even as Number parsable strings:", function () {
    before(function () {
      delete _B.Logger.debugPathsLevels;
      _B.Logger.addDebugPathLevel("foo/bar/froo", "60");
      _B.Logger.addDebugPathLevel("foo/bar", "40");
      _B.Logger.addDebugPathLevel("foo/", 10);
      return _B.Logger.addDebugPathLevel("baz/faux", 12);
    });
    it("correctly sets _B.Logger.debugPathsLevels, as Numbers", function () {
      return expect(_B.Logger.debugPathsLevels).to.be.deep.equal({
        foo: {
          _level: 10,
          bar: {
            _level: 40,
            froo: { _level: 60 }
          }
        },
        baz: { faux: { _level: 12 } }
      });
    });
    it("throws Error if debugLevel is not parsable Number", function () {
      return expect(function () {
        return _B.Logger.addDebugPathLevel("baz/faux", "blah012");
      }).to["throw"](Error, /debugLevel 'blah012' isNaN (Not a Number or not Number parsable)*/);
    });
    describe("without Logger.maxDebugLevel  ", function () {
      describe("getDebugPathLevel() gets the closest _level:", function () {
        it("level of last common path", function () {
          var l;
          l = new _B.Logger("foo/bar/joe/doe");
          return expect(l.getDebugPathLevel()).to.equal(40);
        });
        it("level of exact common path #1", function () {
          var l;
          l = new _B.Logger("/foo");
          return expect(l.getDebugPathLevel()).to.equal(10);
        });
        it("level of exact common path #2", function () {
          var l;
          l = new _B.Logger("baz/faux/");
          return expect(l.getDebugPathLevel()).to.equal(12);
        });
        it("level of inexistent path", function () {
          var l;
          l = new _B.Logger("blah/blah/");
          return expect(l.getDebugPathLevel()).to.be.undefined;
        });
        return it("matching any path on root", function () {
          var l;
          _B.Logger.addDebugPathLevel("/", 5);
          l = new _B.Logger("blah/blah/");
          return expect(l.getDebugPathLevel()).to.be.equal(5);
        });
      });
      describe("logger instance without debugLevel", function () {
        var l;
        l = new _B.Logger("foo/bar/joe/doe");
        it("is true for ded(<=30) :", function () {
          expect(l.deb(0)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(1)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(30)).to.be["true"];
          return expect(l.deb("something")).to.be.not.undefined;
        });
        return it("not debug() for level > 40:", function () {
          expect(l.deb(41)).to.be["false"];
          return expect(l.deb("something")).to.be.undefined;
        });
      });
      describe("logger instance debugLevel = 50 is respected", function () {
        var l;
        l = new _B.Logger("foo/bar/joe/doe", 50);
        it("is true for ded(<=50) :", function () {
          expect(l.deb(0)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(1)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(50)).to.be["true"];
          return expect(l.deb("something")).to.be.not.undefined;
        });
        return it("not debug() for level > 40:", function () {
          expect(l.deb(51)).to.be["false"];
          return expect(l.deb("something")).to.be.undefined;
        });
      });
      return describe("logger instance debugLevel = 0 is respected:", function () {
        var l;
        l = new _B.Logger("foo/bar/joe/doe", 0);
        it("is true for ded(=0) :", function () {
          expect(l.deb(0)).to.be["true"];
          return expect(l.deb("something")).to.be.not.undefined;
        });
        return it("is false for ded(>0) :", function () {
          expect(l.deb(1)).to.be["false"];
          expect(l.deb("something")).to.be.undefined;
          expect(l.deb(50)).to.be["false"];
          expect(l.deb("something")).to.be.undefined;
          expect(l.deb(51)).to.be["false"];
          return expect(l.deb("something")).to.be.undefined;
        });
      });
    });
    return describe("with Logger.maxDebugLevel = 20 always respected as upper limit :", function () {
      before(function () {
        return _B.Logger.maxDebugLevel = 20;
      });
      describe("logger instance without debugLevel", function () {
        var l;
        l = new _B.Logger("foo/bar/joe/doe");
        it("l.getDebugPathLevel()", function () {
          return expect(l.getDebugPathLevel()).to.equal(40);
        });
        it("is true for ded( <= Logger.maxDebugLevel = 20) :", function () {
          expect(l.deb(0)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(1)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(20)).to.be["true"];
          return expect(l.deb("something")).to.be.not.undefined;
        });
        return it("not debug() for level > Logger.maxDebugLevel  = 20:", function () {
          expect(l.deb(21)).to.be["false"];
          return expect(l.deb("something")).to.be.undefined;
        });
      });
      return describe("logger instance with debugLevel = 50", function () {
        var l;
        l = new _B.Logger("foo/bar/joe/doe", 50);
        it("l.getDebugPathLevel()", function () {
          return expect(l.getDebugPathLevel()).to.equal(40);
        });
        it("is true for ded(<=20) :", function () {
          expect(l.deb(0)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(1)).to.be["true"];
          expect(l.deb("something")).to.be.not.undefined;
          expect(l.deb(20)).to.be["true"];
          return expect(l.deb("something")).to.be.not.undefined;
        });
        return it("not debug() for level > 20:", function () {
          expect(l.deb(21)).to.be["false"];
          return expect(l.deb("something")).to.be.undefined;
        });
      });
    });
  });
});

return module.exports;

});
}).call(this);