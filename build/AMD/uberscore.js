/**
 * uberscore - version 0.0.17
 * Compiled on 2014-10-19 6:57:35
 * git://github.com/anodynos/uBerscore
 * Copyright(c) 2014 Agelos Pikoulas (agelos.pikoulas@gmail.com )
 * Licensed MIT http://www.opensource.org/licenses/mit-license.php
 */

(function() {
    var __isAMD = !!(typeof define === "function" && define.amd), __isNode = typeof exports === "object", __isWeb = !__isNode;
    define([ "require", "exports", "module", "lodash", "./agreement/isAgree", "./blending/blenders/index", "./blending/Blender", "./blending/traverse", "./blending/clone", "./blending/deepExtend", "./objects/okv", "./objects/mutate", "./objects/setp", "./objects/getp", "./objects/isDisjoint", "./objects/isRefDisjoint", "./objects/getRefs", "./objects/getInheritedPropertyNames", "./objects/isEqual", "./objects/isIqual", "./objects/isExact", "./objects/isIxact", "./objects/isLike", "./types/isTrue", "./types/isFalse", "./collections/go", "./collections/array/isEqualArraySet", "./collections/array/arrayize", "./agreement/inAgreements", "./types/type", "./types/isPlain", "./types/isHash", "./Logger", "./certain", "./utils/CoffeeUtils", "./utils/CalcCachedProperties", "./utils/subclass" ], function(require, exports, module, _, isAgree) {
        var __umodule__ = function(require, exports, module, _, isAgree) {
            "use strict";
            var VERSION = "0.0.17";
            var Uberscore;
            Uberscore = function() {
                var key, val, _ref, _ref1;
                function Uberscore() {}
                Uberscore.prototype.VERSION = typeof VERSION === "undefined" || VERSION === null ? "{NO_VERSION}" : VERSION;
                Uberscore.prototype["_"] = _;
                Uberscore.prototype.isLodash = function(lodash) {
                    if (lodash == null) {
                        lodash = _;
                    }
                    return _.name === "lodash" || _.isFunction(lodash.isPlainObject) && _.isFunction(lodash.merge) && _.isFunction(lodash.omit);
                };
                _ref = {
                    Blender: require("./blending/Blender"),
                    traverse: require("./blending/traverse"),
                    clone: require("./blending/clone"),
                    deepExtend: require("./blending/deepExtend"),
                    okv: require("./objects/okv"),
                    mutate: require("./objects/mutate"),
                    setp: require("./objects/setp"),
                    getp: require("./objects/getp"),
                    isDisjoint: require("./objects/isDisjoint"),
                    isRefDisjoint: require("./objects/isRefDisjoint"),
                    getRefs: require("./objects/getRefs"),
                    getInheritedPropertyNames: require("./objects/getInheritedPropertyNames"),
                    isEqual: require("./objects/isEqual"),
                    isIqual: require("./objects/isIqual"),
                    isExact: require("./objects/isExact"),
                    isIxact: require("./objects/isIxact"),
                    isLike: require("./objects/isLike"),
                    isTrue: require("./types/isTrue"),
                    isFalse: require("./types/isFalse"),
                    isOk: function(val) {
                        return !!val;
                    },
                    go: require("./collections/go"),
                    isEqualArraySet: require("./collections/array/isEqualArraySet"),
                    arrayize: require("./collections/array/arrayize"),
                    isAgree: require("./agreement/isAgree"),
                    inAgreements: require("./agreement/inAgreements"),
                    type: require("./types/type"),
                    isPlain: require("./types/isPlain"),
                    isHash: require("./types/isHash"),
                    Logger: require("./Logger"),
                    certain: require("./certain"),
                    CoffeeUtils: require("./utils/CoffeeUtils"),
                    CalcCachedProperties: require("./utils/CalcCachedProperties"),
                    subclass: require("./utils/subclass")
                };
                for (key in _ref) {
                    val = _ref[key];
                    Uberscore.prototype[key] = val;
                }
                _ref1 = require("./blending/blenders/index");
                for (key in _ref1) {
                    val = _ref1[key];
                    Uberscore.prototype[key] = val;
                }
                return Uberscore;
            }();
            return new Uberscore();
        }.call(this, require, exports, module, _, isAgree);
        var __old___b0 = window["_B"], __old__uberscore1 = window["uberscore"];
        if (!__isAMD) {
            window["_B"] = __umodule__;
            window["uberscore"] = __umodule__;
            __umodule__.noConflict = function() {
                window["_B"] = __old___b0;
                window["uberscore"] = __old__uberscore1;
                return __umodule__;
            };
        }
        return __umodule__;
    });
}).call(this);