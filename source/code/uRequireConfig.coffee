module.exports =
  bundlePath: 'build/code'
  outputPath: 'build/dist/uBerscore-dev.js'

#  forceOverwriteSources: true

  template: 'combine'

  verbose: true

  webRootMap: false

  exclude: ['draft/draft.js'] # everything that matches these is not proccessed

  mainName: "uBerscore"

  combine:

    method: 'rjs-almond' # default (only one for now)

    globals:
      ###
      # Array of globals that will be inlined (instead of creating a getGlobal_xxx).
      # 'true' means all
      #
      # @default undefined/false All globals are replaced with a "getGlobal_#{globalName}"
      ###
      inline: ['backbone']

      ###

        They can be infered from the code of course :-)
      ###
      varNames: { lodash: "_", underscore:"_", backbone: "Backbone" }

