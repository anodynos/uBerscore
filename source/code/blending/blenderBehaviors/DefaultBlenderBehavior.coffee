###
 The default behavior is to overwrite all keys of destination
 with the respective value of source.

 When destination is a `Primitive` or `Undefined`, we simply overwrite it
 with either the (primitive) value or reference (for Object types)

 When destination is an Object (reference type, with nested keys),
 and source also happens to be an Object as well, then we 'merge',
 i.e we deepOverwrite.
###
module.exports =

  order: ['dst', 'src']

  '|': # our 'dst <-- src' spec

    # When destination is a `Primitive` or `Undefined`, we simply overwrite it
    # with either the (primitive) value or reference (for Object types)
    "*": "*": 'overwrite' # this is the default case

    # When destination is an Object (reference type, with nested keys),
    # and source also happens to be an Object as well, then we 'merge',
    # i.e we deepOverwrite.
    Array:
      Array: 'deepOverwrite' # 'A' is short for 'Array' (as also is '[]').
      Object: 'deepOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')
      Function: 'deepOverwrite'
    Object:
      Object: 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
      Array: 'deepOverwrite'
      Function: 'deepOverwrite'



#  # @todo: use the existing ones if they're set in some SubClass ?
#  order: ['src', 'dst']
#
#  '|': # our src <--> dst spec
#    Array:
#      A: 'deepOverwrite' # 'A' is short for 'Array' (as also is '[]').
#      '{}': 'deepOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')
#      #'*': 'deepOverwrite'
#      #'Undefined': 'deepOverwrite' #todo: move to a 'CloneBlender'
#                                    # note: it breaks on `dst: type(dst[prop], true)`, we need to create {}
#
#    Object:
#      O: 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
#      '[]': 'deepOverwrite'
#      #'*': 'deepOverwrite'
#      #'Undefined': 'deepOverwrite' #todo: move to a 'CloneBlender'
#
#    #'Function' # todo: Aren't Functions Objects ?
#                # How do we copy them ?
#                # They aren't just properties - how do you clone a function ?
#
#    "*":
#      "*": 'overwrite'

