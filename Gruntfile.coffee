_fs = require 'fs'

gruntFunction = (grunt) ->

  sourceDir     = "source/code"
  buildDir      = "build/code"
  sourceSpecDir = "source/spec"
  buildSpecDir  = "build/spec"
  distDir       = "build/dist"

  pkg = JSON.parse _fs.readFileSync './package.json', 'utf-8'

  gruntConfig =
    pkg: "<json:package.json>"

    meta:
      banner: """
      /*!
      * <%= pkg.name %> - version <%= pkg.version %>
      * Compiled on <%= grunt.template.today(\"yyyy-mm-dd\") %>
      * <%= pkg.repository.url %>
      * Copyright(c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %> (<%= pkg.author.email %> )
      * Licensed <%= pkg.licenses[0].type %> <%= pkg.licenses[0].url %>
      */
      """
      varVersion: "var version = '<%= pkg.version %>'; //injected by grunt:concat"
      mdVersion: "# uBerscore v<%= pkg.version %>"

    options: {
      sourceDir
      buildDir
      sourceSpecDir
      buildSpecDir
      distDir
    }

    urequire: # shell: uRequireSpec
      _defaults: #todo: do it!
        bundle:
          bundlePath: "#{sourceDir}"
          ignore: [/^draft/]
          dependencies:
            noWeb: ['util']

        build:
          verbose: false
#          debugLevel: 60

      uberscoreUMD:
        dependencies:
          bundleExports: #['lodash', 'agreement/isAgree'] # simple syntax
            'lodash':"_",                               # precise syntax
            'agreement/isAgree': 'isAgree'

        outputPath: "#{buildDir}"
        # template: 'UMD' # 'UMD' is default

      'uberscore': # combined
        dependencies:
          bundleExports: #['lodash', 'agreement/isAgree'] # simple syntax
            'lodash':"_",                               # precise syntax
            'agreement/isAgree': 'isAgree'

        main: "uberscore" # Needed only for 'combined'.
                           # Defaults to 'bundleName' if its a valid module.
                           # 'bundleName' it self defaults to
                           # grunt's @target (subtask name) i.e 'uberscore'
        outputPath: './build/dist/uberscore-dev.js'
        template: 'combined'

#      uberscore-min:
#        main: uberscore
#        ignore: ['inspect', 'Logger'] #@todo: make this baby work (use moduleInjection?) !

      spec:
        bundlePath: "#{sourceSpecDir}"
        outputPath: "#{buildSpecDir}"
        #template: 'UMD' # 'UMD' is default
        dependencies:
          bundleExports:
            chai: 'chai'
            lodash: '_'
            uberscore: '_B'
            'spec-data': 'data'
            # assert = chai.assert #todo(for uRequire 4 5 5) allow for . notation to refer to export!


#      oneFile:
#        outputPath: "#{buildDir}"
#        processModules: ["go.coffee"]
#        debugLevel: 80
        # template: 'UMD' # 'UMD' is default

      specCombined:
        bundlePath: "#{sourceSpecDir}"
        main: 'index' # not needed:
                      # if `bundle.main` is undefined,
                      #   it defaults to `bundle.bundleName` or 'index' or 'main'
                      #   with the price of a warning!
        dependencies:
          variableNames: uberscore: ['_B', 'uberscore']
          bundleExports: # '<%= options.urequire.spec.dependencies.bundleExports %>' #@todo: why not working ? Missing something in grunt-urequire ?
            chai: 'chai'
            lodash: '_'
            uberscore: '_B'
            'spec-data': 'data'
        outputPath: "#{buildSpecDir}_combined/index-combined.js"
        template: 'combined'

    shell:
      ###    shell:uRequireXXX not used anymore - grunt-urequire is used instead! ###
#      uRequire:
#        # use a uRequire config, changing the template, outputPath via CMD options (which have precedence over configFiles)
#        command_NotUsed: "urequire config source/code/uRequireConfig.coffee -o ./build/code -t UMD"
#        # use a 2nd uRequireConfig for demonstration, instead of the above. Configs on the right have precedence
#        command: "urequire config source/code/uRequireConfig_UMDBuild.json,source/code/uRequireConfig.coffee"
#
#      uRequireCombined:
#        command: "urequire config source/code/uRequireConfig.coffee -v"
#
#      uRequireSpec:
#        command: "urequire UMD ./#{sourceSpecDir} -o ./#{buildSpecDir}"

      mocha:
        command: "mocha #{buildSpecDir}/index --recursive --bail --reporter spec"

      mochaBlending:
        command: "mocha #{buildSpecDir}/blending --recursive --bail --reporter spec"

      doc:
        command: "codo source/code --title 'uberscore #{pkg.version} API documentation' --cautious"
        
      runBuildExample:
        command: "coffee source/examples/buildExample.coffee"

      runAlmondBuildExample:
        command: "coffee source/examples/almondBuildExample.coffee"

      _options: # subtasks inherit _options but can override them
        failOnError: true
        stdout: true
        stderr: true

    concat:
      bin:
        src: [
          '<banner>'
          #'<banner:meta.varVersion>'
          '<%= options.distDir %>/uberscore-dev.js'
        ]
        dest:'<%= options.distDir %>/uberscore-dev.js'

    clean:
        files: [
          "<%= options.buildDir %>/**/*.*"
          "<%= options.buildSpecDir %>/**/*.*"
          "<%= options.distDir %>/**/*.*"
        ]

  ### shortcuts generation ###

  # shortcut to all "shell:cmd"
  grunt.registerTask cmd, "shell:#{cmd}" for cmd of gruntConfig.shell

  # generic shortcuts
  grunt.registerTask shortCut, tasks for shortCut, tasks of {
     # basic commands
     "default": "clean build deploy test"
     "build":   "urequire:uberscoreUMD"
     "deploy":  "urequire:uberscore"
     "test":    "urequire:spec urequire:specCombined mocha run"
     "run":     "runBuildExample runAlmondBuildExample"

    # generic shortcuts
     "cl":      "clean"
     "cp":      "overwrite" #" todo: all ?
     "ur":      "urequire:uberscoreUMD"
     "urc":     "urequire:uberscore"
     "b":       "build"
     "d":       "deploy"
     "t1":      "urequire:spec mocha"
     "tb":      "urequire:spec mochaBlending"
     "t":       "test"
  }

  grunt.registerTask shortCut, tasks for shortCut, tasks of {
    "alt-c": "cp"
    "alt-b": "b"
    "alt-d": "d"
    "alt-t": "t1"
  }


  grunt.initConfig gruntConfig
  grunt.loadNpmTasks 'grunt-contrib'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-urequire'

  null

#debug : call with a dummy 'grunt', that spits params on console.log
#gruntFunction
#  initConfig: (cfg)-> console.log 'grunt: initConfig\n', JSON.stringify cfg, null, ' '
#  loadNpmTasks: (tsk)-> console.log 'grunt: registerTask: ', tsk
#  registerTask: (shortCut, task)-> console.log 'grunt: registerTask:', shortCut, task
module.exports = gruntFunction