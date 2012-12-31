chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uBerscore' #
data = require '../spec-data'

compiledFiles = /.*\.(coffee|iced|coco)$/i
jsFiles = /.*\.(js|javascript)$/i

include = [jsFiles, compiledFiles, 'papari.txt']
exclude = [/.*lalakis.*/]

libs = ['file.coffee', 'lalakis.coffee', 'superlalakis.js', 'papari.txt', 'loulou.gif', 'bla.js']

describe 'inFilters ', ->
  it "a simple file inFilters 'include'", ->
    expect(
      _B.inFilters 'file.coffee', include
    ).to.be.true

  it "a simple file inFilters 'include'", ->
    expect(
      _B.inFilters 'papari.txt', include
    ).to.be.true
