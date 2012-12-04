module.exports =
  bundlePath: 'build/code'

  forceOverwriteSources: true

  template: 'combine'

  verbose: true

  webRootMap: false

  exclude: ['draft/draft.js'] # everything that matches these is not proccessed

  mainName: "uBerscore"

  combine:
    outputFile: 'build/dist/uBerscore-dev.js'

    method: 'rjs-almond'  # default (only one for now)

    inlineGlobals: [] # Array of globals that will be inlined. 'true' means all
