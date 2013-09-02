fs = require 'fs'
for uberscorePath in [
  'build/UMD/uberscore'
  'build/dist/uberscore-dev'
  'build/dist/uberscore-min'
  'build/UMDreplaceDep/uberscore'
  'build/UMDunderscore/uberscore'
  'build/nodejsCompileAndCopy/uberscore'
]
  try
    if fs.existsSync require.resolve('../../' + uberscorePath)
      console.log "\nabout to `require('#{uberscorePath}')`"
      try
        uberscore = require '../../' + uberscorePath
        l = new uberscore.Logger "Example '#{uberscorePath}'"
        l.log 'Global _B is', _B
        l.ok "Successfully loaded uBerscore v#{uberscore.VERSION} from: '#{uberscorePath}'"
        (if uberscore.isLodash() then l.ok else l.er) 'uberscore.isLodash() is:', uberscore.isLodash()
        value = uberscore.go(
          ((new uberscore.DeepDefaultsBlender).blend {a:1, b:5},  {a:2, b:15, c:{d:4, e:5}})
          iter: (v, k)-> l.debug k, ':', v
        )
        (if uberscore.isHash(new ->) then l.verbose else l.err).call l,
          "uberscore.isHash(new ->) is:", uberscore.isHash(new ->)
        l.log 'Lets log a value:\n', value
        l.warn 'Lets warn something: uberscore.isLike({ a: 1, c: { e: 5 } }, value):', uberscore.isLike { a: 1, c: { e: 5 } }, value
      catch err
        console.error "Error in uberscorePath #{uberscorePath}:", err
  catch err
    console.log "...missing uberscorePath #{uberscorePath}"
