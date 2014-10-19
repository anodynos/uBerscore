# for uRequire comments & examples see Gruntfile_CommentsExamples.coffee
startsWith = (string, substring) -> string.lastIndexOf(substring, 0) is 0
S = if process.platform is 'win32' then '\\' else '/'
nodeBin       = "node_modules#{S}.bin#{S}"
_ = require 'lodash'

sourceDir     = "source/code"
buildDir      = "build"
sourceSpecDir = "source/spec"
buildSpecDir  = "build/spec"

module.exports = gruntFunction = (grunt) ->
  pkg = grunt.file.readJSON 'package.json'

  gruntConfig =
    urequire:
      _defaults:
        bundle:
          path: "#{sourceDir}"
          filez: [/./, '!**/draft/*', '!uRequireConfig*']
          copy: [/./]
          main: 'uberscore'
          resources: [ 'inject-version' ]
          dependencies:
            exports: bundle: # deprecated to simple "imports:"- but still works!
              lodash: ['_']
              'agreement/isAgree': ['isAgree']

        build:
          template:
            banner: """
             /**
              * #{ pkg.name } - version #{ pkg.version }
              * Compiled on #{ grunt.template.today("yyyy-mm-dd h:MM:ss") }
              * #{ pkg.repository.url }
              * Copyright(c) #{ grunt.template.today("yyyy") } #{ pkg.author.name } (#{ pkg.author.email } )
              * Licensed #{ pkg.licenses[0].type } #{ pkg.licenses[0].url }
              */\n"""
            debugLevel: 0

          globalWindow: false
          runtimeInfo: ['Logger']
          useStrict: ['!**/*', 'uberscore']
          injectExportsModule: ['uberscore']
          exportsRoot: ['script', 'node']
          clean: true
#          verbose: true
#          debugLevel: 0

      UMD:
        template: 'UMDplain'
        dstPath: "#{buildDir}/UMD"

      AMD:
        template: 'AMD'
        dstPath: "#{buildDir}/AMD"
        optimize: uglify2:
          output: beautify: true
          compress: false
          mangle: false

      dev:
        template:
          name: 'combined'
          moduleName: 'uberscore'

        dstPath: "#{buildDir}/uberscore-dev.js"

      min:
        derive: ['dev', '_defaults']
        dstPath: "#{buildDir}/uberscore-min.js"
        optimize: 'uglify2'
        filez: ['!blending/deepExtend.coffee']

        resources: [
          [
            '+remove:debug/deb & deepExtend', [/./]
            (m)->
              for c in ['if (l.deb()){}', 'if (this.l.deb()){}', 'l.debug()', 'this.l.debug()']
                m.replaceCode c

              if m.path is 'uberscore'
                m.replaceCode {type: 'Property', key: {type: 'Identifier', name: 'deepExtend'}}
                m.replaceDep 'blending/deepExtend'
          ]
        ]

        rjs: preserveLicenseComments: false

      spec:
        derive: []
        path: "#{sourceSpecDir}"
        copy: [/./]
        dstPath: "#{buildSpecDir}"

        dependencies: imports:
          chai: 'chai'
          lodash: ['_']
          uberscore: ['_B']
          specHelpers: 'specHelpers'
          'spec-data': 'data'

        resources: [
          [ '+inject-_B.logger', ['**/*.js'], (m)-> m.beforeBody = "var l = new _B.Logger('#{m.dstFilename}');"]

          ['import',
            specHelpers: [
               'equal', 'notEqual', 'ok', 'notOk', 'tru', 'fals' , 'deepEqual', 'notDeepEqual',
               'exact', 'notExact', 'iqual', 'notIqual', 'ixact', 'notIxact', 'like', 'notLike',
               'likeBA', 'notLikeBA', 'equalSet', 'notEqualSet' ]
            chai: ['expect'] ] ]
#        verbose: true
#        debugLevel: 40

      specCombined:
        derive: ['spec']
        dstPath: "#{buildSpecDir}_combined/index-combined.js"
        template: name: 'combined'

    watch:
      options: spawn: false
      UMD:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]
        tasks: ['urequire:UMD' , 'urequire:spec', 'mocha:UMD']
      dev:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]
        tasks: ['urequire:dev', 'urequire:specCombined', 'concat:specCombinedFakeModule', 'mochaCmdDev']
      min:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]
        tasks: ['urequire:min', 'urequire:specCombined', 'concat:specCombinedFakeModuleMin', 'mochaCmdDev', 'run']

    shell:
      mochaCmd: command: "#{nodeBin}mocha #{buildSpecDir}/index --recursive " #--reporter spec"
      mochaCmdDev: command: "#{nodeBin}mocha #{buildSpecDir}_combined/index-combined --recursive --reporter min"
      run: command: "#{nodeBin}coffee source/examples/runExample.coffee"
      options: {verbose: true, failOnError: true, stdout: true, stderr: true}

    mocha:
      plainScript:
        src: [
          "#{buildSpecDir}/SpecRunner_almondJs_noAMD_plainScript.html"
          "#{buildSpecDir}/SpecRunner_almondJs_noAMD_plainScript_min.html"]
        options: run: true

      UMD: src: ["#{buildSpecDir}/SpecRunner_unoptimized_UMD.html"]
      almondAMD: src: ["#{buildSpecDir}/SpecRunner_almondJs_AMD.html"]

    concat:
      specCombinedFakeModule:
        options: banner: '{"name":"uberscore", "main":"../../../uberscore-dev.js"}'
        src:[]
        dest: "#{buildSpecDir}_combined/node_modules/uberscore/package.json"

      specCombinedFakeModuleMin:
        options: banner: '{"name":"uberscore", "main":"../../../uberscore-min.js"}'
        src:[]
        dest: "#{buildSpecDir}_combined/node_modules/uberscore/package.json"

    clean: files: [buildDir]

  ### shortcuts generation ###
  splitTasks = (tasks)-> if !_.isString tasks then tasks else (_.filter tasks.split(/\s/), (v)-> v)
  for task in ['shell', 'urequire']
    for cmd of gruntConfig[task]
      grunt.registerTask cmd, splitTasks "#{task}:#{cmd}"

  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
     default:   "build test dev testDev min testMin run"
     release:   "clean build test dev testDev min testMin mocha urequire:AMD run"
     build:     "urequire:UMD"

     test:      "urequire:spec mochaCmd"
     testDev:   "urequire:specCombined concat:specCombinedFakeModule mochaCmdDev"
     testMin:   "concat:specCombinedFakeModuleMin mochaCmdDev"
  }

  grunt.loadNpmTasks task for task of pkg.devDependencies when startsWith(task, 'grunt-')
  grunt.initConfig gruntConfig