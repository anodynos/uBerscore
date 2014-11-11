_ = require 'lodash'
module.exports = (grunt)->
  gruntConfig =
    urequire:
      _all:
        dependencies: imports: lodash: ['_']
        template: banner: true
        debugLevel: 0

      _defaults: # for lib
        main: 'uberscore'
        path: 'source/code'
        resources: [ 'inject-version' ]
        dependencies: paths: bower: true
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
            specHelpers: [
              'equal', 'notEqual', 'ok', 'notOk', 'tru', 'fals' , 'deepEqual', 'notDeepEqual', 'exact', 'notExact',
              'iqual', 'notIqual', 'ixact', 'notIxact', 'like', 'notLike', 'likeBA', 'notLikeBA', 'equalSet', 'notEqualSet' ]
            chai: ['expect'] ]

          [ '+inject-_B.logger', ['**/*.js'],
            (m)-> m.beforeBody = "var l = new _B.Logger('#{m.dstFilename}');"]
        ]
        afterBuild: require('urequire-ab-specrunner').options
          injectCode: testNoConflict = "window._B = 'Old global `_B`' ; //test `noConflict()`"

      specDev:
        derive: ['spec']
        dstPath: 'build/spec_combined/index-combined.js'
        template: name: 'combined'

      specWatch:
        derive: ['spec']
        watch: true
        afterBuild: [[null], require('urequire-ab-specrunner').options
          injectCode: testNoConflict
          mochaOptions: '-R dot'
        ]

    clean: files: ['build']

  _ = require 'lodash'
  splitTasks = (tasks)-> if _.isArray tasks then tasks else _.filter tasks.split /\s/
  grunt.registerTask shortCut, "urequire:#{shortCut}" for shortCut of gruntConfig.urequire
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
    default: 'UMD spec' # always in pairs of `lib spec`
    release: 'AMD spec UMD spec dev specDev min specDev'
    all: 'clean UMD spec AMD spec dev specDev min specDev UMD specDev AMD specDev dev spec min spec' # once each builds once, its rapid! So test 'em all with all!
  }
  grunt.loadNpmTasks task for task of grunt.file.readJSON('package.json').devDependencies when task.lastIndexOf('grunt-', 0) is 0
  grunt.initConfig gruntConfig