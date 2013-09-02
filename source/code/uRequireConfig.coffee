# example for building uberscore-dev.js
# use as `$ urequire config source/code/uRequireConfig.coffee -d 0`
# note: works with uRequire >= 0.5.0
VERSION = (JSON.parse (require 'fs').readFileSync './package.json', 'utf-8').version

module.exports =

  bundle:
    #path: './source/code' # not needed - as long as this file is on the bundle's root, its assumed.

    main: "uberscore"

    filez: ['**/*.*', '!**/draft/*.*', '!uRequireConfig*']
    copy: [/./]

    resources: [
      [ '~+inject:VERSION', ['uberscore.coffee']
        (m)-> m.beforeBody = "var VERSION = '#{VERSION}';"]
    ]

    dependencies:
      node: "util"
      exports: bundle:
        'lodash': ['_']
        'agreement/isAgree': 'isAgree' # test as string also works!

  build:
    outputPath: './build/dist/uberscore-dev.js' #using the DEPRACATED outputPath instead of path, gives warning
    template: 'combined'
    debugLevel: 100
    verbose: true
#    watch: true
#    continue: true
