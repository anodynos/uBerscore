# works with uRequire 0.3 alpha #1
module.exports =
  verbose: true
  outputPath: './build/dist/uBerscore-dev.js'
  template: 'combine'
  exclude: [/^draft/] # everything that matches these is not proccessed
  main: "uBerscore"
  combine:
    #method: 'almond' # default (only one for now)
    globalDeps:
      varNames:
        #lodash: "_" #NOT NEEDED, implied from 'isAgree', being in AMD format
        backbone: "Backbone"  # just testing!


