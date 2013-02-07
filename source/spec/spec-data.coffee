data =
  obj: ciba: 4, aaa: 7, b: 2, c: -1
  arrInt: [ 4, 7, 2, -1 ]
  arrInt2: [7, -1, 3, 5]
  arrStr: ['Pikoulas', 'Anodynos', 'Babylon', 'Agelos']


  globalDefaults:
    'enabled': true
    'bundleRoot': '/global'
    'compilers':
  #    'coffee-script':
  #      params: true
  #    'urequire': enabled: true
      'rjs-build': 'global-rjs'

  projectDefaults:
    'bundleRoot': '/global/project'
    'compilers':
      'rjs-build': 'project-rjs-build'

  bundleDefaults:
    'bundleRoot': '/global/project/bundle'
    'compilers':
      'coffee-script':
        'params': 'w b'
      'urequire':
        'scanPrevent': true


module.exports = data

