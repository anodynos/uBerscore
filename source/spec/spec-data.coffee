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
    aProp3: [1, '2', 3, {aProp4:"o3.aVal3"}]
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
  aProp3: [1, '2', 3, {aProp4:"o3.aVal3"}]

c3 = new Class3

expectedPropertyValues =
  aProp0: 'o0.aVal0'
  aProp1:
    'aProp1.1': "o1.aVal1.1"
    'aProp1.2': "o1.aVal1.2"
  aProp2: "o3.aVal2-2"
  aProp3: [1,'2',3,{aProp4:"o3.aVal3"}]

### Inheritance (simple): A simple object, with :
   - 2 shallow clones,
   - 2 deep clones
   - 2 inherited
###
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

### Defaults deep merging: the experiment.

    We have 3 environments, each with its own defaults.

    They range from generic 'earth', specilizing to the 'laboratory' and finally the fine-tuned 'laboratory'.

    We blend them in different ways to see what comes out.
###
earth =
  name: 'earthDefaults'

  environment:
    temperature: 20
    gravity: 9.80
    moisture:
      min: 10

  life: true

laboratory =
  name: 'laboratoryDefaults'

  environment:
    temperature: 35
    moisture:
      max: 40

  life:
    races: ['Caucasian', 'African', 'Asian']
    people: [
      { 'name': 'moe', 'age': 40 }
      { 'name': 'larry', 'age': 50 }
    ]

experiment =
  name: 'experimentDefaults'

  environment:
    gravity: 1.5
    temperature: null

  life:
    races: ['Kafkasian', 'ApHriCan', 'Azian', 'Mutant']
    people: [
      { 'name': 'moe', 'age': 40 }
      { 'name': 'blanka', 'age': 20 }
      { 'name': 'ken', 'age': 25 }
      { 'name': 'ryu', 'age': 28 }
      { 'name': 'larry', 'age': 50 }
    ]
  results:success:false

### Results (for _B.DeepDefaultsBlender.blend) ###
earth_laboratory_experiment = # earth is 1st (more important) than laboratory & experiment. Earth's default prevail.
  name: 'earthDefaults'       # <-- by earth(was undefined)
  environment:
    temperature: 20           # <-- by earth(was undefined)
    gravity: 9.80             # <-- by earth(was undefined)
    moisture:                 # <-- by earth(was undefined)
      min: 10                 # <-- by earth(was undefined)
      max: 40                 # <-- by laboratory(was undefined)
  life: true                  # <-- by earth(was undefined)
  results:success:false       # <-- by experiment (was undefined)

experiment_laboratory_earth = # experiment is 1st (more important) than laboratory & earth
  name: 'experimentDefaults'  # <-- by experiment (was undefined)

  environment:
    gravity: 1.5              # <-- by experiment (was undefined)
    temperature: 35           # <-- added by laboratory (was null)
    moisture:
      max: 40                 # <-- added by laboratory (was undefined)
      min: 10                 # <-- added by earth (was undefined)

  life:                       # <-- by experiment (was undefined)
    races: ['Kafkasian', 'ApHriCan', 'Azian', 'Mutant']

    people: [                 # <-- by experiment (was undefined)
      { 'name': 'moe', 'age': 40 }
      { 'name': 'blanka', 'age': 20 }
      { 'name': 'ken', 'age': 25 }
      { 'name': 'ryu', 'age': 28 }
      { 'name': 'larry', 'age': 50 }
    ]
  results:success:false       # <-- by experiment (was undefined)


laboratory_experiment = # laboratory is 1st (more important) than experiment
  name: 'laboratoryDefaults'  # <-- by experiment (was undefined)

  environment:
    gravity: 1.5              # <-- by experiment (was undefined)
    temperature: 35           # <-- added by laboratory (was null)
    moisture:
      max: 40                 # <-- added by laboratory (was undefined)

  life:                       # <-- by experiment (was undefined)
    races: ['Caucasian', 'African', 'Asian', 'Mutant'] # <-- retained at index 0,1,2 from laboratory (not was undefined)

    people: [                 # <-- merged with experiment (was undefined)
      { 'name': 'moe', 'age': 40 }    # <-- retained from laboratory (not was undefined)
      { 'name': 'larry', 'age': 50 }  # <-- retained from laboratory (not was undefined)
      { 'name': 'ken', 'age': 25 }
      { 'name': 'ryu', 'age': 28 }
      { 'name': 'larry', 'age': 50 }
    ]
  results:success:false       # <-- by experiment (was undefined)

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

  ### The experiment ###
  earth
  laboratory
  experiment
  earth_laboratory_experiment
  experiment_laboratory_earth
  laboratory_experiment

  ### Defaults merging ###
  team:
    'enabled': true
    'bundleRoot': '/team'
    'compilers':
  #    'coffee-script':
  #      params: true
  #    'urequire': enabled: true
      'rjs-build': 'team-rjs'

  project:
    'bundleRoot': '/team/project'
    'compilers':
      'rjs-build': 'project-rjs-build'

  bundle:
    'bundleRoot': '/team/project/bundle'
    'compilers':
      'coffee-script':
        'params': 'w b'
      'urequire':
        'scanPrevent': true

  ### Results ###
  bundle_project_team:
    'enabled': true
    'bundleRoot': '/team/project/bundle'
    'compilers':
      'coffee-script':    # <- changed by someBundle
        'params': 'w b'
      'urequire':         # <- changed by someBundle
        'scanPrevent': true
      'rjs-build': 'project-rjs-build'  # <- changed by project




}

module.exports = data

