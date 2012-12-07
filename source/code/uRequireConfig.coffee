
bundle =
  verbose: true
  #bundlePath: './source/code' # implied by config's position
  outputPath: './build/dist/uBerscore-dev.js'

#  forceOverwriteSources: true

  template: 'combine'

  webRootMap: false

  exclude: [/^draft/] # everything that matches these is not proccessed

  mainName: "uBerscore"

  exports:
    # { varName:dep *}
    # Each dep will be available in the whole bundle under varName
    bundleVars:
      '_': 'underscore'
      'persons': 'models/PersonModel'
      'personView': 'views/PersonView'

    root: ''# works only on Browser

  combine:

    method: 'almond' # default (only one for now)

    globals:

      ###
      # Array of globals that will be inlined (instead of creating a getGlobal_xxx).
      # 'true' means all
      #
      # @default undefined/false All globals are replaced with a "getGlobal_#{globalName}"
      ###
      inline: ['backbone']

      ###
        They can be infered from the code of course (AMD only for now)
        Required here in case they are missing, or to override var name used in modules.
      ###
      varNames:
        lodash: "_"
        underscore: "_"
        backbone: "Backbone"


module.exports = bundle