module.exports =

  # @todo: use the existing ones if they're set in some SubClass ?
  order: ['src', 'dst']

  '|': # our src <--> dst spec
    Array:
      A: 'deepOverwrite' # 'A' is short for 'Array' (as also is '[]').
      '{}': 'deepOverwrite' # '[]' is type.toShort('Array') and '{}' is type.toShort('Object')
      #'*': 'deepOverwrite'
      #'Undefined': 'deepOverwrite' #todo: move to a 'CloneBlender'
                                    # note: it breaks on `dst: type(dst[prop], true)`, we need to create {}

    Object:
      O: 'deepOverwrite' # 'O' is short for 'Object' (as also is '{}').
      '[]': 'deepOverwrite'
      #'*': 'deepOverwrite'
      #'Undefined': 'deepOverwrite' #todo: move to a 'CloneBlender'

    #'Function' # todo: Aren't Functions Objects ?
                # How do we copy them ?
                # They aren't just properties - how do you clone a function ?

    "*":
      "*": 'overwrite'
