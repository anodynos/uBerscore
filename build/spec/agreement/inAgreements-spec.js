// Generated by uRequire v0.4.2
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('agreement/inAgreements-spec', module, __dirname, '.');
   module.exports = factory(nr.require, exports, module, nr.require('lodash'), nr.require('agreement/isAgree'), nr.require('chai'), nr.require('uberscore'), nr.require('../spec-data'));
 } else if (typeof define === 'function' && define.amd) {
     define(['require', 'exports', 'module', 'lodash', 'agreement/isAgree', 'chai', 'uberscore', '../spec-data'], factory);
 }
})(this,function (require, exports, module, _, isAgree, chai, _B, data) {
  // uRequire: start body of original nodejs module
var assert, chai, compiledFiles, data, exclude, expect, include, jsFiles, libs, _, _B;

chai = require("chai");

assert = chai.assert;

expect = chai.expect;

_ = require("lodash");

_B = require("uberscore");

data = require("../spec-data");

compiledFiles = /.*\.(coffee|iced|coco)$/i;

jsFiles = /.*\.(js|javascript)$/i;

include = [ jsFiles, compiledFiles, "papari.txt" ];

exclude = [ /.*lalakis.*/ ];

libs = [ "file.coffee", "lalakis.coffee", "superlalakis.js", "papari.txt", "loulou.gif", "bla.js" ];

describe("inAgreements ", function() {
    it("a simple file inAgreements 'include'", function() {
        return expect(_B.inAgreements("file.coffee", include)).to.be["true"];
    });
    return it("a simple file inAgreements 'include'", function() {
        return expect(_B.inAgreements("papari.txt", include)).to.be["true"];
    });
});
// uRequire: end body of original nodejs module


return module.exports;
})
})();