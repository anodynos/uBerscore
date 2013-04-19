_ = require 'lodash'

prop1 =
    'aProp1.1': "o1.aVal1.1"
    'aProp1.2': "o1.aVal1.2"

object1 =
    aProp1: {}
    aProp2: "o1.aVal2"
object1.aProp1.__proto__ = prop1

object2 =
    aProp2: "o2.aVal2-1"
object2.__proto__ = object1

object3 =
    aProp2: "o3.aVal2-2"
    aProp3: [1,'2',3,{aProp4:"o3.aVal3"}]
object3.__proto__ = object2

objectWithProtoInheritedProps = {aProp0:"o0.aVal0"}
objectWithProtoInheritedProps.__proto__ = object3

class Class0
  constructor:->
    @aProp0 = 'o0.aVal0'

class Class1 extends Class0
    aProp1: prop1
    aProp2: "o1.aVal2"

class Class2 extends Class1
  aProp2: "o2.aVal2-1"

class Class3 extends Class2
  aProp2: "o3.aVal2-2"
  aProp3: [1,'2',3,{aProp4:"o3.aVal3"}]

c3 = new Class3

expectedPropertyValues =
  aProp0: 'o0.aVal0'
  aProp1:
    'aProp1.1': "o1.aVal1.1"
    'aProp1.2': "o1.aVal1.2"
  aProp2: "o3.aVal2-2"
  aProp3: [1,'2',3,{aProp4:"o3.aVal3"}]

# A simple object, with 2 shallow, 2 deep clones & 2 inherited
object =
  p1: 1
  p2: {p2_2: 3}

objectShallowClone1 =
  p1: 1
  p2: object.p2

objectShallowClone2 = _.clone object

objectDeepClone1 =
  p1: 1
  p2: {p2_2: 3}

objectDeepClone2 = _.clone object, true

# shallow inherited
inheritedShallowCloneParent  =  p2: object.p2
inheritedShallowClone = p1: 1
inheritedShallowClone.__proto__ = inheritedShallowCloneParent

# deep inherited
inheritedDeepCloneParent = p2: {p2_2: 3}
inheritedDeepClone = p1: 1
inheritedDeepClone.__proto__ = inheritedDeepCloneParent


data = {
  objectWithProtoInheritedProps
  Class3
  c3
  expectedPropertyValues

  # simple object with 2+2+2 clones
  object

  objectShallowClone1
  objectShallowClone2

  objectDeepClone1
  objectDeepClone2

  inheritedShallowClone
  inheritedDeepClone

  # various data
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
}

module.exports = data

