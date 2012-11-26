myPackage =
  name: "uberscore"

  description: "uBerscore js is (now) an early experiment: a 'higher' level data manipulator for all kinds of js collections (objects+arrays); it offers functionality that underscore doesn't and wouldn't have, and its highly build on _ it."

  version: "0.0.3"

  homepage: "https://github.com/anodynos/uBerscore"

  author:
    name: "Agelos Pikoulas"
    email: "agelos.pikoulas@gmail.com"

  licenses: [
    type: "MIT"
    url: "http://www.opensource.org/licenses/mit-license.php"
  ]

  keywords: ["data", "manipulation"]

  repository:
    type: "git"
    url: "git://github.com/anodynos/uBerscore"

  bugs:
    url: ""

  main: "./build/code/uBerscore.js"

  test: "mocha build/spec --recursive --bail --reporter spec"

  directories:
    doc: "./doc"
    dist: "./build"

  engines:
    "node": "*"

  dependencies:
    "lodash": "*"
    "urequire": "*" # modules converted to UMD so they run both on nodejs & AMD

  devDependencies:
    "chai": "*"
    "grunt-shell": "*"  # used in many tasks, including urequire-ing examples, compiling coffee etc
    "grunt-contrib": "*" # using clean & copy

if (typeof exports is 'object') # we're in node
  require('fs').writeFileSync './package.json', JSON.stringify(myPackage), 'utf-8'

module.exports = myPackage