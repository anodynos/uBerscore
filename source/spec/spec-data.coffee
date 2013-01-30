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


  persons: [
    {
      name: "agelos"
      male:true
    }

    {name: "AnoDyNoS"}
  ]

  personDetails: [
    {
      age: 37
      familyState:
        married:false
    }

    {age: 33}
  ]

  personDetails2: [
    {
      surname: 'Peakoulas',
      name: "Agelos"
      age: 42
      address:
        street:'1 Peak Str'
        country: "Earth"
      familyState:
        married: true
        children: 3
    }

    {
      job: "Dreamer, developer, doer"
      familyState:
        married:false
        children:0
    }
  ]

module.exports = data

