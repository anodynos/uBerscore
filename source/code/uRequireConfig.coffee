# example for building uberscore-dev.js
# use as `$ urequire config source/code/uRequireConfig.coffee -d 0`
# note: works with uRequire 0.3.0beta1
module.exports =

  bundle:
#    bundlePath: './source/code' # not needed - as long as this file is on the bundle's root, its assumed.

    # our 'main' / index .js file - used by r.js optimizer as
    main: "uberscore"
#    bundleName: "uBerscore_bundleName_urequireconfig"

    # do not include any file within these patterns
    ignore: [/^draft/]

    # Export dependencies for the whole bundle
    dependencies:
      noWeb: ['util'] # todo: fix String instead of Array

      # Using []<String>, we 'll discover corresponding variable they bind to
      # from bundle modules that actually import these deps (only from AMD in this version), eg @see `arrayize`.
#      bundleExports: [ #@todo: NOT WORKING - wont use knownVariables ?
#        'lodash'              # export this global dep
#        'agreement/isAgree'   # export this module, as a bundle-global dependency
#      ]

      # alternatively (more proper, yet verbose) it could have been:
      bundleExports:
        'lodash': ['_']
        'agreement/isAgree': 'isAgree' # test as string also works!

  # these are our build options
  build:
    outputPath: './build/dist/uberscore-dev.js'
    template: 'combined'
    debugLevel: 40
#    verbose: true