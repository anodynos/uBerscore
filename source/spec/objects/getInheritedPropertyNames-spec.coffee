{ objectWithProtoInheritedProps, Class3 } = data

describe 'getInheritedPropertyNames: ', ->

  it "reads property names of __proro__ linked object hierarchy", ->
    inheritedProps = _B.getInheritedPropertyNames objectWithProtoInheritedProps
    equalSet inheritedProps, ['aProp1', 'aProp2', 'aProp3']

  it "reads property names of coffeescript class-inherited objects", ->
    equalSet _B.getInheritedPropertyNames(new Class3), [
      'aProp3'
      'aProp2'
      'aProp1'
      #'constructor' # got rid of it on getInheritedPropertyNames
    ]
