# note: works with uRequire 0.3.0alpha12, last time I checked!

module.exports =

  bundle:
    # our 'main' / index .js file - used by r.js optimizer as
    main: "uBerscore"

    # do not include any file within these patterns
    excludes: [/^draft/]

    # Export dependencies for the whole bundle
    dependencies:

      # Using []<String>, we 'll discover corresponding variable they bind to
      # from bundle modules that actually import these deps (only from AMD in this version), eg @see `arrayize`.
      bundleExports: [
        'lodash'              # export this global dep
        'agreement/isAgree'   # export this module, as a bund-global dependency
      ]

#      # alternatively (more proper, yet verbose) it could have been:
#      bundleExports:
#        'lodash': ['_']
#        'backbone': ['Backbone']
#        'agreement/isAgree': 'isAgree' # test as string also works!

  # these are our build options
  build:
    outputPath: './build/dist/uBerscore-dev.js'
    template: 'combine'
    debugLevel: 40
    verbose: true