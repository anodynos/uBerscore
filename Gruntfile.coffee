module.exports = (grunt)->
  gruntConfig =
    urequire:
      _all:
        dependencies:
          imports: lodash: ['_']
          paths: bower: true
          shim: true
        template: banner: true
        debugLevel: 0

      _defaults: # for lib
        main: 'uberscore'
        path: 'source/code'
        resources: [ 'inject-version' ]
        runtimeInfo: ['Logger']

      UMD:
        template: 'UMDplain'
        dstPath: 'build/UMD'

      AMD:
        template: 'AMD'
        dstPath: 'build/AMD'

      dev:
        dstPath: 'build/uberscore-dev.js'
        template:
          name: 'combined'
          moduleName: 'uberscore'

      min:
        derive: ['dev', '_defaults']
        dstPath: 'build/uberscore-min.js'
        optimize: true # 'uglify2'
        rjs: preserveLicenseComments: false
        resources: [
          [ '+remove:debug', [/./]
            (m)-> m.replaceCode c for c in ['l.deb()', 'this.l.deb()',
                                            'if (l.deb()){}', 'if (this.l.deb()){}']]
        ]

      spec:
        derive: [] # from none
        path: 'source/spec'
        dstPath: 'build/spec'
        dependencies: imports:
          chai: 'chai'
          uberscore: ['_B']
          'spec-data': 'data'
          specHelpers: 'spH'
        globalWindow: ['objects/isEqual-spec']
        resources: [
          ['import-keys',
            specHelpers: """
              equal, notEqual, ok, notOk, tru, fals, deepEqual, notDeepEqual, exact, notExact, iqual,
              notIqual, ixact, notIxact, like, notLike, likeBA, notLikeBA, equalSet, notEqualSet"""
            chai: 'expect' ]

          [ '+inject-_B.logger', ['**/*.js'],
            (m)-> m.beforeBody = "var l = new _B.Logger('#{m.dstFilename}');"]
        ]
        afterBuild: require('urequire-ab-specrunner').options
          injectCode: testNoConflict = "window._B = 'Old global `_B`'; //test `noConflict()`"

      specDev:
        derive: ['spec']
        dstPath: 'build/spec_combied/index-combined.js'
        template: name: 'combined'

      specWatch:
        derive: ['spec']
        afterBuild: [[null], require('urequire-ab-specrunner').options
          injectCode: testNoConflict
          mochaOptions: '-R dot'
          watch: 1439
        ]

    clean:
      files: ['build']
      options: force: true

  splitTasks = (tasks)-> if (tasks instanceof Array) then tasks else tasks.split(/\s/).filter((f)->!!f)
  grunt.registerTask shortCut, "urequire:#{shortCut}" for shortCut of gruntConfig.urequire
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
    default: 'clean UMD spec' # always in pairs of `lib spec`
    release: 'clean AMD spec UMD spec dev specDev min specDev'
    develop: 'clean dev specWatch'
    all: 'clean UMD spec AMD spec dev specDev min specDev UMD specDev AMD specDev dev spec min spec' # once each builds once, its rapid! So test 'em all with all!
  }

  require('load-grunt-tasks')(grunt);
  grunt.initConfig gruntConfig
