assert = chai.assert
expect = chai.expect

{ objectWithPrototypeInheritedProps, Class3 } = data

describe 'getInheritedPropertyNames: ', ->

  it "reads property names of __proro__ linked object hierarchy", ->
    inheritedProps = _B.getInheritedPropertyNames objectWithPrototypeInheritedProps
    expect(_B.isEqualArraySet inheritedProps, [
      'aProp1'
      'aProp2'
      'aProp3'
    ]).to.be.true

  it "reads property names of coffeescript class-inherited objects", ->
    expect(_B.isEqualArraySet _B.getInheritedPropertyNames(new Class3), [
      'aProp3'
      'aProp2'
      'aProp1'
      #'constructor' # got rid of it on getInheritedPropertyNames
    ]).to.be.true
