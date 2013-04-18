assert = chai.assert
expect = chai.expect

l = new _B.Logger 'Blender-spec', 0

{
  objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues
} = require '../../../spec/spec-data'

describe 'Mergers Blenders:', ->
  describe 'default Blender:', ->
    blender = new _.Blender
    it "shallow clones a POJSO Object", ->
      blender.blend {}, expectedPropertyValues
