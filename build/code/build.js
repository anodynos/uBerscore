({
  baseUrl: ".",

  paths: {
////      lodash: "../../libs/lodash.min"
      lodash: "get_global_lodash"
  },
//  fileExclusionRegExp: 'lodash.js',

    include: "uBerscore",


// Problem: asynch require with almond / r.js: https://github.com/jrburke/almond/issues/42

//  Solution #1 :
//  insertRequire: ["uBerscore"], // not working as-is, cause its async (unless we use almond-sync)
//  name:"almond-sync",           // as hack where line ~354 `if (forceSync)` becomes `if (true)` works with above !
//  wrap:true,

// Solution #2: wrap a synch call (https://github.com/jrburke/almond/issues/42#issuecomment-9498562)
  name:"almond",
  wrap: {
        start: "(function() {",
        end: "require('uBerscore');}());"
  },

  //  out: "../uBerscore-min.js",  optimize:'uglify', // min profile
  out: "../uBerscore.js", optimize:'none',
//  uglify: {beautify: true, no_mangle: true} ,

})


