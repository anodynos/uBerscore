({
  baseUrl: ".",
  paths: {
//      lodash: "../../libs/lodash.min"
      lodash: "global_lodash"
  },
  name:"almond-sync",
  insertRequire: ["uBerscore"],
  include: "uBerscore",
  out: "../uBerscore-min.js",
  optimize:'uglify',
  wrap:true
})


