prop1 =
    'aProp1.1': "o1.aVal1.1"
    'aProp1.2': "o1.aVal1.2"

object1 =
    aProp1:{}

    aProp2: "o1.aVal2"

object2 =
    aProp2: "o2.aVal2-1"

object3 =
    aProp2: "o3.aVal2-2"
    aProp3: "o3.aVal3"

objectWithPrototypeInheritedProps = {aProp0:"o0.aVal0"}
objectWithPrototypeInheritedProps.__proto__ = object3
object3.__proto__ = object2
object2.__proto__ = object1
object1.aProp1.__proto__ = prop1

class Class0
  constructor:->
    aProp0: 'o0.aVal0'

class Class1 extends Class0
    @prop1: prop1
    aProp2: "o1.aVal2"

class Class2 extends Class1
  aProp1:{}
  aProp2: "o2.aVal2-1"

class Class3 extends Class2
  aProp2: "o3.aVal2-2"
  aProp3: "o3.aVal3"

c3 = new Class3

expectedPropertyValues =
  aProp0: 'o0.aVal0'
  aProp1:
    'aProp1.1': "o1.aVal1.1"
    'aProp1.2': "o1.aVal1.2"
  aProp2: "o3.aVal2-2"
  aProp3: "o3.aVal3"

data =
  objectWithPrototypeInheritedProps: objectWithPrototypeInheritedProps
  Class3: Class3
  expectedPropertyValues: expectedPropertyValues

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

