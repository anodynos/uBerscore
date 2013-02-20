chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore' #

oOs = {
  'Array': ['this', 'is', 1, 'array']
  #'Arguments':# todo: test this
  'Function': (x)->x
  'String': "I am a String!"
  'Number': 667
  'Date': new Date()
  'RegExp': /./g
  'Boolean': true
  'Null': null
  'Undefined': undefined
  'Object': {a:1, b:2, toString:()->'I am not a String, I am an Object...'}
}

describe 'type :', ->

  for typeName, value of oOs
    do (typeName
        value
        longType = _B.type(value)
        shortType = _B.type(value, true)
      )->
        it "recognises type '#{typeName}', both as long='#{longType}' & short='#{shortType}'", ->
          expect( longType ).to.equal _B.type.toLong(typeName)
          expect(_B.type.isType longType ).to.be.true

          expect( shortType ).to.equal _B.type.toShort(typeName)
          expect(_B.type.isType shortType ).to.be.true

          expect( _B.type.areEqual longType, shortType).to.equal true

