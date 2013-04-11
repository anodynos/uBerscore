l = new (require '../../Logger') 'CloneBlender'
Blender = require '../Blender'
_ = require 'lodash'

###
  Todo: improvise improvement of this pattern :
###
class CloneBlender extends Blender

  constructor: (@blenderBehaviors...)->
    (@defaultBlenderBehaviors or= []).push require('../blenderBehaviors/CloneBlenderBehavior')
    super

module.exports = CloneExtendBlender

#deepExtendLike_blender = new DeepExtendBlender
#
#object =
#  constructor: 1
#  hasOwnProperty: 2
#  isPrototypeOf: 3
#
#source =
#  propertyIsEnumerable: 4
#  toLocaleString: 5
#  toString: 6
#  valueOf: 7
#
#
#l.log deepExtendLike_blender.blend {constructor: 2}, object, source
