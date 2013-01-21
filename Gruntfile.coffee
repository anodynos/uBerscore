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

    shell:
      uRequire:
        # use a uRequire config, changing the template, outputPath via CMD options (which have precedence over configFiles)
        command_NotUsed: "urequire config source/code/uRequireConfig.coffee -o ./build/code -t UMD"
        # use a 2nd uRequireConfig for demonstration, instead of the above. Configs on the right have precedence
        command: "urequire config source/code/uRequireConfig_UMDBuild.json,source/code/uRequireConfig.coffee"

      uRequireCombine:
        command: "urequire config source/code/uRequireConfig.coffee -v"

      uRequireSpec:
        command: "urequire UMD ./#{sourceSpecDir} -o ./#{buildSpecDir}"

      mocha:
        command: "mocha #{buildSpecDir} --recursive --bail --reporter spec"

      doc:
        command: "codo source/code --title 'uBerscore #{pkg.version} API documentation' --cautious"
        
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
          '<%= options.distDir %>/uBerscore-dev.js'
        ]
        dest:'<%= options.distDir %>/uBerscore-dev.js'

# copy gone - done by uRequire
#    copy:
#      code: files:"<%= options.buildDir %>/":
#            ("#{sourceDir}/**/#{ext}" for ext in ["*.html", "*.js", "*.txt", "*.json" ])
#      spec: files:"<%= options.buildSpecDir %>/":
#        ("#{sourceSpecDir}/**/#{ext}" for ext in ["*.html", "*.js", "*.txt", "*.json" ])

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
     "default": "clean build deploy doc test"
     "build":   "ur"
     "deploy":  "shell:uRequireCombine concat"
     "test":    "urs mocha runBuildExample runAlmondBuildExample"

    # generic shortcuts
     "cl":      "clean"
     "cp":      "copy" #" todo: all ?
     "ur":      "shell:uRequire"
     "urs":     "shell:uRequireSpec"
     "b":       "build"
     "d":       "deploy"
     "t":       "test"
  }

  grunt.registerTask shortCut, tasks for shortCut, tasks of {
    "alt-c": "cp"
    "alt-b": "b"
    "alt-d": "d"
    "alt-t": "t"
  }


  grunt.initConfig gruntConfig
  grunt.loadNpmTasks 'grunt-contrib'
  grunt.loadNpmTasks 'grunt-shell' #https://npmjs.org/package/grunt-shell

  null

#debug : call with a dummy 'grunt', that spits params on console.log
#gruntFunction
#  initConfig: (cfg)-> console.log 'grunt: initConfig\n', JSON.stringify cfg, null, ' '
#  loadNpmTasks: (tsk)-> console.log 'grunt: registerTask: ', tsk
#  registerTask: (shortCut, task)-> console.log 'grunt: registerTask:', shortCut, task
module.exports = gruntFunction