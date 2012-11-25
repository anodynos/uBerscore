_fs = require 'fs'

gruntFunction = (grunt) ->

  sourceDir     = "source/code"
  buildDir      = "build/code"
  sourceSpecDir = "source/spec"
  buildSpecDir  = "build/spec"

  pkg = JSON.parse _fs.readFileSync './package.json', 'utf-8'

  globalBuildCode = switch process.platform
    when "win32" then "c:/Program Files/nodejs/node_modules/uberscore/build/code/"
    when 'linux' then "/usr/local/lib/node_modules/uberscore/build/code/"
    else ""

  globalClean = switch process.platform
    when "win32" then  "c:/Program Files/nodejs/node_modules/uberscore/build/code/**/*.*"
    when 'linux' then "/usr/local/lib/node_modules/uberscore/build/code/**/*.*"
    else ""

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
      usrBinEnvNode: "#!/usr/bin/env node"

    options:
      sourceDir:     sourceDir
      buildDir:      buildDir
      sourceSpecDir: sourceSpecDir
      buildSpecDir:  buildSpecDir
      globalBuildCode: globalBuildCode
      globalClean: globalClean

    shell:
      coffee:
        command: "coffee -cb -o ./#{buildDir} ./#{sourceDir}"

      coffeeSpec:
        command: "coffee -cb -o ./#{buildSpecDir} ./#{sourceSpecDir}"

      coffeeWatch:
        command: "coffee -cbw -o ./#{buildDir} ./#{sourceDir}"

      uRequire:
        command: "urequire UMD ./#{buildDir} -f"

      uRequireSpecs:
        command: "urequire UMD ./#{buildSpecDir} -f"

      mocha:
        command: "mocha #{buildSpecDir} --recursive --bail --reporter spec"

      doc:
        command: "codo source/code --title 'uBerscore #{pkg.version} API documentation' --cautious"

      _options: # subtasks inherit _options but can override them
        failOnError: true
        stdout: true
        stderr: true

    concat:
      bin:
        src: [
          '<banner:meta.usrBinEnvNode>'
          '<banner>'
          '<banner:meta.varVersion>'
          '<%= options.buildDir %>/uBerscore.js'
        ]
        dest:'<%= options.buildDir %>/uBerscore.js'

#    copy:
#      spec: files:"<%= options.buildSpecDir %>/":
#            ("#{sourceSpecDir}/**/#{ext}" for ext in []) # "*.html", "*.js", "*.txt", "*.json" ])
#
#      code: files:"<%= options.buildDir %>/":
#            ("#{sourceDir}/**/#{ext}" for ext in []) # "*.html", "*.js", "*.txt", "*.json" ])

    clean:
        files: [
          "<%= options.buildDir %>/**/*.*"
          "<%= options.buildSpecDir %>/**/*.*"
        ]

  ### shortcuts generation ###

  # shortcut to all "shell:cmd"
  grunt.registerTask cmd, "shell:#{cmd}" for cmd of gruntConfig.shell

  # generic shortcuts
  grunt.registerTask shortCut, tasks for shortCut, tasks of {
     # basic commands
     "default": "clean build test"
     "build":   "cf concat" #ur
     "test":    "coffeeSpec mocha"
      # generic shortcuts
     "cf":      "shell:coffee" # there's a 'coffee' task already!
     "cfw":     "coffeeWatch"
     "cl":      "clean"
     "cp":      "copy" #" todo: all ?
     "ur":      "shell:uRequire"
     "b":       "build"
     "t":       "test"
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