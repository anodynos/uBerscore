fs = require 'fs'
for uberscorePath in [
  'build/UMD/uberscore'
  'build/uberscore'
  'build/uberscore-min'
  'build/UMDplainReplaceDep/uberscore'
  'build/UMDunderscore/uberscore'
  'build/nodejsCompileAndCopy/uberscore'
]
  try
    if fs.existsSync require.resolve('../../' + uberscorePath)
      console.log "\nabout to `require('#{uberscorePath}')`"
      try
        delete global._B
        delete global.uberscore
        ubs = require '../../' + uberscorePath
        l = new ubs.Logger "Example '#{uberscorePath}'"
        l.log 'Global _B is', _B
        l.log 'Global uberscore is', uberscore
        l.log 'local ubs is', ubs
        l.log 'Global === local', ubs is uberscore

        l.ok "Successfully loaded uBerscore v#{ubs.VERSION} from: '#{uberscorePath}'"
        (if ubs.isLodash() then l.ok else l.warn) 'ubs.isLodash() is:', ubs.isLodash()
        value = ubs.go(
          ((new ubs.DeepDefaultsBlender).blend {a:1, b:5},  {a:2, b:15, c:{d:4, e:5}})
          iter: (v, k)-> l.deb k, ':', v
        )
        (if ubs.isHash(new ->) then l.verbose else l.err).call l,
          "ubs.isHash(new ->) is:", ubs.isHash(new ->)
        l.log 'Lets log a value:\n', value
        l.warn 'Lets warn something: ubs.isLike({ a: 1, c: { e: 5 } }, value):', ubs.isLike { a: 1, c: { e: 5 } }, value
      catch err
        console.error "\u001b[31m Error in uberscorePath #{uberscorePath}:", err, '\u001b[0m'
  catch err
    console.log "...missing uberscorePath #{uberscorePath}"
