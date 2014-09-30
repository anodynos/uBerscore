# devDependencies: { grunt: '0.4.1', urequire: '>=0.6.8' }
startsWith = (string, substring) -> string.lastIndexOf(substring, 0) is 0
_ = require 'lodash'

sourceDir     = "source/code"
buildDir      = "build"
sourceSpecDir = "source/spec"
buildSpecDir  = "build/spec"

S = if process.platform is 'win32' then '\\' else '/' # OS directory separator
nodeBin       = "node_modules#{S}.bin#{S}"            # run from local node_modules,

module.exports = gruntFunction = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  gruntConfig =

    ### NOTE: uRequire config is used as a testbed & example, thus so many comments :-) ###
    # The `'urequire:XXX'` tasks in summary do some or all of those
    #  * derive (inherit) from 'someTask' (and/or '_defaults')
    #  * have a `path` as a source
    #  * filter `filez` within the `path`
    #  * save everything at `dstPath`
    #  * converts all modules to UMD/AMD or `uberscore-min.js`
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
      # @note any task starting with '_' is ignored as grunt target
      # and only used for `derive`-ing.
      # These are the defaults, when a task has no 'derive' at all.
      # Use `derive:[]` to skip deriving it in tasks with no 'derive'.
      _defaults:
        bundle:
          path: "#{sourceDir}"
          # include all but exclude some filez
          filez: [/./, '!**/draft/*', '!uRequireConfig*']
          # 2 ways to say "I want all non-`resource` matched filez to
          # be copied to build.dstPath"
          copy: [/./, '**/*']
          dependencies:
            # 'util' wont be added to AMD deps, will be available only
            # on nodejs execution. Same as 'node!myDep', but allows module
            # to run on nodejs without conversion. Not really need,
            # `node` defaults to all known 'nodejs' core packages
            node: ['util'] #, 'when/node/function']
            # export to bundle (i.e inject some deps to all modules)
            exports: bundle:
              # simple syntax: depsVars infered from dep/variable bindings
              # of bundle or other known sources
              #['lodash', 'agreement/isAgree']
              # precise syntax: deps & their corresponding var(s)
              lodash: ['_']
              'agreement/isAgree': ['isAgree'] # with [] or not, the same result

            #locals: 'when'

          # define some Resource Converters, common to all tasks
          resources: [
            # example: declare an RC to perform some 'concat/inject' job.
            [
              # Name this RC - note: '+' sets `isBeforeTemplate` flag:
              # this RC runs AFTER our Module is parsed and deps extracted
              # right BEFORE running the template.
              '~+inject:VERSION'
              # '~' name flag `isMatchSrcFilename:true` so its matching
              # `uberscore.coffee`, instead of dstFilename `uberscore.js`
              ['uberscore.coffee']
              # Our `convert` callback, receives a Module instance
              (m)->
                # inject 'var VERSION=xxx' before the module's body code
                # inject any text (no need to be parseable code)
                m.beforeBody = "var VERSION='#{pkg.version}';"
                # m.afterBody also exists

              # no convFilename needed
            ]
          ]

          # Only template 'combined' requires a `bundle.main`,
          # pointing to the 'main' module of the bundle (that loads
          #  all other modules and kicks off the bundle).
          # If 'bundle.main' is missing, its assumed `bundle.name`,
          #  (which in turn is grunt's @target).
          #
          # If no main module is found named after `bundle.main`
          # or `bundle.name` or 'index' or 'main',
          # a compilation error occurs on the combined template.
          #
          # Its better to be precise anyway.
          # `bundle.main` also used to concat `build.template.banner`
          # to your main module, so we declare it on _default.
          main: 'uberscore'

        build:
          # not setting any particular template,
          # just some settings for the code generation
          template:
            # contents of banner are added as-is before `bundle.main`
            banner: """
             /**
              * #{ pkg.name } - version #{ pkg.version }
              * Compiled on #{ grunt.template.today("yyyy-mm-dd h:MM:ss") }
              * #{ pkg.repository.url }
              * Copyright(c) #{ grunt.template.today("yyyy") } #{ pkg.author.name } (#{ pkg.author.email } )
              * Licensed #{ pkg.licenses[0].type } #{ pkg.licenses[0].url }
              */\n"""
            debugLevel: 0

          # the following can be truethy/falsy or array of filez specs
          globalWindow: false # default is true
          # runtimeInfo defaults to true - we disable on all but one
          runtimeInfo: ['Logger']
          # debugLevel of the build process, default is 0, max is 100
          debugLevel: 0
          # verbose default is `false`, auto enabled if debugLevel >= 50
          verbose: false

          # inject 'use strict;' only on this module (on all templates)
          # just for the sake of the example
          # if `true` was used, it would inject on all modules
          # but only once on 'combined' template
          # If this was in a child config, we clean it with '!**/*' or a [null]
          useStrict: ['!**/*', 'uberscore']

          # Used only on AMD modules, if you need to use
          # exports to solve [circular dependencies problems](http://requirejs.org/docs/api.html#circular)          #
          # Can be left as the default (true)
          # but lets be 'lean' and use only where needed
          injectExportsModule: ['uberscore']

          # export to root (as defined in config or in the exported module),
          # only when running as <script> or on nodejs (BUT not on AMD)
          exportsRoot: ['script', 'node']

          clean: true #['**/*']

      # The `'urequire:UMD'` task:
      #  * derives all from `'_defaults'` with the following diffs:
      #  * converts each module in `path` to UMD
      #  * everything saved at `dstPath`
      #  * adds a banner (after UMD template conversion)
      UMD:
        # `build` and `bundle` hashes are not needed
        # keys are safelly recognised, even if they're not in them.

        # 'derive' is not needed - by default it derives '_defaults'
        #   * to avoid '_defaults' use `derive:[]`
        #   * to inherit *only* from 'X', use derive: ['X']
        #'derive': ['_defaults']

        template: 'UMDplain'
        # all files converted files are written here
        dstPath: "#{buildDir}/UMD"

      # a 'combined' build, - works with or without AMD loaders
      # on Web & nodejs as a plain `<script>` or `require('dep')`
      dev:
        template:
          name: 'combined'
          # template.debugLevel (0-30) writes comments
          # while adding the sections of modules.
          # With ridiculous high values 100+ it adds `console.log`s!
          # Experimental and alpha!
          #debugLevel: 20 # just comment sections

          moduleName: 'uberscore' # SpecRunner_almondJs_moduleName_AMD.html works only with this

        # the name of the combined file instead of a directory
        # is needed for 'combined' template. Otherwise a `.js` is added
        dstPath: "#{buildDir}/uberscore-dev.js"

      # The `'urequire:min'` task :
      #  * derives all from 'dev' (& '_defaults') with the following diffs:
      #  * filters some more `filez`
      #  * converts to a single `uberscore-min.js` with `combined` template
      #  * uglifies the combined file with some `uglify2` settings
      #  * injects different deps in each module
      #  * manipulates each module:
      #     * removes some matched code 'skeletons'
      #     * replaces some deps in arrays, `require`s etc
      #     * removes some code and a dependency from a specific file.
      min:
        # derive, from dev
        # we need to specify '_defaults', in this order.
        derive: ['dev', '_defaults']

        ## 'override' this property
        dstPath: "#{buildDir}/uberscore-min.js"
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
          # An RC with the `isBeforeTemplate` '+' flag, which runs ONLY on Modules.
          # It enables you do manipulate the module's body & dependencies.
          # Note: The `m.converted` or the result from `convert()`
          # ARE NOT considered in `isBeforeTemplate` RCs,
          # we are dealing with AST code & Module dependencies only.
          [
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
                m.replaceDep 'blending/deepExtend'#, null, relative: 'bundle'
                # With `isBeforeTemplate` rcs you can also :
                #   m.injectDeps {'deps/dep1': ['depVar1', 'depVar2'], ....}
                #   m.replaceDep 'types/type', 'types/myType'
          ]
        ]

        # we can (cautiously) provide some rjs defaults https://github.com/jrburke/r.js/blob/master/build/example.build.js
        rjs: preserveLicenseComments: false

      # uRequire-ing the specs
      # We also have two builds as 'UMD' & as 'combined'
      spec:
        # disable derive-ing from '_defaults'
        derive: []
        path: "#{sourceSpecDir}"
        copy: [/./] # copy html's, requirejs.config.json et.all
        dstPath: "#{buildSpecDir}"
        commonCode: # we only need this once on each module
          "var expect = chai.expect; // injected @ `spec: bundle: commonCode`."

        # declarativelly inject these dependencies on all modules
        # @note: it gets really interesting on the `specCombined`:
        #   the deps are NOT injected in each module
        #   but their vars are available through the closure
        dependencies: exports: bundle:
          chai: 'chai'
          lodash: ['_']
          uberscore: ['_B']
          specHelpers: 'specHelpers'
          'spec-data': 'data'

        resources:[
          # `import`ing another module's `exports`
          #
          # `specHelpers` exports an object with
          # `equal`, `notEqual`,`ok`, `notOk` etc,
          # whose keys we want to import as
          # plain `var`s on each module of this bundle.
          #
          # We define 'specHelpers-imports', as a
          # fragment of code *header* that does that.
          #
          # We then use `module.mergedCode` (instead of
          # `Bundle.commonCode` or Module.beforeBody),
          # cause when the specs are 'combined' we want to
          # have these statements merged, and included
          # **only once** to save space & speed.
          #
          # Also, each module is injected an `var l`,
          # unique to each module, holding a _B.Logger
          # instance with the module's name.
          [ '+injectSpecCommons'
            ['**/*.js']
            (m)->

              # Each module, will get injected its own _B.Logger instance
              m.beforeBody = "var l = new _B.Logger('#{m.dstFilename}');"

              # injecting `mergedCode`
              # All modules will get need this same code,
              # injected on each module on UMD, AMD etc templates,
              # merged in one section for `combined` template.

              # should not add `imports` on the `export`ing module
              if (m.dstFilename isnt 'specHelpers.js')
                m.mergedCode =
                  # looking for the module "specHelpers-imports",
                  # which is of course loaded on our bundle
                  # (every module belongs to the bundle)
                  # and converted from coffee to js.
                  if specHelpersImports = (
                    _.find m.bundle.modules, (mod)->
                      mod.path is 'specHelpers-imports'
                  )
                    specHelpersImports.factoryBody
                  else
                    throw new Error "specHelpers-imports not found"

              # return nothing on `isBeforeTemplate` RCs
              null
          ]
        ]


      # deep inherits all of 'spec' BUT none of '_defaults':-)
      specCombined:
        derive: ['spec']
        dstPath: "#{buildSpecDir}_combined/index-combined.js"
        template:
          name: 'combined'
          #debugLevel: 20 # just comment sections
          # `combinedFile` not needed, it defaults to `dstPath`
          # combinedFile: "#{buildSpecDir}_combined/index-combined.js"

        # Template combined requires `main`,
        # but its not needed here, its infered:
        # if `bundle.main` is undefined it defaults to `bundle.name`
        # or 'index' or 'main' (whichever found 1st as a module)
        # with the price of a warning! In spec's case, THERE IS a module
        # 'index.js' which is picked.
        #main: 'index'

      ### Examples showing off uRequire ###

      # EXAMPLE: beautiful AMD code, using UglifyJS2 optimization
      AMD:
        template: 'AMD'
        dstPath: "#{buildDir}/AMD"
        optimize: uglify2:
          output: beautify: true
          compress: false
          mangle: false


      # EXAMPLE: how to reference (& `derive`-ing from) external urequire config file(s)
      # Its effectivelly equivalent to issuing:
      #  `$ urequire config source/code/uRequireConfig.coffee -o ./build/UMDFileConfigBuild -t UMD`
      fileConfig:
        # note: not deriving at all from '_defaults', unless its specified.
        derive: ["#{sourceDir}/code/uRequireConfig.coffee"]

        # overriding some of its parent (config file) options
        template: 'UMD'
        dstPath: "#{buildDir}/UMDFileConfigBuild"

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
        dstPath: "#{buildDir}/Logger-min.js"

      # EXAMPLE: replace a bundle dependency with another, perhaps a mock
      UMDplainReplaceDep:
        # 'UMDplain' template - no dependency on uRequire's NodeRequirer on nodejs
        template: "UMDplain"
        # save to this destination path
        dstPath: "#{buildDir}/UMDplainReplaceDep"
        dependencies: #replace 'types/isHash' with `types/isHashMock` in all modules
          replace: 'types/isHashMock': 'types/isHash'
        resources: [
          # lets create our hypothetical mock out of an existing module
          [ # a title with default flags
            "rename to 'types/isHashMock.js'"
            # a self descriptive RC.filez :-)
            ['types/isHash.js']
            # undefined `convert()` function - we only need to change the filename
            undefined

            # convFilame is a String: the `dstFilename` will change to that,
            # and all modules in bundle will now know this resource/module
            # by its new name (AND NOT the old)
            'types/isHashMock.js'
          ]
        ]

      # EXAMPLE: replace a global dependency, whether existing in module code
      AMDunderscore:
        template: 'AMD'
        dstPath: "#{buildDir}/AMDunderscore"
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
        dstPath: "#{buildDir}/UMDunderscore"
        optimize: true

      # EXAMPLE: marking as Resources, changing behaviors
      # can be used for a browserify build
      nodejsCompileAndCopy:
        template: 'nodejs'
        # the items in filez are concated AFTER the items
        # of inherited configs (i.e _defaults in this case)
        filez: ['uRequireConfig*']
        dstPath: "#{buildDir}/nodejsCompileAndCopy"
        # the default is to enclose in IFI, even for nodejs template
        # here we change default behavior
        bare: true
        # disable adding __isAMD, __isWeb & __isNode variables
        # if your code doesnt depend on them
        runtimeInfo: false
        # marking resources examples
        resources: [
          # EXAMPLE

          # compile a .coffee to .js, but dont treat as Module
          # marking a .coffee as 'TextResource' ('#' flag) compiles as .js,
          # but excludes from bing a Module (i.e no UMD/AMD template is applied)
          [ "#~markAsTextResource", ["uRequireConfig.coffee"] ]

          # read file content, alter it & save under different name
          [
            # Mark as a FileResource - its content is not read on refresh
            "@markAsFileResource"
            # matching `filez` for this RC is just one file
            ["uRequireConfig_UMDBuild.json"]
            # `convert()` function
            (r)->
              # calling read() on the resource read its content,
              # using @srcFilename within `bundle.path`
              content = '\n' + r.read()
              # save() under a different name (relative to bundle.path) & changed content
              r.save 'changedBundleFileName.json', content
          ]

          [
            '+remove:deepExtend', ['uberscore.js'], (m)->
              m.replaceCode {type: 'Property', key: {type: 'Identifier', name: 'deepExtend'}}
              m.replaceDep 'blending/deepExtend'
          ]

        ]

    watch:
      UMD:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]  # note: new subdirs dont work - https://github.com/gruntjs/grunt-contrib-watch/issues/70
        tasks: ['urequire:UMD' , 'urequire:spec', 'mocha:AMD']

      dev:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]
        tasks: ['urequire:dev', 'urequire:specCombined', 'concat:specCombinedFakeModule', 'mochaCmdDev']

      min:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]
        tasks: ['urequire:min', 'urequire:specCombined', 'concat:specCombinedFakeModuleMin', 'mochaCmdDev', 'run']

      options:
        spawn: false # WARNING: works ONLY with `spawn: false`


    shell:
      mochaCmd: command: "#{nodeBin}mocha #{buildSpecDir}/index --recursive " #--reporter spec"
      mochaCmdDev: command: "#{nodeBin}mocha #{buildSpecDir}_combined/index-combined --recursive " #--reporter spec"
      #doc: command: "#{nodeBin}codo #{sourceDir} --title 'uberscore <%= pkg.version %> API documentation' --cautious"
      run: command: "#{nodeBin}coffee source/examples/runExample.coffee"
      options: {verbose: true, failOnError: true, stdout: true, stderr: true}

    mocha:
      plainScript:
        src: [
          "#{buildSpecDir}/SpecRunner_almondJs_noAMD_plainScript.html"
          "#{buildSpecDir}/SpecRunner_almondJs_noAMD_plainScript_min.html"]
        options: run: true

      AMD: src: ["#{buildSpecDir}/SpecRunner_unoptimized_UMD.html"]
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

  for task in ['shell', 'urequire'] # shortcut to all "shell:cmd, urequire:UMD" etc
    for cmd of gruntConfig[task]
      grunt.registerTask cmd, splitTasks "#{task}:#{cmd}"

  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
     # generic shortcuts
     default:   "build test dev testDev min testMin run"
     release:   "build test dev testDev min testMin mocha urequire:AMD urequire:AMDunderscore run"
     examples:  "urequire:AMD urequire:AMDunderscore urequire:UMDplainReplaceDep urequire:UMDunderscore urequire:nodejsCompileAndCopy"
     all:       "build test dev testDev min testMin mocha examples run"
     build:     "urequire:UMD"

     test:      "urequire:spec mochaCmd"
     testDev:   "urequire:specCombined concat:specCombinedFakeModule mochaCmdDev"
     testMin:   "concat:specCombinedFakeModuleMin mochaCmdDev"

     # generic shortcuts
     cl:      "clean"
     b:       "build"
     d:       "dev"
     dm:      "min"
     m:       "mochaCmd"
     md:      "mochaCmdDev"
     t:       "test"
     td:      "testDev"
     tm:      "testMin"
     wu:      "watch:UMD"
     wd:      "watch:dev"

     # IDE shortcuts
     "alt-c": "cp"
     "alt-b": "b"
     "alt-d": "d"
     "alt-t": "t"
  }

  grunt.loadNpmTasks task for task of pkg.devDependencies when startsWith(task, 'grunt-')
  grunt.initConfig gruntConfig