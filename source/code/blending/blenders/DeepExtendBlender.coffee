l = new (require '../../Logger') 'DeepExtendBlender'
Blender = require '../Blender'
_ = require 'lodash'

###
  Todo: improvise improvement of this pattern :
###
class DeepExtendBlender extends Blender

  constructor: (@blenderBehaviors...)->
    (@defaultBlenderBehaviors or= []).push require('../blenderBehaviors/DeepExtendBlenderBehavior')
    super

module.exports = DeepExtendBlender

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
