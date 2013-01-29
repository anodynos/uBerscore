chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore' #

data = require './spec-data'
# clone to check mutability
projectDefaults = _.clone data.projectDefaults, true
globalDefaults = _.clone data.globalDefaults, true
bundleDefaults = _.clone data.bundleDefaults, true

describe 'deepExtend :', ->

  it "parentRE allows you to concatenate strings.", ->
    expect(
      _B.deepExtend(
        {url: "www.example.com"},
        {url: 'http://${_}/path/to/file.html'}
      )
    ).to.deep.equal url:"http://www.example.com/path/to/file.html"

  it """
     parentRE also acts as a placeholder, which can be useful when you need to change one value in an array, while leaving the others untouched
     """, ->
        expect(
          _B.deepExtend(
            [100,     {id: 1234}, true, "foo", [250, 500]],
            ["${_}", "${_}", false, "${_}", "${_}"]
          )
        ).to.deep.equal [100, {id: 1234}, false, "foo", [250, 500]]

  it "parentRE also acts as a placeholder, #2 ", ->
    expect(
      _B.deepExtend(
        [100,     {id:1234},  true,   "foo",    [250, 500]],
        ["${_}",  {},         false,  "${_}",   []]
      )
    ).to.deep.equal [100, {id: 1234}, false, "foo", [250, 500]]

  it "parentRE also acts as a placeholder, #3", ->
    expect(
      _B.deepExtend(
        [100,      {id:1234},   true,       "foo",    [250, 500]],
        ["${_}",   {},          false]
      )
    ).to.deep.equal [100, {id: 1234}, false, "foo", [250, 500]]

  it "Array order is important.", ->
    expect(
      _B.deepExtend(
        [1, 2, 3, 4],
        [1, 4, 3, 2]
      )
    ).to.deep.equal [1, 4, 3, 2]

  it "You can remove an array element set in a parent object by setting the same index value to null in a child object.", ->
    expect(
      _B.deepExtend(
        {arr: [1,       2,        3,  4]},
        {arr: ["${_}",  null]}
      )
    ).to.deep.equal arr: [1, 3, 4]