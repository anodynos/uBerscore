// Generated by uRequire v0.3.0alpha17
(function () {
  var __isAMD = (typeof define === 'function' && define.amd),
    __isNode = (typeof exports === 'object'),
    __isWeb = !__isNode;
(function (root,factory) {
  if (typeof exports === 'object') {
   var nr = new (require('urequire').NodeRequirer) ('spec-data', __dirname, '.');
   module.exports = factory(nr.require, exports, module);
 } else if (typeof define === 'function' && define.amd) {
     define(factory);
 }
})(this,function (require, exports, module) {
  // uRequire: start body of original nodejs module
var data;

data = {
    obj: {
        ciba: 4,
        aaa: 7,
        b: 2,
        c: -1
    },
    arrInt: [ 4, 7, 2, -1 ],
    arrInt2: [ 7, -1, 3, 5 ],
    arrStr: [ "Pikoulas", "Anodynos", "Babylon", "Agelos" ],
    globalDefaults: {
        enabled: true,
        bundleRoot: "/global",
        compilers: {
            "rjs-build": "global-rjs"
        }
    },
    projectDefaults: {
        bundleRoot: "/global/project",
        compilers: {
            "rjs-build": "project-rjs-build"
        }
    },
    bundleDefaults: {
        bundleRoot: "/global/project/bundle",
        compilers: {
            "coffee-script": {
                params: "w b"
            },
            urequire: {
                scanPrevent: true
            }
        }
    }
};

module.exports = data;
// uRequire: end body of original nodejs module


return module.exports;
})
})();