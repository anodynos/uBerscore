({
  baseUrl: ".",
  paths: {
//      lodash: "../../libs/lodash.min"
      lodash: "global_lodash"
  },
  name:"almond-sync",
  insertRequire: ["uBerscore"],
  include: "uBerscore",
  out: "../uBerscore.js",
  optimize:'uglify',
  uglify: {beautify: true, no_mangle: true} ,
  wrap:true
})


