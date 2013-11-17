# requires grunt 0.4.x
sourceDir     = "source/code"
buildDir      = "build/UMD"
distDir       = "build/dist"
sourceSpecDir = "source/spec"
buildSpecDir  = "build/spec"


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

    # The `'urequire:XXX'` tasks in summary do some or all of those
    #  * derive from 'someTask' (and/or '_defaults') with some differences
    #  * have a `path` as a source
    #  * filter `filez` within the `path`
    #  * save everything at `dstPath`
    #  * converts all modules to UMD/AMD or a single `uberscore-min.js` with `combined` template
    #  * copies all other (non-module) files at `dstPath`
    #  * export a global `window._B` with a `noConflict()`
    #  * uglifies combined file with some `uglify2` settings
    #  * injects deps in modules
    #  * injects strings inside code bodies
    #  * add banners etc
    #  * manipulate modules:
    #     * remove some matched code 'skeletons'
    #     * replace some deps in arrays, `require`s etc
    #     * remove some code and a dependency from a specific file.
    urequire:
      # @note any urequire task starting with '_' is ignored as grunt target
      # and only used for `derive`-ing.
      # These are the defaults, when a task has no 'derive' at all.
      # Use `derive:[]` to skip deriving it in tasks with no 'derive'.
      _defaults:
        bundle:
          path: "#{sourceDir}"

          # include all but exclude some filez
          filez: [/./, '!**/draft/*.*', '!uRequireConfig*']

          # 2 ways to say "I want all non-`resource` matched filez to
          # be copied to build.dstPath"
          copy: [/./, '**/*.*']

          dependencies:

            # 'util' will not be added to deps array, will be available only
            # on nodejs execution. Same as 'node!myDep', but allows module
            # to run on nodejs without conversion. Not really need,
            # `node` defaults to all known 'nodejs' core packages
            node: 'util'

            # export to bundle (i.e inject some dependencies to all modules)
            exports: bundle:
              # simple syntax: depsVars infered from dep/variable bindings
              # of bundle or other known sources
              ['lodash', 'agreement/isAgree']
              # precise syntax: deps & their corresponding vars
              #  {'lodash': ['_'], 'agreement/isAgree': ['isAgree', 'isAgree2']}

          # define some Resource Converters
          resources: [

            # example: declare an RC to perform some 'concat/inject' job.
            [
              # Name this RC - note: '+' sets `isBeforeTemplate` flag:
              # this RC runs AFTER our Module's code is parsed and deps extracted/adjusted
              # right BEFORE running the template. Hence it  enables you do manipulate
              # the body & dependencies (it runs on Modules only).
              # Note: The `m.converted` IS NOT considered at this stage,
              # we are dealing with AST code & Module dependencies only.
              '~+inject:VERSION'

              # note: '~' in name means `isMatchSrcFilename:true`, so its matching
              # `uberscore.coffee`, instead of dstFilename `uberscore.js`
              ['uberscore.coffee']

              # Our `convert` callback, receives a Module instance
              (m)->
                # inject 'var VERSION=xxx' before the module's body code
                # m.afterBody also exists
                # inject any text (no need to be parseable code)
                m.beforeBody = "var VERSION='#{pkg.version}';"
                # no convFilename needed
            ]

            # example: perform some 'concat' job, AFTER the template conversion is done.
            [ # '!' means 'isAfterTemplate: true'
              '!banner:uberscore.js',
              # some description
              'concat/add banner to uberscore.js'
              # note we are looking to change the dstFilename `uberscore.js` (not `uberscore.coffee`).
              # We could have used ~ to match srcFilename
              ['uberscore.js']
              # r.converted holds our converted UMD code,
              # since this RC runs AFTER the template conversion
              (r)->"#{banner}\n#{r.converted}"
              # no convFilename needed
            ]


          ]

        build:
          # the following can be truethy/falsy or array of filez specs
          useStrict: true # default is false
          bare: false       # default is false
          globalWindow: false # default is true
          runtimeInfo: ['!**/*', 'Logger.js'] # default is true, allow it only ont these filez

          debugLevel: 0 # 0 is default, 100 the max

          # false is default, auto enabled if debugLevel >= 50
          verbose: false

      # The `'urequire:UMD'` task:
      #  * derives all from `'_defaults'` with the following differences:
      #  * converts each module in `path` to UMD
      #  * everything saved at `dstPath`
      #  * adds a banner (after UMD template conversion)
      UMD:
        # `build` and `bundle` hashes are not needed
        # keys are safelly recognised, even if they're not in them.
        #'build':

        # 'derive' is also not needed - by default it deep uDerives all '_defaults'.
        # To avoid use `derive:[]`.
        #'derive': ['_defaults']

        # template is not needed - 'UMD' is default
        template: 'UMDplain'
        # all files converted files are written here
        dstPath: "#{buildDir}"

      # beautiful AMD code, using github.com/mishoo/UglifyJS2 optimization
      AMD:
        template: 'AMD'
        dstPath: "build/AMD"
        optimize: uglify2:
          output: beautify: true
          compress: false
          mangle: false

      # a 'combined' build, - works with or without AMD loaders
      # on Web & nodejs as a plain `<script>` or `require('dep')`
      dev:
        template: 'combined'

        # template: 'combined' requires a 'main' module.
        # if 'main' is missing, then main is assumed to be `bundleName`,
        # which in turn is assumed to be grunt's @target ('dev' in this case).
        # Having 'dev' as the bundle.name/main, but no 'dev' module (or 'index' or 'main')
        # will cause a compilation error. Its better to be precise anyway,
        # in case this config is used outside grunt :-)
        main: 'uberscore'

        # the name of the combined file instead of a directory is needed for 'combined'
        dstPath: './build/dist/uberscore-dev.js'


      # The `'urequire:min'` task :
      #  * derives all from 'dev' (& '_defaults') with the following differences:
      #  * filters some more `filez`
      #  * converts to a single `uberscore-min.js` with `combined` template (r.js/almond)
      #  * uglifies the combined file with some `uglify2` settings
      #  * injects different deps in each module
      #  * manipulates each module:
      #     * removes some matched code 'skeletons'
      #     * replaces some deps in arrays, `require`s etc
      #     * removes some code and a dependency from a specific file.
      min:
        # derive, just for the example
        # we need to specify also '_defaults', in this order.
        derive: ['dev', '_defaults']

        ## 'override' this property
        dstPath: './build/dist/uberscore-min.js'

        # Lets optimize / minify the result
        # Doesn't have to be a String. `true` selects 'uglify2' with sane defaults.
        # It can also be 'uglify'.
        # Even more interestingly, u can pass any 'uglify2' (or 'uglify') keys,
        # the r.js way (https://github.com/jrburke/r.js/blob/master/build/example.build.js)
        # eg optimize: {uglify2: output: beautify: true}
        optimize: 'uglify2'

        # leave this file out (`filez` inherits its parent's `filez`, adding this spec)
        filez: ['!blending/deepExtend.coffee']

        resources: [
          [
            # An RC with the `isBeforeTemplate` '+' flag, runs ONLY on Modules
            '+remove:debug/deb & deepExtend'

            # All filez considered
            [/./]

            # `convert` function, passing a Module instance as the only argument
            (m)->
              # replace with nothing (i.e delete whole expression/statement)
              # any code that matches these code skeletons
              # Eg it matches `if (l.deb(30)){statement1;statement2;...}`
              # It MUST BE a valid Javascript String OR an AST sub-tree object
              # (only present keys are compared) - see esprima/Mozila AST parser specification
              for c in ['if (l.deb()){}', 'if (this.l.deb()){}', 'l.debug()', 'this.l.debug()']
                m.replaceCode c

              # Remove `deepExtend` key & dependency from this build
              # Since this RC runs on all Modules, limit to this one for efficiency
              if m.dstFilename is 'uberscore.js'

                # remove property/key `deepExtend: ...` from 'uberscore.js'
                m.replaceCode {type: 'Property', key: {type: 'Identifier', name: 'deepExtend'}}

                # actually remove dependency from all (resolved) arrays (NOT THE AST CODE).
                m.replaceDep 'blending/deepExtend'

                # With `isBeforeTemplate` rcs you can also :
                #   m.injectDeps {'deps/dep1': ['depVar1', 'depVar2'], ....}
                #   m.replaceDep 'types/type', 'types/myType'
          ]
        ]

      # uRequire-ing the specs: we also have two builds as 'UMD' & # as 'combined'
      spec:

        # disable derive-ing from '_defaults'
        derive: []
        path: "#{sourceSpecDir}"
        copy: [/./]
        dstPath: "#{buildSpecDir}"

        # declarativelly inject these dependencies on all modules
        dependencies: exports: bundle:
          chai: 'chai'
          lodash: '_'
          'uberscore': '_B'
          'spec-data': 'data'

      # deep inherits all of 'spec' BUT none of '_defaults':-)
      specCombined:
        derive: ['spec']
        dstPath: "#{buildSpecDir}_combined/index-combined.js"
        template: 'combined'

        # 'main' not needed: if `bundle.main` is undefined it defaults to `bundle.bundleName`
        # or 'index' or 'main' (whichever found 1st as a module on bundleRoot)
        # with the price of a warning! In spec's case, THERE IS a module
        # 'index.coffee' which is picked (with the price of a warning).
        #main: 'index'

      ### Examples showing off uRequire ###

      # EXAMPLE: how to reference (& `derive`-ing from) external urequire config file(s)
      # Its effectivelly equivalent to issuing:
      #  `$ urequire config source/code/uRequireConfig.coffee -o ./build/UMDFileConfigBuild -t UMD`
      fileConfig:
        # note: not deriving at all from '_defaults', unless its specified.
        derive: ['source/code/uRequireConfig.coffee']

        # overriding some of its parent (config file) options
        template: 'UMD'
        dstPath: 'build/UMDFileConfigBuild'

      # EXAMPLE: building only a sub-tree of the whole bundle.
      Logger:
        # 'main' Not needed: `name` & consequently `main` inherit grunt's task/target 'Logger'
        #main: 'Logger'

        # We build only 'Logger' (& its dependencies) in a 'combined' build.
        # @todo: Its ineffiecient in urequire 0.6, cause ALL modules are converted to AMD first,
        #  and then used as input to rjs.optimize which picks only dependent ones.
        #  http://github.com/anodynos/uRequire/issues/28
        template: 'combined'

        # export the module on `window._L`, # with a `noConflict()` baked in
        dependencies: exports: root: 'Logger':'_L'

        # minify it with uglify2
        optimize: true

        dstPath: 'build/Logger-min.js'

      # EXAMPLE: replace a bundle dependency with another, perhaps a mock
      UMDplainReplaceDep:
        # 'UMDplain' template - no dependency on uRequire's NodeRequirer on nodejs
        template: "UMDplain"

        # save to this destination path
        dstPath: "build/UMDplainReplaceDep"

        resources: [

          # first, create our hypothetical mock out of an existing module
          [ # a title with default flags
            "rename to 'types/isHashMock.js'"

            # a self descriptive RC.filez :-)
            ['types/isHash.js']

            # undefined `convert()` function - we only need to change the filename
            undefined

            # convFilame is a String: the `dstFilename` will change to that, and all modules
            # in bundle will noe know this resource/module by its new name (AND NOT the old)
            'types/isHashMock.js'
          ]

          # lets replace our dep
          [ # `isBeforeTemplate` flag '+', running on Modules only, just before Template is applied
            "+replace dependency 'types/isHash'"

            # run all on all matching `bundle.filez` (in all modules due to `isBeforeTemplate`)
            [/./]

            # call `m.replaceDep` in each module, passing old & new dep in bundleRelative format
            (m)-> m.replaceDep 'types/isHash', 'types/isHashMock'
          ]
        ]

      # EXAMPLE: replace a global dependency, whether existing in module code
      AMDunderscore:
        template: 'AMD'
        dstPath: "build/AMDunderscore"

        # defaults have a ['lodash',..]` - it will complain about 'lodash's
        # var binding, so use the '{dep: 'varName'} format
        dependencies: exports: bundle: 'lodash': '_'

        resources: [
          # although we inject 'lodash' in each module, change it
          # in modules  that still specifically may require it
          [ "+replace 'lodash' with 'underscore'", [/./]

            # note: `module.replaceDep` replaces all deps - even injected dependencies
            # in modules via `depenencies.exports.bundle` like lodash in this example.
            # The exception is 'combined' template, cause deps are NOT injected in modules
            # (they are available through closure). So if we were using 'combined' here,
            # we would need to change `depenencies.exports.bundle` to inject
            # the right ones (instead of just `replaceDep`-ing them).
            (m)->m.replaceDep 'lodash', 'underscore'
          ]
        ]

      # EXAMPLE: simple derivation
      UMDunderscore:
        derive: ['AMDunderscore', '_defaults']
        template: 'UMDplain'
        dstPath: "build/UMDunderscore"

      # EXAMPLE: marking as Resources, changing behaviors
      nodejsCompileAndCopy:
        template: 'nodejs'
        filez: ['uRequireConfig*.*']
        dstPath: "build/nodejsCompileAndCopy"

        # the default is to enclose in IFI, even for nodejs template
        # here we change default behavior
        bare: true

        # disable adding __isAMD, __isWeb & __isNode variables
        # if your code doesnt depend on them
        runtimeInfo: false

        # marking resources examples
        resources: [

          # EXAMPLE: compile a .coffee to .js, but dont treat it as a Module
          # marking a .coffee as 'TextResource' ('#' flag) is enough to compile as .js,
          # but exclude it from becoming a Module (i.e no UMD/AMD template is applied)
          [ "#~markAsTextResource", ["uRequireConfig.coffee"] ]

          # read file content, alter it & save under different name
          [
            # Mark as a FileResource - its content is not read on refresh
            "@markAsFileResource"

            # matching `filez` for this RC is just one file
            ["uRequireConfig_UMDBuild.json"]

            # `convert()` function
            (r)->

              # calling read() on the resource read its content, using @srcFilename within `bundle.path`
              content = '\n' + r.read()

              # save() under a different name (relative to bundle.path) & changed content
              r.save 'changedBundleFileName.json', content
          ]
        ]

    watch:
      UMD:
        files: ["#{sourceDir}/**/*.*", "#{sourceSpecDir}/**/*.*"]  # note: new subdirs dont work - https://github.com/gruntjs/grunt-contrib-watch/issues/70
        tasks: ['urequire:UMD' , 'urequire:spec', 'mocha']

      dev:
        files: ["#{sourceDir}/**/*.*", "#{sourceSpecDir}/**/*.*"]
        tasks: ['urequire:dev', 'urequire:specCombined', 'concat:specCombinedFakeModule', 'mochaCmdDev']

      min:
        files: ["#{sourceDir}/**/*.*", "#{sourceSpecDir}/**/*.*"]
        tasks: ['urequire:min', 'urequire:specCombined', 'concat:specCombinedFakeModuleMin', 'mochaCmdDev', 'run']

      options:
        # WARNING: urequire watch works ONLY with `spawn: false` (or nospawn:true in older versions)
        spawn: false
        # atBegin NOT WORKING: watch is not registered & __temp gets deleted.
        # Also occasional bug with grunt-watch causes constant rerun of tasks when mocha has errors
        # atBegin: true

    shell:
      mochaCmd: command: "node_modules/.bin/mocha #{buildSpecDir}/index --recursive" # --reporter spec"
      mochaCmdDev: command: "node_modules/.bin/mocha #{buildSpecDir}_combined/index-combined --recursive" # --reporter spec"
      doc: command: "codo #{sourceDir} --title 'uberscore <%= pkg.version %> API documentation' --cautious"
      run: command: "coffee source/examples/runExample.coffee"
      options: {verbose: true, failOnError: true, stdout: true, stderr: true}

    mocha:
      plainScript:
        src: [
          'build/spec/SpecRunner_almondJs_noAMD_plainScript.html'
          'build/spec/SpecRunner_almondJs_noAMD_plainScript_min.html'
        ]
        options: run: true

      AMD:
        src: [
          'build/spec/SpecRunner_unoptimized_AMD.html'
          'build/spec/SpecRunner_almondJs_AMD.html'
        ]

    concat:
      'dev':
        options: banner: "<%= meta.banner %>"
        src: ['<%= options.distDir %>/uberscore-dev.js']
        dest: '<%= options.distDir %>/uberscore-dev.js'

      'min':
        options: banner: "<%= meta.bannerMin %>"
        src: ['<%= options.distDir %>/uberscore-min.js']
        dest: '<%= options.distDir %>/uberscore-min.js'

      'specCombinedFakeModule':
        options: banner: '{"name":"uberscore", "main":"../../../dist/uberscore-dev.js"}'
        src:[]
        dest: 'build/spec_combined/node_modules/uberscore/package.json'

      'specCombinedFakeModuleMin':
        options: banner: '{"name":"uberscore", "main":"../../../dist/uberscore-min.js"}'
        src:[]
        dest: 'build/spec_combined/node_modules/uberscore/package.json'

    clean: files: ["build/**/*.*"]

  ### shortcuts generation ###
  splitTasks = (tasks)-> if !_.isString tasks then tasks else (_.filter tasks.split(' '), (v)-> v)
  grunt.registerTask cmd, splitTasks "shell:#{cmd}" for cmd of gruntConfig.shell # shortcut to all "shell:cmd"
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
     # generic shortcuts
     "default":   "build dev min test testDev testMin mocha:AMD run"
     "release":   "build urequire:AMD urequire:AMDunderscore dev min test testDev testMin mocha run"
     "examples":  "urequire:AMD urequire:UMDplainReplaceDep urequire:AMDunderscore urequire:UMDunderscore urequire:nodejsCompileAndCopy"
     "all":       "build dev min test testDev testMin mocha examples run"
     "build":     "urequire:UMD"
     "dev":       "urequire:dev concat:dev"
     "min":       "urequire:min concat:min"

     "test":      "urequire:spec mochaCmd"
     "testDev":   "urequire:specCombined concat:specCombinedFakeModule mochaCmdDev"
     "testMin":   "concat:specCombinedFakeModuleMin mochaCmdDev"

    # generic shortcuts
     "cl":      "clean"
     "b":       "build"
     "d":       "dev"
     "dm":      "min"
     "m":       "mochaCmd"
     "md":      "mochaCmdDev"
     "t":       "test"
     "td":      "testDev"
     "tm":      "testMin"
     "wu":      "clean watch:UMD"
     "wd":      "clean watch:dev"

     # IDE shortcuts
     "alt-c": "cp"
     "alt-b": "b"
     "alt-d": "d"
     "alt-t": "t"
  }

  grunt.loadNpmTasks task for task in [
    'grunt-urequire'
    'grunt-shell'
    'grunt-contrib-clean'
    'grunt-contrib-concat'
    'grunt-contrib-watch'
    'grunt-mocha'
    #'grunt-bower-requirejs'
  ]

  grunt.initConfig gruntConfig

  null

module.exports = gruntFunction


