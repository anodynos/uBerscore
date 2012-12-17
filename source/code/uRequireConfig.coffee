## works with uRequire 0.3 alpha #1
#module.exports =
#  exclude: [/^draft/] # everything that matches these is not proccessed
#  main: "uBerscore"
#
#  verbose: true
#
#  outputPath: './build/dist/uBerscore-dev.js'
#  template: 'combine'
#  combine:
#    #method: 'almond' # default (only one for now)
#    globalDeps:
#      varNames:
#        #lodash: "_" #NOT NEEDED, implied from 'isAgree', being in AMD format
#        backbone: "Backbone"  # just testing!


# WILL work with uRequire 0.3 alpha #2 format
module.exports =
  bundle:
    bundleName: "uBerscore" # becomes: bundleName
    main: "uBerscore"
    excludes: [/^draft/]
    dependencies:
      bundleExports: ['lodash', 'backbone']
#        'lodash': ['_']
#        'backbone': ['Backbone'] # test as string

  build:
    outputPath: './build/dist/uBerscore-dev.js'
    template: 'combine'
