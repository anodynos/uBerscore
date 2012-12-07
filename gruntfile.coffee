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
        command: "urequire UMD ./#{sourceDir} -o ./#{buildDir}"

      uRequireSpec:
        command: "urequire UMD ./#{sourceSpecDir} -o ./#{buildSpecDir}"

      urequireCombine:
        command: "urequire config source/code/uRequireConfig.coffee"

      mocha:
        command: "mocha #{buildSpecDir} --recursive --bail --reporter spec"

      doc:
        command: "codo source/code --title 'uBerscore #{pkg.version} API documentation' --cautious"

      runAlmondInNode:
        command: "node build/code/draft/draft.js"

      _options: # subtasks inherit _options but can override them
        failOnError: true
        stdout: true
        stderr: true

    concat:
      bin:
        src: [
          '<banner>'
          '<banner:meta.varVersion>'
          '<%= options.buildDir %>/uBerscore.js'
        ]
        dest:'<%= options.buildDir %>/uBerscore.js'

    copy:

      code: files:"<%= options.buildDir %>/":
            ("#{sourceDir}/**/#{ext}" for ext in ["*.html", "*.js", "*.txt", "*.json" ])
      spec: files:"<%= options.buildSpecDir %>/":
        ("#{sourceSpecDir}/**/#{ext}" for ext in ["*.html", "*.js", "*.txt", "*.json" ])

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
     "default": "cl b test"
     "build":   "ur cp concat"
     "deploy":  "urequireCombine" #rjsBuildAlmondMin
     "test":    "urs copy mocha runAlmondInNode"

      # generic shortcuts (coffee is gone!)
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