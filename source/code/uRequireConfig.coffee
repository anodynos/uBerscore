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


# WILL work with uRequire 0.3 alpha >#2 format
module.exports =
  bundle:
    bundleName: "uBerscore" # becomes: bundleName
    main: "uBerscore"
    excludes: [/^draft/]
    dependencies:
      # Export these dependencies in the whole bundle.
      # Discover the variable names they bind from bundle modules
      # that actually import these deps, eg @see `arrayize`.
      bundleExports: ['lodash', 'backbone', 'agreement/isAgree']

#      # alternatively (more proper, yet verbose) it could have been:
#      bundleExports:
#        'lodash': ['_']
#        'backbone': ['Backbone']
#        'agreement/isAgree': 'isAgree' # test as string also works!

  build:
    outputPath: './build/dist/uBerscore-dev.js'
    template: 'combine'