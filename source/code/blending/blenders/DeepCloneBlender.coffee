Blender = require '../Blender'
_ = require 'lodash'
type = require '../../type'
isEqual = require '../../objects/isEqual'


#class Blender2 extends Blender
#  constructor: (@blenderBehaviors...)->
#    (@_optionsList or= []).unshift blender2Option: 'some value'
#    super

class DeepCloneBlender extends Blender

  constructor: (@blenderBehaviors...)->
    (@defaultBlenderBehaviors or= []).push DeepCloneBlender.behavior
    # default DeepCloneBlender options: copy __proto__ from object to object
    (@_optionsList or= []).unshift {} #no options
    super

  @behavior:
    order: ['dst', 'src']

    '|': # our 'dst <-- src' spec
      "*":
        'Array': 'deepCloneOverwrite' # 'A' is short for 'Array' (as also is '[]').
        'Object': 'deepCloneOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')
        'Function': 'deepCloneOverwrite'
        'Undefined': -> Blender.SKIP

    deepCloneOverwrite: (prop, src, dst, blender)->
      srcType = type src[prop] #src[prop] is oneOf Array, Object, Function
      dstType = type dst[prop]
      if dstType isnt srcType
        similarTypes = ['Function', 'Object']
        if not (dstType in similarTypes and srcType in similarTypes)
          dst[prop] = if srcType is 'Array' then [] else {}

      blender.deepOverwrite prop, src, dst, blender

module.exports = DeepCloneBlender

l = new (require '../../Logger') 'CloneBlender'
isRefDisjoint = require '../../objects/isRefDisjoint'
getRefs = require '../../objects/getRefs'
isIqual = require '../../objects/isIqual'
isIqual =
_B =
  isEqual: require '../../objects/isEqual'
  isIqual: require '../../objects/isIqual'
  isExact: require '../../objects/isExact'
  isIxact: require '../../objects/isIxact'

{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues } = require '../../../spec/spec-data'

defaultBlender = new Blender
deepCloneBlender = new DeepCloneBlender [] , {copyProto: true}

### fake mocha/chai style tests ###
#todo: (3 4 2) Find a way to run real specs with 'run', no full build!
hasError = false; level = 0; indent = ->("   " for i in [0..level]).join('')
describe = (msg, fn)-> l.verbose indent() + msg; level++; fn(msg); level--
it = (msg, expectedFn)->
  hasError = false; expectedFn();
  if hasError then l.warn(indent() + msg + 'false') else l.ok(indent() + msg + 'OK')
expect = (v)-> hasError = true if not v
### fake mocha/chai style tests ###

describe "Default 'Blender.blend'", ->
  describe "clones POJSO Object (no inheritance)", ->
    describe "(shallowClone = blender.blend {}, expectedPropertyValues)", ->
      shallowClone = defaultBlender.blend {}, expectedPropertyValues
      describe "is a shallow clone", ->
        it "is not RefDisjoint", ->
          expect(isRefDisjoint(shallowClone, expectedPropertyValues) is false)

        it "nested object is copied by reference", ->
          expect(shallowClone.aProp1 is expectedPropertyValues.aProp1)

        it "_.isEqual true (soft equality, same values/JSON)", ->
          expect(_.isEqual shallowClone, expectedPropertyValues)

        it "_B.isEqual true (soft equality, same values/JSON)", ->
          expect(_B.isEqual shallowClone, expectedPropertyValues)

        it "_B.isExact true (strict references equality)", ->
          expect(_B.isExact shallowClone, expectedPropertyValues)

describe "deepCloneBlender.blend:", ->
  describe "clones POJSO Object (no inheritance)", ->
    describe "(shallowClone = deepCloneBlender.blend {}, expectedPropertyValues)", ->
      shallowClone = deepCloneBlender.blend {}, expectedPropertyValues
      describe "is a shallow clone", ->
        it "is RefDisjoint (no common references in objects)", ->
          expect(isRefDisjoint(shallowClone, expectedPropertyValues))

        it "nested object is a clone it self - NOT the same reference", ->
          expect(shallowClone.aProp1 isnt expectedPropertyValues.aProp1)

        it "_.isEqual true (soft equality, same values/JSON)", ->
          expect(_.isEqual shallowClone, expectedPropertyValues)

        it "_B.isEqual true (soft equality, same values/JSON)", ->
          expect(_B.isEqual shallowClone, expectedPropertyValues)

        it "_B.isExact is false (strict references equality)", ->
          expect(_B.isExact(shallowClone, expectedPropertyValues) is false)





#
#destination = {}
#
#source1 = objectWithProtoInheritedProps
##  aProp1: ->"aProp1"
#
##  aProp2: {'aProp2.1': "aVal2.1"}
##  aProp1: ['aProp1.1': "aVal1.1"]
#
#source2 = {}
##  aProp1: [undefined, {'aProp1.1': {'aProp1.1.1': "aVal1.1.1"}}]
#clone = deepCloneBlender.blend destination, source1 #, source2
#l.log "'cloneBlender.blend destination, sources...'", clone
##l.log (p for own p of clone)
#
#l.log "'isRefDisjoint destination, sources.., deep:true'",
#    ((isRefDisjoint destination, source, {deep: true}) for source in [source1, source2])
#
#l.log "'isIqual(destination, objectWithProtoInheritedProps) is true'",
#        isIqual destination, objectWithProtoInheritedProps