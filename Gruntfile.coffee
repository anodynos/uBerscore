# requires grunt 0.4.x
sourceDir     = "source/code"
buildDir      = "build/code"
sourceSpecDir = "source/spec"
buildSpecDir  = "build/spec"
distDir       = "build/dist"

gruntFunction = (grunt) ->
  _ = grunt.util._
  pkg = grunt.file.readJSON('package.json')
  banner = """
      /*
      * #{ pkg.name } - version #{ pkg.version }
      * Compiled on #{ grunt.template.today("yyyy-mm-dd h:MM:ss") }
      * #{ pkg.repository.url }
      * Copyright(c) #{ grunt.template.today("yyyy") } #{ pkg.author.name } (#{ pkg.author.email } )
      * Licensed #{ pkg.licenses[0].type } #{ pkg.licenses[0].url }
      */\n"""
  bannerMin = """
    /* #{ pkg.name } #{ pkg.version } (#{ grunt.template.today("yyyy-mm-dd") }), #{ pkg.repository.url }
       #{ pkg.author.email }, Lisense: #{ pkg.licenses[0].type } */\n"""

  gruntConfig =
    meta: {banner, bannerMin}
    options: {sourceDir, buildDir, sourceSpecDir, buildSpecDir, distDir}

    ### NOTE: uRequire config is used as a testbed & example, thus so many comments :-) ###
    urequire:
      # These are the defaults, when a task has no 'derive' at all. Use derive:[] to skip deriving it.
      # @note that any urequire task starting with '_' is ignored as a grunt target and only used for `derive`-ing.
      _defaults:
        bundle:
          path: "#{sourceDir}"
          filez: ['**/*.*', '!**/draft/*.*', '!uRequireConfig*']
          copy: [/./]

          # define some Resource Converters on `resources` key
          resources: [
            [                                       # example: declare an RC to perform some 'concat/inject' job.
              '~injectVERSION'                      # inject 'var VERSION=xxx' inside the module's code, BEFORE running the template
              ['uberscore.coffee']                  # note '~' in name means `isMatchSrcFilename:true` - matching `uberscore.coffee`, instead of dstFilename `uberscore.js`
              ->"var VERSION = '#{pkg.version}';\n#{@converted}" # prepend to @converted (TextResource instance @converted -javascript- code)
            ]                                       # no convFilename needed
          ]
          dependencies:
            node: 'util'   # 'util' will not be added to deps array, will be available only on nodejs execution.
                           # Same as 'node!myDep', but allows module to run on nodejs without conversion
            exports: bundle:
              # ['lodash', 'agreement/isAgree']     # simple syntax, if depVars can be derived from AMD code
              'lodash': "_"                         # precise syntax
              'agreement/isAgree': 'isAgree'

        build:
          #verbose: false                           # false is default
          debugLevel: 30                            # 0 is default
          #continue: true                           # false is default

      # a simple UMD build
      uberscoreUMD:
        #'build': # `build` and `bundle` hashes are not needed - keys are safelly recognised, even if they're not in them.
        #'derive': ['_defaults'] # not needed - by default it deep uDerives all '_defaults'. To avoid use `derive:[]`.
          #template: 'UMD' # Not needed - 'UMD' is default
        dstPath: "#{buildDir}"

        resources: [                                # example: perform some 'concat' job, AFTER the template conversion is done.
          [ '!banner:uberscore.js',                 # '!' means 'isAfterTemplate: true'
            'concat/add banner to uberscore.js'     # some description
            ['uberscore.js']                        # note we are looking to change the dstFilename `uberscore.js` (not `uberscore.coffee`). We could have used ~ to match srcFilename
            ->"#{banner}\n#{@converted}"            # @converted holds our converted UMD code, since this RC runs AFTER the template conversion
          ]                                         # no convFilename needed
        ]

      # a 'combined' build, that also works without AMD loaders on Web
      uberscoreDev:
        template: 'combined'
        main: 'uberscore'                           # template: 'combined' requires a 'main' module.
                                                    # if 'main' is missing, then main is assumed to be `bundleName`,
                                                    # which in turn is assumed to be grunt's @target ('uberscoreDev' in this case).
                                                    # Having 'uberscoreDev' as the bundle.name/main, but no module by that name (or 'index' or 'main')
                                                    # will cause a compilation error. Its better to be precise anyway, in case this config is used outside grunt :-)
        dstPath: './build/dist/uberscore-dev.js'    # the name of a file instead of a directory is needed for 'combined'


      # A combined build, that is `derive`d from 'uberscoreDev' (& specifically '_defaults')
      # that uses re.js/uglify2 for minification.
      uberscoreMin:
        derive: ['uberscoreDev', '_defaults'] # need to specify we also need '_defaults', in this order.
        dstPath: './build/dist/uberscore-min.js'
        optimize: 'uglify2'                         # doesn't have to be a String. `true` selects 'uglify2' also. It can also be 'uglify'.
                                                    # Even more interestingly, u can pass any 'uglify2' (or 'uglify') keys,
                                                    # the r.js way (https://github.com/jrburke/r.js/blob/master/build/example.build.js)
                                                    # eg optimize: {uglify2: output: beautify: true}

      # An example on how to reference (`derive`-ing from) external urequire config file(s),
      # while overriding some of its options.
      #
      # @note its not deriving at all from '_defaults', unless its specified.
      #
      # Its effectivelly equivalent to issuing
      #  `$ urequire config source/code/uRequireConfig.coffee -o ./build/code -t UMD`
      uberscoreFileConfig:
        derive: ['source/code/uRequireConfig.coffee']
        template: 'UMD'
        dstPath: 'build/anotherUMDBuild'

      # An example of building only a sub-tree of the whole bundle.
      # Here we want to build only Logger (& its dependencies) in a 'combined' build using almond.
      # So we need `main: 'Logger'`, which is infered from grunt task/target name
      # @todo: Its somewhat ineffiecient in urequire 0.5, cause ALL modules are converted to AMD first, used as input to rjs.optimize
      #        which only picks the dependent ones. Future urequire versions should fix this.
      Logger:
        #main: 'Logger'                             # Not needed: bundle.main & consequently bundle.name inherit grunt's task/target 'Logger' name
        template: 'combined'
        optimize: true
        dstPath: 'build/Logger-min.js'

      # uRequire-ing the specs: we also have two builds as 'UMD' & as 'combined'
      spec:                                         # deep derived from all '_defaults', by default :-)
        path: "#{sourceSpecDir}"
        copy: [/./, '**/*.*']                       # 2 ways to say "I want all non-`resource` matched files to be copied to build.dstPath"
        dstPath: "#{buildSpecDir}"
        dependencies: exports: bundle:
          chai: 'chai'
          lodash: '_'
          uberscore: '_B'
          'spec-data': 'data'
          # assert = chai.assert # @todo(for uRequire 4 5 5) allow for . notation to refer to export!

      specCombined:
        derive: ['spec']                            # deep inherits all of 'spec' BUT none of '_defaults':-)
        dstPath: "#{buildSpecDir}_combined/index-combined.js"
        template: 'combined'
        #main: 'index'                              # not needed: if `bundle.main` is undefined it defaults to `bundle.bundleName`
                                                    # or 'index' or 'main' (whichever found 1st as a module on bundleRoot)
                                                    # with the price of a warning! In spec's case, THERE IS a module 'index.coffee' which is picked.
        dependencies: depsVars:
          uberscore: ['_B', 'uberscore']

    watch:
      uberscoreUMD:
        files: ["#{sourceDir}/**/*.*", "#{sourceSpecDir}/**/*.*" ] # new subdirs dont work - https://github.com/gruntjs/grunt-contrib-watch/issues/70
        tasks: ['urequire:uberscoreUMD', 'urequire:spec', 'mocha', 'runBuildExample']
        options: nospawn: true                                     # urequire watch works only with `nospawn: true`

      uberscoreDev:
        files: ["#{sourceDir}/**/*.*"]
        tasks: ['urequire:uberscoreDev', 'urequire:specCombined', 'mocha', 'runAlmondBuildExample']
        options: nospawn: true

    shell:
      mocha: command: "mocha #{buildSpecDir}/index --recursive --bail --reporter spec"
      doc: command: "codo source/code --title 'uberscore <%= pkg.version %> API documentation' --cautious"
      runBuildExample: command: "coffee source/examples/buildExample.coffee"
      runAlmondBuildExample: command: "coffee source/examples/almondBuildExample.coffee"
      options: {verbose: true, failOnError: true, stdout: true, stderr: true}

    concat:
      'uberscoreDev':
        options: banner: "<%= meta.banner %>"
        src: ['<%= options.distDir %>/uberscore-dev.js']
        dest: '<%= options.distDir %>/uberscore-dev.js'

      'uberscoreMin':
        options: banner: "<%= meta.bannerMin %>"
        src: ['<%= options.distDir %>/uberscore-min.js']
        dest: '<%= options.distDir %>/uberscore-min.js'

    clean:
        files: [
          "<%= options.buildDir %>/**/*.*"
          "<%= options.buildSpecDir %>/**/*.*"
          "<%= options.distDir %>/**/*.*"
        ]

  ### shortcuts generation ###
  splitTasks = (tasks)-> if !_.isString tasks then tasks else (_.filter tasks.split(' '), (v)-> v)
  grunt.registerTask cmd, splitTasks "shell:#{cmd}" for cmd of gruntConfig.shell # shortcut to all "shell:cmd"
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
     # generic shortcuts
     "default":   "clean build deploy deploymin test"
     "build":     "urequire:uberscoreUMD"                         # concat:uberscoreUMD done in *urequire `bundle.resources`*
     "deploy":    "urequire:uberscoreDev concat:uberscoreDev"
     "deploymin": "urequire:uberscoreMin concat:uberscoreMin"
     "test":      "urequire:spec urequire:specCombined mocha run"
     "run":       "runBuildExample runAlmondBuildExample"
     "watchUMD":  "clean build urequire:spec mocha runBuildExample watch:uberscoreUMD"
     "watchDev":  "clean watch:uberscoreDev"

    # generic shortcuts
     "cl":      "clean"
     "b":       "build"
     "d":       "deploy"
     "dm":      "deploymin"
     "m":       "mocha"
     "t":       "test"
     "wu":      "watchUMD"
     "wd":      "watchDev"

     # IDE shortcuts
     "alt-c": "cp"
     "alt-b": "b"
     "alt-d": "d"
     "alt-t": "t"
  }

  grunt.initConfig gruntConfig
  grunt.loadNpmTasks task for task in [
    'grunt-urequire'
    'grunt-shell'
    'grunt-contrib-clean'
    'grunt-contrib-concat'
    'grunt-contrib-watch'
  ]

  null

module.exports = gruntFunction


