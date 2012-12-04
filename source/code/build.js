({
    baseUrl : ".",

    paths : {
////      lodash: "../../libs/lodash.min"
        lodash : "getGlobal_lodash"
    },
//  fileExclusionRegExp: 'lodash.js',

    include : "uBerscore",


// Problem: asynch require with almond / r.js: https://github.com/jrburke/almond/issues/42

// Solution #1 :
//  insertRequire: ["uBerscore"], // not working as-is, cause its async (unless we use almond-sync)
//  name:"almond-sync",           // as hack where line ~354 `if (forceSync)` becomes `if (true)` works with above !
//  wrap:true,

// Solution #2: wrap a synch call (https://github.com/jrburke/almond/issues/42#issuecomment-9498562)
    name : "almond",
    wrap : {
        start :
            "var isAMD = (typeof define === 'function' && define.amd);\n" +
            "factory = function(_) {",
        end :
            "  return require('uBerscore');};\n" +
            "if (isAMD) {\n" +
            "    define(['lodash'], factory);\n" +
            "} else { factory();}" // We dont have AMD:
                                    // * run the almond factory
                                    // * rely on globals xxx been established with getGlobal_xxx
                                    //      to return the result that gets available internally.
                                    // * exportsGlobals anyway ?
    },

    //  out: "../uBerscore-min.js",  optimize:'uglify', // min profile
    out : "../dist/uBerscore-dev.js", optimize : 'none'
//  uglify: {beautify: true, no_mangle: true} ,

})


