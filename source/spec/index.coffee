# uRequire : combined template must ignore these vars
_lodash_ = require 'lodash'
uberscore = require 'uberscore'

# Should be automatically generated (but its not right now!)
require "blending/Blender-spec"
require "blending/deepExtend-spec"
require "blending/lodash-merge-spec"
require "blending/Mergers_Blender-spec"
require "blending/DeepDefaultsBlender-spec"
require "blending/ArrayizePushBlender-spec"
require "blending/traverse-spec"
require "blending/clone-spec"

require "objects/getInheritedPropertyNames-spec"
require "objects/getp-spec"
require "objects/getRefs-spec"
require "objects/isDisjoint-spec"
require "objects/isEqual-spec"
require "objects/isRefDisjoint-spec"
require "objects/mutate-spec"
require "objects/okv-spec"
require "objects/setp-spec"

require "objects/isOK-True-False-spec"

require "collections/go-spec"
require "collections/array/arrayize-spec"
require "collections/array/isEqualArraySet-spec"

require "agreement/isAgree-spec"
require "types/types-spec"

require "utils/CoffeeUtils-spec"
require "utils/CalcCachedProperties-spec"

require "Logger-spec"

require "spec-data"
require "uberscore-spec"

require 'specHelpers'
