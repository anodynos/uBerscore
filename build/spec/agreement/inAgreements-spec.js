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


var l = new _B.Logger('agreement/inAgreements-spec.js');

var compiledFiles, exclude, include, jsFiles, libs;
compiledFiles = /.*\.(coffee|iced|coco)$/i;
jsFiles = /.*\.(js|javascript)$/i;
include = [
  jsFiles,
  compiledFiles,
  "papari.txt"
];
exclude = [/.*lalakis.*/];
libs = [
  "file.coffee",
  "lalakis.coffee",
  "superlalakis.js",
  "papari.txt",
  "loulou.gif",
  "bla.js"
];
describe("inAgreements ", function () {
  it("a simple file inAgreements 'include'", function () {
    return expect(_B.inAgreements("file.coffee", include)).to.be["true"];
  });
  return it("a simple file inAgreements 'include'", function () {
    return expect(_B.inAgreements("papari.txt", include)).to.be["true"];
  });
});

return module.exports;

});
}).call(this);