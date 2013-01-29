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

  for k, v of oOs
    do (k, v)->
      it " recognises type '#{k}'", ->
        expect( _B.type v ).to.equal k

