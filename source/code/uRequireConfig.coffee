
# example for building uberscore-dev.js
# use as `$ urequire config source/code/uRequireConfig.coffee -d 0`
# note: works with uRequire 0.3.0beta1
module.exports =

  bundle:
    #path: './source/code' # not needed - as long as this file is on the bundle's root, its assumed.

    main: "uberscore"

    filez: ['**/*.*', '!**/draft/*.*', '!uRequireConfig*']

    copy: [/./]

    dependencies: exports: bundle:
      'lodash': ['_']
      'agreement/isAgree': 'isAgree' # test as string also works!

  # these are our build options
  build:
#   outputPath: './build/dist/uberscore-dev.js'
    outputPath: './build/UMD'
#    template: 'combined'
    debugLevel: 30
#    verbose: true
#    watch: true