chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore' #
data = require '../spec-data'

compiledFiles = /.*\.(coffee|iced|coco)$/i
jsFiles = /.*\.(js|javascript)$/i

include = [jsFiles, compiledFiles, 'papari.txt']
exclude = [/.*lalakis.*/]

libs = ['file.coffee', 'lalakis.coffee', 'superlalakis.js', 'papari.txt', 'loulou.gif', 'bla.js']

describe 'inAgreements ', ->
  it "a simple file inAgreements 'include'", ->
    expect(
      _B.inAgreements 'file.coffee', include
    ).to.be.true

  it "a simple file inAgreements 'include'", ->
    expect(
      _B.inAgreements 'papari.txt', include
    ).to.be.true
