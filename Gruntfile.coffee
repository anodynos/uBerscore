# requires grunt 0.4.x
sourceDir     = "source/code"
buildDir      = "build/code"
sourceSpecDir = "source/spec"
buildSpecDir  = "build/spec"
distDir       = "build/dist"

gruntFunction = (grunt) ->
  _ = grunt.util._

  gruntConfig =
    pkg: grunt.file.readJSON('package.json')

    meta:
      banner: """
        /*
        * <%= pkg.name %> - version <%= pkg.version %>
        * Compiled on <%= grunt.template.today(\"yyyy-mm-dd h:MM:ss\") %>
        * <%= pkg.repository.url %>
        * Copyright(c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %> (<%= pkg.author.email %> )
        * Licensed <%= pkg.licenses[0].type %> <%= pkg.licenses[0].url %>
        */\n"""
      bannerMin: """
        /* <%= pkg.name %> <%= pkg.version %> (<%= grunt.template.today(\"yyyy-mm-dd\") %>), <%= pkg.repository.url %>
           <%= pkg.author.email %>, Lisense: <%= pkg.licenses[0].type %> */\n"""
      varVERSION: "var VERSION = '<%= pkg.version %>'; //injected by grunt:concat\n"
      varVERSIONMin: "var VERSION='<%= pkg.version %>\n';"
      mdVersion: "# uBerscore v<%= pkg.version %>\n"

    options: {sourceDir, buildDir, sourceSpecDir, buildSpecDir, distDir}

    ###
      uRequire config for uBerscore is used as a testbed & example, thus so many comments :-)
    ###
    urequire:
      # These are the defaults, when a task has no 'derive' at all. Use derive:[] to skip deriving it.
      # @note that any urequire task starting with '_' is ignored as a grunt target and only used for `derive`-ing.
      # @todo: On derive: a) allow dropping of cyclic references. b) fix file reference paths ALWAYS being relative to the initial path (the path used for 1st file), instead of file referencing.
      _defaults:
        bundle:
          bundlePath: "#{sourceDir}"
          ignore: [/^draft/, 'uRequireConfig_UMDBuild.json', 'uRequireConfig.coffee'] #completelly ignore these
          dependencies:
            bundleExports: #['lodash', 'agreement/isAgree'] # simple syntax
              'lodash':"_",                               # precise syntax
              'agreement/isAgree': 'isAgree'
            noWeb: ['util']
        build:
          verbose: false # false is default
          debugLevel: 0  # 0 is default

      # a simple UMD build
      uberscoreUMD:
        #'build': # `build` and `bundle` hashes are not needed - keys are safelly recognised, even if they're not in them.
        #'derive': ['_defaults'] # not needed - by default it deep uDerives all '_defaults'. To avoid use `derive:[]`.
          #template: 'UMD' # Not needed - 'UMD' is default
          outputPath: "#{buildDir}"

      # a 'combined' build, that also works without AMD loaders on Web
      uberscoreDev:
        main: 'uberscore' # if 'main' is missing, then main is assumed to be `bundleName`,
                          # which in turn is assumed to be grunt's @target ('uberscoreDev' in this case).
                          # Having 'uberscoreDev' as the bundleName/main, but no module by that name (or 'index' or 'main')
                          # will cause a compilation error. Its better to be precise anyway, in case this config is used outside grunt.

        outputPath: './build/dist/uberscore-dev.js'
        template: 'combined'

      # A combined build, that is `derive`d from 'uberscoreDev' (& specifically '_defaults')
      # that uses re.js/uglify2 for minification.
      uberscoreMin:
        derive: ['uberscoreDev', '_defaults'] # need to specify we also need '_defaults', in this order.
        outputPath: './build/dist/uberscore-min.js'
        optimize: 'uglify2' # doesn't have to be a String. `true` selects 'uglify2' also. It can also be 'uglify'.
                            # Even more interestingly, u can pass any 'uglify2' keys,
                            # the r.js way (https://github.com/jrburke/r.js/blob/master/build/example.build.js)
                            # eg {optimize: uglify2: output: beautify: true}

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
        outputPath: 'build/anotherUMDBuild'

      # uRequire-ing the specs: we also have two build as 'UMD' & as 'combined'
      spec: # deep inherits all '_defaults', by default :-)
        bundlePath: "#{sourceSpecDir}"
        outputPath: "#{buildSpecDir}"
        dependencies:
          bundleExports:
            chai: 'chai'
            lodash: '_'
            uberscore: '_B'
            'spec-data': 'data'
            # assert = chai.assert # @todo(for uRequire 4 5 5) allow for . notation to refer to export!

      specCombined:
        derive: ['spec'] # deep inherits all of 'spec' BUT none of '_defaults':-)
        outputPath: "#{buildSpecDir}_combined/index-combined.js"
        template: 'combined'
        #main: 'index' # not needed: if `bundle.main` is undefined it defaults
                       # to `bundle.bundleName` or 'index' or 'main' (whichever found 1st as a module on bundleRoot)
                       # with the price of a warning! In spec's case, THERE IS a module 'index.coffee' which is picked.
        dependencies:
          variableNames:
            uberscore: ['_B', 'uberscore']

    shell:
      mocha:
        command: "mocha #{buildSpecDir}/index --recursive --bail --reporter spec"

      doc:
        command: "codo source/code --title 'uberscore <%= pkg.version %> API documentation' --cautious"

      runBuildExample:
        command: "coffee source/examples/buildExample.coffee"

      runAlmondBuildExample:
        command: "coffee source/examples/almondBuildExample.coffee"

      options:
        verbose: true
        failOnError: true
        stdout: true
        stderr: true

    concat:
      'uberscoreUMD':
        options: banner: "<%= meta.banner %><%= meta.varVERSION %>"
        src: ['<%= options.buildDir %>/uberscore.js']
        dest:'<%= options.buildDir %>/uberscore.js'

      'uberscoreDev':
        options: banner: "<%= meta.banner %><%= meta.varVERSION %>"
        src: ['<%= options.distDir %>/uberscore-dev.js']
        dest: '<%= options.distDir %>/uberscore-dev.js'

      'uberscoreMin':
        options: banner: "<%= meta.bannerMin %><%= meta.varVERSIONMin %>"
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
     "default":   "build deploy test"
     "build":     "urequire:uberscoreUMD concat:uberscoreUMD"
     "deploy":    "urequire:uberscoreDev concat:uberscoreDev"
     "deploymin": "urequire:uberscoreMin concat:uberscoreMin"
     "test":      "urequire:spec urequire:specCombined mocha run"
     "run":       "runBuildExample runAlmondBuildExample"

    # generic shortcuts
     "cl":      "clean"
     "b":       "build"
     "d":       "deploy"
     "dm":      "deploymin"
     "m":       "mocha"
     "t":       "test"

     # IDE shortcuts
     "alt-c": "cp"
     "alt-b": "b"
     "alt-d": "d"
     "alt-t": "t"
  }

  grunt.initConfig gruntConfig
  grunt.loadNpmTasks 'grunt-contrib'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-urequire'

  null

#debug : call with a dummy 'grunt', that spits params on console.log
#gruntFunction
#  util:'_': require 'lodash'
#  initConfig: (cfg)-> console.log 'grunt: initConfig\n', JSON.stringify cfg, null, ' '
#  loadNpmTasks: (tsk)-> console.log 'grunt: registerTask: ', tsk
#  registerTask: (shortCut, task)-> console.log 'grunt: registerTask:', shortCut, ': ', task

module.exports = gruntFunction


